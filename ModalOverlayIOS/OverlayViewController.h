//
//  OverlayViewController.h
//  Modal Test
//
//  Created by Rob Bajorek on 8/8/14.
//  Copyright (c) 2014 Rob Bajorek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverlayViewControllerDelegate <NSObject>
@required
- (void)optionOneChosen;
- (void)optionTwoChosen;
@end

@interface OverlayViewController : UIViewController
@property (nonatomic, weak) id<OverlayViewControllerDelegate> delegate;

@end
