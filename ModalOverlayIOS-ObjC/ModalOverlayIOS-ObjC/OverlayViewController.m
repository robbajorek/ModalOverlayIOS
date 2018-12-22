//
//  OverlayViewController.m
//  Modal Test
//
//  Created by Rob Bajorek on 8/8/14.
//  Copyright (c) 2014 Rob Bajorek. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()
@property (weak) IBOutlet UIButton *dismissButton;
- (IBAction)optionOneTapped:(id)sender;
- (IBAction)optionTwoTapped:(id)sender;
@end

@implementation OverlayViewController

- (IBAction)optionOneTapped:(id)sender {
    [self.delegate optionOneChosen];
}

- (IBAction)optionTwoTapped:(id)sender {
    [self.delegate optionTwoChosen];
}

@end
