//
//  BNRFadeAnimator.m
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRFadeAnimator.h"

#define DURATION 1.0

@interface BNRFadeAnimator () 

@end

@implementation BNRFadeAnimator

#pragma mark - animate the transition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = transitionContext.containerView;

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
                         if ([transitionContext transitionWasCancelled]) {
                             [snapshot removeFromSuperview];
                             [transitionContext completeTransition:NO];
                             return;
                         }
                         // Demo: Important to add this
                         [container addSubview:toView];

                         [transitionContext completeTransition:YES];
                     }];
}

@end
