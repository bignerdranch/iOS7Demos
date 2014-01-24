//
//  BNRBaseInteractor.h
//  Collections
//
//  Created by Stephen Christopher on 1/23/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRBaseInteractor : NSObject <UIViewControllerInteractiveTransitioning>

/* Base class implementation of this will usually be sufficient.
 * It will call into registerInteractionOnView: so subclasses
 * can add their specific means of control. */
- (void) addInteractorToViewController:(UIViewController *)vc;

/* Subclasses must override the prepareInteraction method
 * and add their gesture or other means of control. */
- (void) registerInteractionOnView:(UIView *)view;

@end
