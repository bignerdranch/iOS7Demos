#import "BNRCustomCollectionVC.h"


#define TRANSITION_DURATION 1.0

@interface BNRCustomCollectionVC () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation BNRCustomCollectionVC

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UIViewController *toVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"modalVC"];

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
    UIView *container = transitionContext.containerView;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect fromFrame = [transitionContext initialFrameForViewController:toVC];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGPoint center = fromVC.view.center;
    CGRect shrunkBounds = CGRectInset(fromVC.view.bounds, 40.0, 40.0);
    toView.frame = toFrame;
    [container addSubview:toView];
    [UIView animateWithDuration:TRANSITION_DURATION
                     animations: ^{
                         toView.center = center;
                         toView.bounds = shrunkBounds;
                     }
                     completion: ^(BOOL finished) {
                         [transitionContext completeTransition: YES];
                     }];
//    [transitionContext completeTransition:YES];
}

@end
