//
//  ViewController.m
//  Modal Test
//
//  Created by Rob Bajorek on 8/8/14.
//  Copyright (c) 2014 Rob Bajorek. All rights reserved.
//

#import "ViewController.h"

#import "OverlayViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate, OverlayViewControllerDelegate>
// The text field that responds to a double-tap.
@property (weak) IBOutlet UITextField *firstField;
// A simple label that shows we received a message back from the overlay.
@property (weak) IBOutlet UILabel *label;
// Gesture recognizer for the text field
@property (strong) UITapGestureRecognizer *doubleTapRecognizer;
// The window that will appear over our existing one.
@property (strong) UIWindow *overlayWindow;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

// Set up gesture recognizer
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(handleDoubleTap)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    self.doubleTapRecognizer.delegate = self;
    [self.firstField addGestureRecognizer:self.doubleTapRecognizer];

    [self.firstField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)handleDoubleTap {
    printf("Double tapped\n");
    self.overlayWindow = [[UIWindow alloc] initWithFrame:self.view.window.frame];
    // Looks redundant, but fixes a graphical glitch when the window first appears.
    self.overlayWindow.frame = self.view.window.frame;
    [self.overlayWindow setWindowLevel:UIWindowLevelAlert];
    OverlayViewController *overlayVC = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
    self.overlayWindow.rootViewController = overlayVC;
    overlayVC.delegate = self;

    // Nicer transition
    self.overlayWindow.alpha = 0.0f;
    [self.overlayWindow makeKeyAndVisible];
    [UIWindow animateWithDuration:0.3 animations:^{
        self.overlayWindow.alpha = 1.0f;
    }];

    // This fixes a problem with needing to click off the text field and back again
    //  before it will recognize a second double-click gesture.
    [self.firstField removeGestureRecognizer:self.doubleTapRecognizer];
    [self.firstField addGestureRecognizer:self.doubleTapRecognizer];
}

- (void)optionOneChosen {
    self.label.text = @"Option 1 chosen";
    [UIWindow animateWithDuration:0.3f
                       animations:^{
                           self.overlayWindow.alpha = 0.0f;
                       } completion:^(BOOL finished) {
                           self.overlayWindow = nil;
                       }];
}

- (void)optionTwoChosen {
    self.label.text = @"Option 2 chosen";
    [UIWindow animateWithDuration:0.3f
                       animations:^{
                           self.overlayWindow.alpha = 0.0f;
                       } completion:^(BOOL finished) {
                           self.overlayWindow = nil;
                       }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

// Prevents the copy/paste/etc. menu from appearing when double-tapping
//  the text field.
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    });
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - UIGestureRecognizerDelegate
// Our gesture recognizer clashes with UITextField's. Need to allow both
//  to work simultaneously.
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
