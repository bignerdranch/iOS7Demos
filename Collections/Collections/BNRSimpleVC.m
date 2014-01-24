//
//  BNRSimpleVC.m
//  Collections
//
//  Created by Stephen Christopher on 11/16/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRSimpleVC.h"

#import "BNRFadeAnimator.h"


@interface BNRSimpleVC () <UINavigationControllerDelegate>

@property (nonatomic, strong) BNRFadeAnimator *fadeAnimator;

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
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (!self.fadeAnimator) {
        self.fadeAnimator = [BNRFadeAnimator new];
    }
    return self.fadeAnimator;
}

@end
