//
//  BNRPinchTransition.m
//  FieldTech
//
//  Created by Stephen Christopher on 1/18/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRPinchTransition.h"

@interface BNRPinchTransition () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic) UINavigationControllerOperation operation;
@property (nonatomic, strong) UIViewController *toVC;

@property (nonatomic) CGFloat firstScale;
@property (nonatomic) CGFloat lastPercent;

@end

@implementation BNRPinchTransition

- (void)addInteractorToViewController:(UIViewController *)currentVC
                         forOperation:(UINavigationControllerOperation)operation
                     toViewController:(UIViewController *)toVC
{
    self.navController = currentVC.navigationController;
    self.operation = operation;
    self.toVC = toVC;

    UIPinchGestureRecognizer *pinchRecognizer =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    [currentVC.view addGestureRecognizer:pinchRecognizer];
    self.gestureRecognizer = pinchRecognizer;
}

- (void)removeInteractorFromViewController:(UIViewController *)vc
{
    [vc.view removeGestureRecognizer:self.gestureRecognizer];
    self.gestureRecognizer = nil;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;

    switch (pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            self.firstScale = scale;
            [self startTransition];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percentComplete = ((scale/self.firstScale) - 1.0) / 2.0;
            percentComplete = (percentComplete > 0.0) ? percentComplete : 0.0; // Don't let it go below 0
            self.lastPercent = percentComplete;
            NSLog(@"last Percent is %f", self.lastPercent);
            [self updateInteractiveTransition:percentComplete];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.interactive = NO;
            [self cancelInteractiveTransition];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.interactive = NO;
            if (self.lastPercent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateFailed:
            break;
    }
}

- (void)startTransition
{
    if (self.operation == UINavigationControllerOperationPop) {
        [self.navController popViewControllerAnimated:YES];
    }

    if (self.operation == UINavigationControllerOperationPush && self.toVC) {
        [self.navController pushViewController:self.toVC animated:YES];
    }
}

@end
