#import <Foundation/Foundation.h>

@interface RMZoomAnimator : NSObject <UIViewControllerTransitioningDelegate,
UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic) CGPoint initialZoomPoint;

@end
