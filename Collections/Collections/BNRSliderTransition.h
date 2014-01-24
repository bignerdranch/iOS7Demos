//
//  BNRSliderTransition.h
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BNRPinchTransition.h"

@interface BNRSliderTransition : UIPercentDrivenInteractiveTransition <BNRInteractor>

@property (nonatomic, assign, getter = isInteractive) BOOL interactive;

// Doesn't fit the BNR Interactor pattern as well, since it needs
// a reference directly to the UI element that will drive it.
@property (nonatomic, strong) UISlider *slider;

@end
