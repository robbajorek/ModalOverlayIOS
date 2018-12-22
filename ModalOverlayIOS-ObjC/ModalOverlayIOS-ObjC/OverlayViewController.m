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
- (IBAction)optionOneClicked:(id)sender;
- (IBAction)optionTwoClicked:(id)sender;
@end

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)optionOneClicked:(id)sender {
    [self.delegate optionOneChosen];
}

- (IBAction)optionTwoClicked:(id)sender {
    [self.delegate optionTwoChosen];
}

@end
