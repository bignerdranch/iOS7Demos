#import "RMZoomAnimator.h"

#define TRANSITION_DURATION 1.0

@interface RMZoomAnimator () 
@end

@implementation RMZoomAnimator

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
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
    UIView *container = [transitionContext containerView];

	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;

    CGRect largeFrame = container.bounds;
    CGRect smallFrame = CGRectMake(self.initialZoomPoint.x, self.initialZoomPoint.y, 1.0, 1.0);


    /* (spc/2013-09-19) TODO: There's got to be a better way than checking the
     * specific class, but toVC.isBeingPresented isn't it. That only works for
     * modal, and apparently only accidentally there. topViewController for 
     * Navigation Controller doesn't help, that's always toVC. */
    BOOL transitionForward = ([toVC.navigationController.viewControllers containsObject:fromVC]);
    CGRect finalFrame = transitionForward ? largeFrame : smallFrame;
    UIView *animatedView = transitionForward ? toView : fromView;

    toView.frame = largeFrame;
    animatedView.frame = largeFrame;

    if (!transitionForward) {
        [container addSubview:toView];
        [fromView removeFromSuperview];
    }

    UIView *snapshot = [animatedView snapshotViewAfterScreenUpdates:YES];
    snapshot.frame = transitionForward ? smallFrame : largeFrame;

    [container addSubview:snapshot];

    // Set up our spring
    CGFloat damping = transitionForward ? 500 : 200;
    CGFloat velocity = transitionForward ? 10 : 1;

    // Try this for extra springiness
//    damping = transitionForward ? 0.5 : 0.3;
//    velocity = transitionForward ? -10 : 15;



    [UIView animateWithDuration:TRANSITION_DURATION delay:0.0
         usingSpringWithDamping:damping initialSpringVelocity:velocity options:0
                     animations:^{
                         snapshot.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         [snapshot removeFromSuperview];

                         if (transitionForward) {
                             [container addSubview:toView];
                             [fromView removeFromSuperview];
                         }

                         [transitionContext completeTransition: YES];
                     }];

}



@end
