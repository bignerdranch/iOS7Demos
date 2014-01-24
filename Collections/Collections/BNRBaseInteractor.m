//
//  BNRBaseInteractor.m
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRBaseInteractor.h"

@interface BNRBaseInteractor ()

@end

@implementation BNRBaseInteractor

- (void)addInteractorToViewController:(UIViewController *)vc
{

}

- (void)registerInteractionOnView:(UIView *)view
{
    NSAssert(FALSE, @"Subclasses must override");
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return;
}

@end
