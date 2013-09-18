//
//  BNRViewController.m
//  WrongPong
//
//  Created by Jonathan Blocksom on 9/16/13.
//  Copyright (c) 2013 Jonathan Blocksom. All rights reserved.
//

#import "BNRViewController.h"

@interface BNRViewController() <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIView *ballView;
@property (strong, nonatomic) UIView *paddleView;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *pusher;
@property (nonatomic, strong) UICollisionBehavior *collider;
@property (nonatomic, strong) UIDynamicItemBehavior *paddleDynamicProperties;
@property (nonatomic, strong) UIDynamicItemBehavior *ballDynamicProperties;
@property (nonatomic, strong) UIAttachmentBehavior *attacher;

@end

@implementation BNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect ballFrame = CGRectMake(100.0, 100.0, 64.0, 64.0);
    self.ballView = [[UIView alloc] initWithFrame:ballFrame];
    self.ballView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.ballView];
    
    CGRect paddleFrame = CGRectMake(75.0, 300.0, 128.0, 64.0);
    self.paddleView = [[UIView alloc] initWithFrame:paddleFrame];
    self.paddleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.paddleView];
    
    // Reset with double tap gesture
    UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reset)];
    doubleTapGR.numberOfTapsRequired = 2;
    doubleTapGR.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapGR];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGR];
    
    // Better ball and paddle graphics
    self.ballView.layer.cornerRadius = 32.0;
    self.ballView.layer.borderColor = [UIColor blackColor].CGColor;
    self.ballView.layer.borderWidth = 2.0;
    self.ballView.layer.shadowOffset = CGSizeMake(5.0, 8.0);
    self.ballView.layer.shadowOpacity = 0.5;
    self.ballView.layer.contents = (__bridge id)[UIImage imageNamed:@"bnr_hat_only"].CGImage;
    
    self.paddleView.layer.cornerRadius = 8.0;
    self.paddleView.layer.borderWidth = 2.0;
    self.paddleView.layer.borderColor = [UIColor blackColor].CGColor;
    self.paddleView.layer.shadowOffset = CGSizeMake(5.0, 8.0);
    self.paddleView.layer.shadowOpacity = 0.5;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self initBehaviors];
}

- (void)initBehaviors
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
                                                   mode:UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.5, 1.0);
    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
    [self.animator addBehavior:self.pusher];

    // Step 1: Add collisions
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collider];

    // Step 2: Remove rotation
    self.ballDynamicProperties = [[UIDynamicItemBehavior alloc]
                                  initWithItems:@[self.ballView]];
    self.ballDynamicProperties.allowsRotation = NO;
    [self.animator addBehavior:self.ballDynamicProperties];
    
    self.paddleDynamicProperties = [[UIDynamicItemBehavior alloc]
                                    initWithItems:@[self.paddleView]];
    self.paddleDynamicProperties.allowsRotation = NO;
    [self.animator addBehavior:self.paddleDynamicProperties];

    // Step 3: Heavy paddle
    self.paddleDynamicProperties.density = 1000.0f;

    // Step 4: Better collisions, no friction
    self.ballDynamicProperties.elasticity = 1.0;
    self.ballDynamicProperties.friction = 0.0;
    self.ballDynamicProperties.resistance = 0.0;
 
    // Step 5: Move paddle
    self.attacher =
        [[UIAttachmentBehavior alloc]
         initWithItem:self.paddleView
         attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddleView.frame),
                                      CGRectGetMidY(self.paddleView.frame))];
    [self.animator addBehavior:self.attacher];
}

- (void)tapped:(UIGestureRecognizer *)gr
{
    self.attacher.anchorPoint = [gr locationInView:self.view];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.animator = nil;
    self.collider = nil;
    self.pusher = nil;
}

- (void)reset
{
    [self.animator removeAllBehaviors];
    self.collider = nil;
    self.pusher = nil;
    self.ballDynamicProperties = nil;
    self.paddleDynamicProperties = nil;
    self.attacher = nil;

    self.ballView.frame = CGRectMake(100.0, 100.0, 64.0, 64.0);
    self.paddleView.frame = CGRectMake(75.0, 300.0, 128.0, 64.0);
    
    [self initBehaviors];
}

/*
 - (void)collisionBehavior:(UICollisionBehavior*)behavior
 beganContactForItem:(id <UIDynamicItem>)item1
 withItem:(id <UIDynamicItem>)item2
 atPoint:(CGPoint)p
 {
 NSLog(@"bonk! item1 %@ item2 %@\nvelocity1 = %@, velocity2 = %@", item1, item2,
 NSStringFromCGPoint([self.dib linearVelocityForItem:item1]),
 NSStringFromCGPoint([self.dib linearVelocityForItem:item2]));
 }
 
 - (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier atPoint:(CGPoint)p
 {
 NSLog(@"bonk! item %@\nvelocity = %@", item,
 NSStringFromCGPoint([self.dib linearVelocityForItem:item]));
 }
 */

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

