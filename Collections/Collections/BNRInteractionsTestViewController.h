//
//  BNRInteractionsTestViewController.h
//  Collections
//
//  Created by Stephen Christopher on 1/22/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRInteractionsTestViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UISegmentedControl *interactionSelector;

- (IBAction)segmentedControlDidChange:(UISegmentedControl *)sender;

@end
