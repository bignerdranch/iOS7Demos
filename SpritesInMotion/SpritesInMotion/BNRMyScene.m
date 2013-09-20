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

@interface BNRMyScene ()
@property (nonatomic, assign) NSUInteger numberOfHats;
@end

@implementation BNRMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.5 alpha:1.0];
        [self configurePhysicsWorld];
        [self createCloud];
        [self createBuilding];
        self.numberOfHats = 0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [self createBouncingHatAtPoint:location];
        if (++self.numberOfHats == 3) {
            [self createEmitter];
        }
    }
}

- (void)configurePhysicsWorld
{
    // make the physics world tangible, so that objects collide with it
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
}

- (void)createBouncingHatAtPoint:(CGPoint)point
{
    CGFloat radius = 20.0;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    physicsBody.velocity = CGVectorMake(300+arc4random_uniform(300), 200+arc4random_uniform(300));
    physicsBody.restitution = 0.8; // make it bouncy
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"bnrhat"];
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
    SKSpriteNode *two = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:size];
    two.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    two.position = CGPointMake(self.size.width-160, 180);
    two.physicsBody.restitution = 0.5;
    [self addChild:one];
    [self addChild:two];
    CGSize horiz = CGSizeMake(150, 25);
    SKSpriteNode *three = [SKSpriteNode spriteNodeWithImageNamed:@"roof"];
    three.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:horiz];
    three.position = CGPointMake(self.size.width-110, 300);
    three.physicsBody.restitution = 0.5;
    [self addChild:three];
}

- (void)createCloud
{
    SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithImageNamed:@"cloud"];
    cloud.position = CGPointMake(60, 280);
    SKAction *goRight = [SKAction moveByX:300 y:0 duration:2];
    SKAction *goLeft = [goRight reversedAction];
    SKAction *action = [SKAction sequence:@[goRight, goLeft]];
    [cloud runAction:[SKAction repeatActionForever:action]];
    [self addChild:cloud];
}

- (void)createEmitter
{
    [self addChild:[self newFireEmitter]];
}

- (SKEmitterNode *) newFireEmitter
{
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    fire.position = CGPointMake(self.size.width-110, 10);
    return fire;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}
@end
