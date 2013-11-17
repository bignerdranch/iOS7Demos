//
//  BNRSimpleVC.m
//  Collections
//
//  Created by Stephen Christopher on 11/16/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRSimpleVC.h"

#define DURATION 1.0

@interface BNRSimpleVC () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation BNRSimpleVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *fromVC = [segue sourceViewController];
    UINavigationController *navVC = [fromVC navigationController];
    navVC.delegate = self;
}

#pragma mark - Navigation Delegate

// Report who is in charge of the animation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self;
}

#pragma mark - animate the transition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = transitionContext.containerView;

	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *toView = toVC.view;

    UIView *snapshot = [toView snapshotViewAfterScreenUpdates:YES];
    [snapshot setAlpha:0.0];

    // Add the snapshot!
    [container addSubview:snapshot];
    [UIView animateWithDuration:DURATION
                     animations:^(){
                         [snapshot setAlpha:1.0];
                     } completion:^ (BOOL finished) {

                         // Demo: Important to add this
                         [container addSubview:toView];

                         [transitionContext completeTransition:YES];
                     }];
}


@end
