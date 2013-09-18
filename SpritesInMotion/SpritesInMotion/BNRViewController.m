//
//  BNRViewController.m
//  SpritesInMotion
//
//  Created by Bolot Kerimbaev on 9/17/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRViewController.h"
#import "BNRMyScene.h"

@implementation BNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    [self resetScene];
}

- (void)resetScene
{
    SKView * skView = (SKView *)self.view;

    // Create and configure the scene.
    SKScene * scene = [BNRMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;

    // Present the scene.
    SKTransition *doors = [SKTransition flipHorizontalWithDuration:0.5];
    [skView presentScene:scene transition:doors];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self resetScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
