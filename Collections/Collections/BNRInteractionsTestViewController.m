//
//  BNRInteractionsTestViewController.m
//  Collections
//
//  Created by Stephen Christopher on 1/22/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRInteractionsTestViewController.h"

#import "BNRFunkyNavigationDelegate.h"

@interface BNRInteractionsTestViewController ()

@property (nonatomic, strong) BNRFunkyNavigationDelegate *navDelegate;

@end

@implementation BNRInteractionsTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.navDelegate) {
        self.navDelegate = [BNRFunkyNavigationDelegate new];
    }
    self.navigationController.delegate = self.navDelegate;
}

- (void)segmentedControlDidChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.navDelegate activateSliderInteractionWithSlider:self.slider];
            break;
        case 1:
            [self.navDelegate activatePinchInteraction];
            break;
        case 2:
            [self.navDelegate activateShakeInteraction];
            break;
    }
}

- (IBAction)animatedSelectorDidChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.navDelegate activateFadeTransition];
            break;
        case 1:
            [self.navDelegate activateZoomTransition];
    }
}

@end
