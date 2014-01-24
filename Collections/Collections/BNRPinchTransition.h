//
//  BNRPinchTransition.h
//  FieldTech
//
//  Created by Stephen Christopher on 1/18/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNRInteractor <NSObject, UIViewControllerInteractiveTransitioning>

- (BOOL)isInteractive;

/* Retain navigation controller and view controller as needed.
 * Call into register interaction on view. Caller also supplies
 * the desired operation for when interaction starts. If the 
 * operation is a push, the toViewController must also be supplied. */
- (void) addInteractorToViewController:(UIViewController *)currentVC
                          forOperation:(UINavigationControllerOperation)operation
                      toViewController:(UIViewController *)toVC;

- (void) removeInteractorFromViewController:(UIViewController *)vc;

@end

@interface BNRPinchTransition : UIPercentDrivenInteractiveTransition <BNRInteractor>

@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
@property (nonatomic, strong) UIGestureRecognizer *gestureRecognizer;

@end
