//
//  BNRIntroViewController.m
//  Collections
//
//  Created by Stephen Christopher on 1/16/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRIntroViewController.h"

@interface BNRIntroViewController ()

@end

@implementation BNRIntroViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    /* TODO: this is cheating, since we're doing different demos just make 
     * sure we always remove the delegate.
     * You can see the wonkiness if you do the 1st demo, then go back
     * twice. The 2nd time back still has the custom transition when
     * that wasn't really intended. */
    UINavigationController *navController = self.navigationController;
    navController.delegate = nil;
}


@end
