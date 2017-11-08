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
    
    IBOutlet UILabel *ControlsForwardBackward;
    IBOutlet UILabel *ControlsLeftRight;
    
    //Label for Records
    
    
    IBOutlet UILabel *PlayStatusLabel;
    
    //CONTROLS
    IBOutlet UIButton *driveLeftButton;
    IBOutlet UIButton *DriveFrontButton;
    IBOutlet UIButton *driveRightButton;
    IBOutlet UIButton *driveBackwardButton;
    
    IBOutlet UIButton *Park;
    IBOutlet UIButton *Deploy;
    
    IBOutlet UIImageView *image;
    
}

@property (weak, nonatomic) IBOutlet UILabel *Readtext;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UITextView *Readingtext;


@property (weak, nonatomic) IBOutlet UIButton *manualcontrols;

//tour mode
- (IBAction)FullTour:(id)sender;
- (IBAction)R2B:(id)sender;


- (IBAction)Welcome:(id)sender;
- (IBAction)First:(id)sender;
- (IBAction)Second:(id)sender;
- (IBAction)Third:(id)sender;
- (IBAction)Fourth:(id)sender;
- (IBAction)Fifth:(id)sender;
- (IBAction)Sixth:(id)sender;
- (IBAction)Ending:(id)sender;

@end

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
-(void)DriveMacro:(double)totaldelay time:(NSString *)direction;
-(void)StopMacro:(double)totaldelay time:(NSString *)direction;
@end
