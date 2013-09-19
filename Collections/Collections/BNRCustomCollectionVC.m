#import "BNRCustomCollectionVC.h"
#import "BNRModalVC.h"


#define TRANSITION_DURATION 1.0

@interface BNRCustomCollectionVC () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation BNRCustomCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // DEMO: Stop underlapping tab bar bottom
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                forIndexPath:indexPath];

    // DEMO: get a nice color palette so we have unique cells
    UIColor *color = [UIColor colorWithRed: (((int)cell >> 0) & 0xFF) / 255.0
                                     green: (((int)cell >> 8) & 0xFF) / 255.0
                                      blue: (((int)cell >> 16) & 0xFF) / 255.0
                                     alpha: 1.0];
    [cell setBackgroundColor:color];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNRModalVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"modalVC"];

    // DEMO: Use our cell's color
    UIColor *color = [[collectionView cellForItemAtIndexPath:indexPath] backgroundColor];
    [toVC.view setBackgroundColor:color];

    // DEMO: Once more with content
    NSString *numberString = [NSString stringWithFormat:@"I'm number %i!", indexPath.row];
    [toVC.centerLabel setText:numberString];

    toVC.transitioningDelegate = self;
    toVC.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:toVC animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	NSIndexPath *selected = self.collectionView.indexPathsForSelectedItems[0];
	UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:selected];
	
    UIView *container = transitionContext.containerView;
	
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

	CGRect beginFrame = [container convertRect:cell.bounds fromView:cell];
    CGRect endFrame = [transitionContext initialFrameForViewController:fromVC];

    // DEMO: Remove this line for full screen goodness
//	endFrame = CGRectInset(endFrame, 40.0, 40.0);

	UIView *move = nil;
	if (toVC.isBeingPresented) {
		toView.frame = endFrame;
		move = [toView snapshotViewAfterScreenUpdates:YES];
		move.frame = beginFrame;
		cell.hidden = YES;
	} else {
        BNRModalVC *modalVC = (BNRModalVC *)fromVC;
        [modalVC.centerLabel setAlpha:0.0];
		move = [fromView snapshotViewAfterScreenUpdates:YES];
		move.frame = fromView.frame;
		[fromView removeFromSuperview];
	}
    [container addSubview:move];
	
	[UIView animateWithDuration:TRANSITION_DURATION delay:0
         usingSpringWithDamping:500 initialSpringVelocity:15
                        options:0 animations:^{
                            move.frame = toVC.isBeingPresented ?  endFrame : beginFrame;}
                     completion:^(BOOL finished) {
                         if (toVC.isBeingPresented) {
                             [move removeFromSuperview];
                             toView.frame = endFrame;
                             [container addSubview:toView];
                         } else {
                             cell.hidden = NO;
                         }

                         [transitionContext completeTransition: YES];
                     }];
}

@end
