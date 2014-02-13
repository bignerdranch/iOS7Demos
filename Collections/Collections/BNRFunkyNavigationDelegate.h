//
//  BNRFunkyNavigationDelegate.h
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRFunkyNavigationDelegate : NSObject <UINavigationControllerDelegate>

- (void)activatePinchInteraction;
- (void)activateShakeInteraction;
- (void)activateSliderInteractionWithSlider:(UISlider *)slider;

- (void)activateFadeTransition;
- (void)activateZoomTransition;

@end
