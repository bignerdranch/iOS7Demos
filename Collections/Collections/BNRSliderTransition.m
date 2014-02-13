//
//  BNRSliderTransition.m
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRSliderTransition.h"

@interface BNRSliderTransition ()

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic) UINavigationControllerOperation operation;
@property (nonatomic, strong) UIViewController *toVC;

@end

@implementation BNRSliderTransition

- (void)setSlider:(UISlider *)slider
{

    // TODO: remove side effect. Right now setSlider has to be called
    // before addInteractor can be called.
    _slider = slider;
    [self connectTargetActionForSlider:_slider];
}

- (void)sliderDidChange:(UISlider *)sender
{
    NSLog(@"slider transition");
    if (!self.isInteractive) {
        self.interactive = YES;
        [self bnr_startTransition];
        return;
    }

    CGFloat sliderValue = sender.value;
    [self updateInteractiveTransition:sliderValue/100.0];
}

- (void)sliderFinishedSliding:(UISlider *)sender
{
    CGFloat sliderValue = sender.value;
    BOOL cancelValue = (sliderValue < 50);
    BOOL finishValue = (sliderValue >= 50);

    if (cancelValue) {
        self.interactive = NO;
        [self cancelInteractiveTransition];
    } else if (finishValue) {
        self.interactive = NO;
        [self finishInteractiveTransition];
    }
}

- (void)bnr_startTransition
{
    if (self.operation == UINavigationControllerOperationPop) {
        [self.navController popViewControllerAnimated:YES];
    }

    if (self.operation == UINavigationControllerOperationPush && self.toVC) {
        [self.navController pushViewController:self.toVC animated:YES];
    }
}

- (void)connectTargetActionForSlider:(UISlider *)slider
{
    [self.slider addTarget:self
                    action:@selector(sliderDidChange:)
          forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self
                    action:@selector(sliderFinishedSliding:)
          forControlEvents:UIControlEventTouchUpInside];
    // TODO: should handled canceled touches and touch up outside also

}

- (void)addInteractorToViewController:(UIViewController *)currentVC
                         forOperation:(UINavigationControllerOperation)operation
                     toViewController:(UIViewController *)toVC
{
    self.navController = currentVC.navigationController;
    self.operation = operation;
    self.toVC = toVC;
}

- (void)removeInteractorFromViewController:(UIViewController *)vc
{
    [self.slider removeTarget:self
                       action:@selector(sliderDidChange:)
             forControlEvents:UIControlEventValueChanged];
    [self.slider removeTarget:self
                       action:@selector(sliderFinishedSliding:)
             forControlEvents:UIControlEventTouchUpInside];

}

@end
