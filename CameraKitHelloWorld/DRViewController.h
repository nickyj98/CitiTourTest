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
    IBOutlet UIButton *popButton;
	IBOutlet UIImageView *mainImageView;
	IBOutlet UILabel *connectionStatusLabel;
    IBOutlet UIButton *driveForwardButton;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *poleHeightPercentLabel;
    IBOutlet UILabel *kickstandStateLabel;
    IBOutlet UILabel *batteryPercentLabel;
    IBOutlet UILabel *leftEncoderLabel;
    IBOutlet UILabel *rightEncoderLabel;
    IBOutlet UILabel *PictureCounterLabel;
    IBOutlet UILabel *CounterLabel;
    IBOutlet UISwitch *EncoderSwitch;
    
    //Label for Records
    
    IBOutlet UILabel *RecordLabel1;
    IBOutlet UILabel *RecordLabel2;
    IBOutlet UILabel *RecordLabel3;
    IBOutlet UILabel *RecordLabel4;
    IBOutlet UILabel *RecordLabel5;
    IBOutlet UILabel *RecordLabel6;
    IBOutlet UILabel *RecordLabel7;
    IBOutlet UILabel *RecordLabel8;
    IBOutlet UILabel *RecordLabel9;
    IBOutlet UILabel *RecordLabel10;
    IBOutlet UILabel *SequenceLabel;
    IBOutlet UILabel *PlayStatusLabel;
    IBOutlet UILabel *QualityLabel;
    IBOutlet UILabel *AutoStatus;
    
    //CONTROLS
    IBOutlet UIButton *driveLeftButton;
    IBOutlet UIButton *DriveFrontButton;
    IBOutlet UIButton *driveRightButton;
    IBOutlet UIButton *driveBackwardButton;
    IBOutlet UIButton *PicturePathButton;
    IBOutlet UISwitch *AutoCaptureSwitch;
    IBOutlet UIButton *CaptureImage;
    IBOutlet UIImageView *SavedImage;
    IBOutlet UIButton *Record;
    IBOutlet UIButton *Stop;
    IBOutlet UIButton *startTimer;
    
    //Video Quality Buttons
    IBOutlet UIButton *LowButton;
    IBOutlet UIButton *MediumQuality;
    IBOutlet UIButton *HighButton;
    
    
}
- (IBAction)RecordButton:(id)sender;
- (IBAction)ClearMacroButton:(id)sender;
- (IBAction)StopButton:(id)sender;
- (IBAction)DriveForward:(id)sender;

- (IBAction)DriveBackwards:(id)sender;
- (IBAction)DriveLeft:(id)sender;
- (IBAction)DriveRight:(id)sender;
- (IBAction)PlayMacro:(id)sender;
- (IBAction)startTimer:(id)sender;
- (IBAction)DemoButton:(id)sender;


@end

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
-(void)DriveMacro:(double)totaldelay time:(NSString *)direction;
-(void)StopMacro:(double)totaldelay time:(NSString *)direction;
@end
