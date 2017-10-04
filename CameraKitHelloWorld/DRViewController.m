//
//  DRViewController.m
//  DoubleBasicHelloWorld
//
//  Created by David Cann on 8/3/13.
//  Copyright (c) 2013 Double Robotics, Inc. All rights reserved.
//

#import "DRViewController.h"
#import <DoubleControlSDK/DoubleControlSDK.h>



@interface DRViewController () <DRDoubleDelegate>


-(void)DriveMacro:(double) totaldelay :(NSString *)direction;
-(void)StopMacro:(double) totaldelay :(NSString *)direction;

@end
int timeTicker;

@implementation DRViewController



- (void)viewDidLoad {
	[super viewDidLoad];
    [DRDouble sharedDouble].delegate = self;
    NSLog(@"SDL Version: %@", kDoubleBasicSDKVersion);
	
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}








- (IBAction)kickstandRetract:(id)sender {
    [[DRDouble sharedDouble] retractKickstands];
}

- (IBAction)kickstandDeploy:(id)sender {
    [[DRDouble sharedDouble] deployKickstands];
}

- (IBAction)poleUp:(id)sender {
    [[DRDouble sharedDouble] poleUp];
}


- (IBAction)poleStop:(id)sender {
    [[DRDouble sharedDouble] poleStop];
}

- (IBAction)poleDown:(id)sender {
    [[DRDouble sharedDouble] poleDown];
}




// CONTROL
#pragma mark - DRDoubleDelegate
- (void)doubleDidConnect:(DRDouble *)theDouble{
    NSLog(@"DoubleDidConnect");
    statusLabel.text = @"Connected";
    
}

-(void)doubleDidDisconnect:(DRDouble *)theDouble{
    NSLog(@"DoubleDidDisconnect");
    statusLabel.text = @"Not Connected";
}

-(void)doubleStatusDidUpdate:(DRDouble *)theDouble{
    NSLog(@"DoubleStatusDidUpdate");
    poleHeightPercentLabel.text = [NSString stringWithFormat:@"%.02f", [DRDouble sharedDouble].poleHeightPercent];
    //kickstandStateLabel.text = [NSString stringWithFormat:@"%d", [DRDouble sharedDouble].kickstandState];
    if([DRDouble sharedDouble].kickstandState == 1)
    {
        kickstandStateLabel.text = @"Parked";
    }
    else if([DRDouble sharedDouble].kickstandState == 2)
    {
        kickstandStateLabel.text = @"Deployed";
    }
    else if([DRDouble sharedDouble].kickstandState == 3)
    {
        kickstandStateLabel.text = @"Parking";
    }
    else if([DRDouble sharedDouble].kickstandState == 4)
    {
        kickstandStateLabel.text = @"Unparking";
    }
    
    batteryPercentLabel.text = [NSString stringWithFormat:@"%.2f", [DRDouble sharedDouble].batteryPercent];
}


- (void)doubleDriveShouldUpdate:(DRDouble *)theDouble {
    
    
   
        NSLog(@"DoubleDriveShouldUpdate");
        float drive = (DriveFrontButton.highlighted) ? kDRDriveDirectionForward : ((driveBackwardButton.highlighted) ? kDRDriveDirectionBackward : kDRDriveDirectionStop);
        NSLog(@"drive : %f", drive);
        
        
        float turn = (driveRightButton.highlighted) ? 1.0 : ((driveLeftButton.highlighted) ? 	-1.0 : 0.0);
        NSLog(@"Turn : %f", turn);
        [theDouble drive:drive turn:turn];
    }
    




-(void)DriveMacro:(double) totaldelay :(NSString *)direction{
    double TotalDelay = totaldelay;
    if([direction isEqualToString: @"Forward"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            DriveFrontButton.highlighted = 1;
        });
    }
    else if([direction isEqualToString: @"Backward"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveBackwardButton.highlighted = 1;
        });
    }
    else if([direction isEqualToString: @"Left"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveLeftButton.highlighted = 1;
        });
    }
    else if([direction isEqualToString: @"Right"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveRightButton.highlighted = 1;
        });
    }
    
}











-(void)StopMacro:(double) totaldelay :(NSString *)direction{
    double TotalDelay = totaldelay;
    if([direction isEqualToString: @"Forward"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            DriveFrontButton.highlighted = 0;
        });
    }
    else if([direction isEqualToString: @"Backward"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveBackwardButton.highlighted = 0;
        });
    }
    else if([direction isEqualToString: @"Left"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveLeftButton.highlighted = 0;
        });
    }
    else if([direction isEqualToString: @"Right"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            driveRightButton.highlighted = 0;
        });
    }
    else if([direction isEqualToString: @"All"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            DriveFrontButton.highlighted = 0;
            driveBackwardButton.highlighted = 0;
            driveLeftButton.highlighted = 0;
            driveRightButton.highlighted = 0;
        });
    }
    
}


- (IBAction)DemoButton:(id)sender
{
    double totalDelay3 =0;
    
    //test
    double delayinSeconds4 =1;
    double totalDelay4 = totalDelay3 + delayinSeconds4;
    
    
    double delayinSeconds5 =1;
    double totalDelay5 = totalDelay4 + delayinSeconds5;
    
}

   
    @end
    
