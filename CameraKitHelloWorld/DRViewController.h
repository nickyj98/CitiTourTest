//
//  DRViewController.h
//  DoubleBasicHelloWorld
//
//  Created by David Cann on 8/3/13.
//  Copyright (c) 2013 Double Robotics, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DRAppDelegate.h"
#import "UIPopover+iPhone.h"

@interface DRViewController : UIViewController <UIPopoverControllerDelegate>
{
    IBOutlet UIViewController *popoverView;
    
	IBOutlet UILabel *connectionStatusLabel;
    IBOutlet UIButton *driveForwardButton;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *poleHeightPercentLabel;
    IBOutlet UILabel *kickstandStateLabel;
    IBOutlet UILabel *batteryPercentLabel;
    
    
    //Label for Records
    
    
    IBOutlet UILabel *PlayStatusLabel;
    
    //CONTROLS
    IBOutlet UIButton *driveLeftButton;
    IBOutlet UIButton *DriveFrontButton;
    IBOutlet UIButton *driveRightButton;
    IBOutlet UIButton *driveBackwardButton;
    
    
    
    
}


- (IBAction)DriveBackwards:(id)sender;
- (IBAction)DriveLeft:(id)sender;
- (IBAction)DriveRight:(id)sender;


@end

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
-(void)DriveMacro:(double)totaldelay time:(NSString *)direction;
-(void)StopMacro:(double)totaldelay time:(NSString *)direction;
@end
