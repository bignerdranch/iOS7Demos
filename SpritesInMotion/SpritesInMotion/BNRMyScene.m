//
//  BNRMyScene.m
//  SpritesInMotion
//
//  Created by Bolot Kerimbaev on 9/17/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRMyScene.h"

@interface SKColor (RandomColor)
+ (instancetype)randomColor;
@end

@implementation SKColor (RandomColor)
+ (instancetype)randomColor
{
    return [SKColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}
@end

@implementation BNRMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.9 green:0.95 blue:0.8 alpha:1.0];
        [self configurePhysicsWorld];
        [self createBuilding];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [self createBouncingBallAtPoint:location];
    }
}

- (void)configurePhysicsWorld
{
    // make the physics world tangible, so that objects collide with it
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
}

- (void)createBouncingBallAtPoint:(CGPoint)point
{
    CGFloat radius = 15.0;
    // for physics simulation, we'll pretend it's a circle
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    physicsBody.velocity = CGVectorMake(300+arc4random_uniform(300), 200+arc4random_uniform(300));
    physicsBody.restitution = 0.8; // make it bouncy
    CGSize size = CGSizeMake(radius*2, radius*2);
    // ...but will render it as a square to see the rotation
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithColor:[SKColor randomColor] size:size];
    ball.position = point;
    ball.physicsBody = physicsBody;
    [self addChild:ball];
}

- (void)createBuilding
{
    CGSize size = CGSizeMake(25, 150);
    SKSpriteNode *one = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:size];
    one.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    one.position = CGPointMake(self.size.width-60, 180);
    one.physicsBody.restitution = 0.5;
    SKSpriteNode *two = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:size];
    two.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    two.position = CGPointMake(self.size.width-160, 180);
    two.physicsBody.restitution = 0.5;
    [self addChild:one];
    [self addChild:two];
    CGSize horiz = CGSizeMake(150, 25);
    SKSpriteNode *three = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:horiz];
    three.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:horiz];
    three.position = CGPointMake(self.size.width-110, 300);
    three.physicsBody.restitution = 0.5;
    [self addChild:three];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
