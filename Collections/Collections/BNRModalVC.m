//
//  BNRModalVC.m
//  Collections
//
//  Created by Stephen Christopher on 9/17/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRModalVC.h"

@interface BNRModalVC ()

@end

@implementation BNRModalVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIGestureRecognizer *touchGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(didTouch:)];
    [self.view addGestureRecognizer:touchGR];
}

- (void) didTouch:(UIGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
