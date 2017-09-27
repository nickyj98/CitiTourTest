//
//  DRViewController.m
//  DoubleBasicHelloWorld
//
//  Created by David Cann on 8/3/13.
//  Copyright (c) 2013 Double Robotics, Inc. All rights reserved.
//

#import "DRViewController.h"
#import <DoubleControlSDK/DoubleControlSDK.h>
#import <CameraKitSDK/CameraKitSDK.h>

int RecordedCommands[10] = {0,0,0,0,0,0,0,0,0,0};
NSTimer *timer;

@interface DRViewController () <DRDoubleDelegate,DRCameraKitImageDelegate, DRCameraKitConnectionDelegate>

@property (class, nonatomic, assign) NSInteger SquareCount;
@property (class, nonatomic, assign) NSInteger CircleCount;
@property (class, nonatomic, assign) NSInteger PathCount;
@property (class, nonatomic, assign) NSInteger AutoCounter;
@property (class, nonatomic, assign) NSInteger Numberofpictures;
@property (class, nonatomic, assign) NSInteger LockMovement;
@property (class, nonatomic, assign) NSInteger RecordCount;
@property (class, nonatomic, assign) NSInteger SequenceCount;
@property (class, nonatomic, assign) NSInteger SequenceCountLeft;
@property (class, nonatomic, assign) NSInteger LockSequenceCounter;
@property (class, nonatomic, assign) NSInteger CameraQuality;
@property (class, nonatomic, assign) NSInteger timeTick;
@property (class, nonatomic, assign) NSInteger MoveCount;

-(void)DriveMacro:(double) totaldelay :(NSString *)direction;
-(void)StopMacro:(double) totaldelay :(NSString *)direction;

@end
int timeTicker;

@implementation DRViewController

-(IBAction)showpop
{
    UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:popoverView];
    [pop setDelegate:self];
    [pop presentPopoverFromRect:popButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}

static NSInteger _PathCount = 0;

+(NSInteger)PathCount
{
    return _PathCount;
}
+ (void)setPathCount:(NSInteger)newPathcount
{
    _PathCount = newPathcount;
}

static NSInteger _timeTick = 0;

+(NSInteger)timeTick
{
    return _timeTick;
}
+ (void)setTimeTick:(NSInteger)newTimeTick
{
    _timeTick = newTimeTick;
}


// Macro Collision
static NSInteger _SquareCount = 0;
static NSInteger _CircleCount = 0;

+ (NSInteger)SquareCount {
    return _SquareCount;
}

+ (NSInteger)CircleCount {
    return _CircleCount;
}

+ (void)setSquareCount:(NSInteger)newSquareCount{
    _SquareCount = newSquareCount;
}

+ (void)setCircleCount:(NSInteger)newCircleValue {
    _CircleCount = newCircleValue;
}

//Auto Counter
static NSInteger _AutoCounter = 30;
static NSInteger _Numberofpictures = 0;

+(NSInteger)AutoCounter{
    return _AutoCounter;
}

+(void)setAutoCounter:(NSInteger)newAutoCounter{
    _AutoCounter = newAutoCounter;
}


+(NSInteger)Numberofpictures
{
    return _Numberofpictures;
}

+(void)setNumberofpictures:(NSInteger)newNumberofpictures
{
    _Numberofpictures = newNumberofpictures;
}


// Pathing Counter
static NSInteger _MoveCount = 0;

+ (NSInteger)MoveCount
{
    return _MoveCount;
}

+(void)setMoveCount:(NSInteger)newMoveCount
{
    _MoveCount = newMoveCount;
}

// Locking of movement
static NSInteger _LockMovement = 0;

+(NSInteger)LockMovement
{
    return _LockMovement;
}
+(void)setLockMovement:(NSInteger)newLockMovement
{
    _LockMovement = newLockMovement;
}

// Record Count
static NSInteger _RecordCount = 0;

+(NSInteger)RecordCount
{
    return _RecordCount;
}
+(void)setRecordCount:(NSInteger)newRecordCount
{
    _RecordCount = newRecordCount;
}

// Sequence Count
static NSInteger _SequenceCount = 0;

+(NSInteger)SequenceCount
{
    return _SequenceCount;
}
+(void)setSequenceCount:(NSInteger)newSequenceCount
{
    _SequenceCount = newSequenceCount;
}

//Sequence Count Left
// Sequence Count
static NSInteger _SequenceCountLeft = 0;

+(NSInteger)SequenceCountLeft
{
    return _SequenceCountLeft  ;
}
+(void)setSequenceCountLeft:(NSInteger)newSequenceCountLeft
{
    _SequenceCountLeft = newSequenceCountLeft;
}

//Lock Sequence Count
static NSInteger _LockSequenceCounter = 0;

+(NSInteger)LockSequenceCounter
{
    return _LockSequenceCounter  ;
}
+(void)setLockSequenceCounter:(NSInteger)newLockSequenceCounter
{
    _LockSequenceCounter = newLockSequenceCounter;
}

//Quality Count
static NSInteger _CameraQuality;

+(NSInteger)CameraQuality
{
    return _CameraQuality;
}
+(void)setCameraQuality:(NSInteger)newCameraQuality
{
    _CameraQuality = newCameraQuality;
}


- (void)viewDidLoad {
	[super viewDidLoad];
    [DRDouble sharedDouble].delegate = self;
    NSLog(@"SDL Version: %@", kDoubleBasicSDKVersion);
	[DRCameraKit sharedCameraKit].connectionDelegate = self;
	[DRCameraKit sharedCameraKit].imageDelegate = self;
	NSLog(@"SDK Version: %@", kCameraKitSDKVersion);
    //Stop.enabled = false;
    [[DRCameraKit sharedCameraKit] setCameraSettingsWithArray:(cameraSetting *)kCameraSettingsFullRes_15FPS];
    LowButton.enabled = false;
    MediumQuality.enabled = false;
    HighButton.enabled = false;
    AutoCaptureSwitch.enabled = false;
    timeTicker = 10;
    DRViewController.RecordCount = -1;
    Record.hidden = false;
    Stop.hidden = true;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}


// CAMERA

//square button
#pragma mark - Actions
- (IBAction)ButtonPressSquareMacro:(id)sender {
    if (DRViewController.SquareCount == 0)
    {
        //Locking of Macro
        DRViewController.SquareCount = 1;
        PlayStatusLabel.text =@"Playing Square Macro";
        //SEQUENCE 1
        //first Straight
        //first straight
        double delayinSeconds = 0;
        double TotalDelay = delayinSeconds;
        [self DriveMacro:TotalDelay :@"Forward"];
        
        double delayinSeconds1 = 2;
        double TotalDelay1 = TotalDelay + delayinSeconds1;
        [self StopMacro:TotalDelay1 :@"Forward"];
        
        //First Turn
        double delayinSeconds2 = 1;
        double TotalDelay2 = TotalDelay1 + delayinSeconds2;
        [self DriveMacro:TotalDelay2 :@"Right"];
        
        double delayinSeconds3 = 2.3;
        double TotalDelay3 = TotalDelay2 + delayinSeconds3;
        [self StopMacro:TotalDelay3 :@"Right"];
        
        //Second straight
        double delayinSeconds4 = 0;
        double TotalDelay4 =TotalDelay3+delayinSeconds4;
        [self DriveMacro:TotalDelay4 :@"Forward"];
        
        double delayinSeconds5 = 2;
        double TotalDelay5 = TotalDelay4 + delayinSeconds5;
        [self StopMacro:TotalDelay5 :@"Forward"];
        
        //Second Turn
        double delayinSeconds6 = 1;
        double TotalDelay6 = TotalDelay5 + delayinSeconds6;
        [self DriveMacro:TotalDelay6 :@"Right"];
        
        double delayinSeconds7 = 2.3;
        double TotalDelay7 = TotalDelay6 + delayinSeconds7;
        [self StopMacro:TotalDelay7 :@"Right"];
        
        //Third straight
        double delayinSeconds8 = 0;
        double TotalDelay8 =TotalDelay7+delayinSeconds8;
        [self DriveMacro:TotalDelay7 :@"Forward"];
        
        double delayinSeconds9 = 2;
        double TotalDelay9 = TotalDelay8 + delayinSeconds9;
        [self StopMacro:TotalDelay9 :@"All"];
        
        //Third Turn
        double delayinSeconds10 = 1;
        double TotalDelay10 = TotalDelay9 + delayinSeconds10;
        [self DriveMacro:TotalDelay10 :@"Right"];
        
        double delayinSeconds11 = 1.3;
        double totalDelay11 = TotalDelay10 + delayinSeconds11;
        [self StopMacro:totalDelay11 :@"Right"];
        
        
        //Fourth straight
        double delayinSeconds12 = 0;
        double TotalDelay12 =totalDelay11+delayinSeconds12;
        [self DriveMacro:TotalDelay12 :@"Forward"];
        
        double delayinSeconds13 = 2;
        double TotalDelay13 = TotalDelay12 + delayinSeconds13;
        [self StopMacro:TotalDelay13 :@"All"];
        
        //Fourth Turn
        double delayinSeconds14 = 1;
        double TotalDelay14 = TotalDelay13 + delayinSeconds14;
        [self DriveMacro:TotalDelay14 :@"Right"];
        
        double delayinSeconds15 = 1.3;
        double totalDelay15 = TotalDelay14 + delayinSeconds15;
        [self StopMacro:totalDelay15 :@"Right"];
        
        
        
        //Unlocking of Macro
        DRViewController.SquareCount = 0;
            PlayStatusLabel.text=@"-";
 
    }
    else if (DRViewController.SquareCount == 1)
    {
        NSLog(@"Invalid Macro Collide");
    }

    
}

- (IBAction)ButtonPressedCircleMacro:(id)sender {
    
    if (DRViewController.CircleCount == 0)
    {
    //Locking of Macro
    DRViewController.CircleCount = 1;
        PlayStatusLabel.text=@"Playing Circle Macro";
        double delayinSeconds =0.5;
        double totalDelay = delayinSeconds;
        [self DriveMacro:totalDelay:@"Left"];
        
        double delayinSeconds1 =9.3;
        double totalDelay1 =totalDelay+delayinSeconds1;
        [self StopMacro:totalDelay1:@"Left"];
    NSLog(@"Off");
        PlayStatusLabel.text=@"-";
    //Unlocking of Macro
    DRViewController.CircleCount = 0;
    }
    
    else if (DRViewController.CircleCount == 1)
    {
        NSLog(@"Invalid Macro Collide");
    }
}


- (IBAction)low:(id)sender {
	[[DRCameraKit sharedCameraKit] setCameraSettingsWithArray:(cameraSetting *)kCameraSettings640x480_15FPS_ISP];
    HighButton.enabled = true;
    LowButton.enabled = false;
    MediumQuality.enabled = true;
    QualityLabel.text = @"Low Quality";
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        QualityLabel.text = @" ";
        	
    });
    
    
}

- (IBAction)medium:(id)sender {
	[[DRCameraKit sharedCameraKit] setCameraSettingsWithArray:(cameraSetting *)kCameraSettings1280x960_30FPS];
    HighButton.enabled = true;
    LowButton.enabled = true;
    MediumQuality.enabled = false;
    QualityLabel.text = @"Medium Quality";
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        QualityLabel.text = @" ";
        
    });

}

- (IBAction)high:(id)sender {
	[[DRCameraKit sharedCameraKit] setCameraSettingsWithArray:(cameraSetting *)kCameraSettingsFullRes_15FPS];
    HighButton.enabled = false;
    LowButton.enabled = true;
    MediumQuality.enabled = true;
    QualityLabel.text = @"High Quality";
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        QualityLabel.text = @" ";
        
    });

    
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

// TAKING OF IMAGES WHILE MOVING ON PATHWAY
- (IBAction)PicturePathing:(id)sender {
    if (DRViewController.PathCount == 0)
    {
        //Lock
        PlayStatusLabel.text=@"Playing Picture Path Macro";
        //First Forward
        double delayinSeconds =0;
        double totalDelay = delayinSeconds;
        [self DriveMacro:totalDelay :@"Forward"];
        
        double delayinSeconds1 = 2;
        double totalDelay1 = totalDelay+delayinSeconds1;
        [self StopMacro:totalDelay1 :@"Forward"];
        
        //First Turnout
        double delayinSeconds2 = 1;
        double totalDelay2 = totalDelay1 + delayinSeconds2;
        [self DriveMacro:totalDelay2 :@"Right"];
        
        double delayinSeconds3 = 1;
        double totalDelay3 = totalDelay2 + delayinSeconds3;
        [self StopMacro:totalDelay2 :@"Right"];
        
        //First Pic
        double delayinSeconds4 =1;
        double totalDelay4 = totalDelay3 + delayinSeconds4;
        [self CapImg:totalDelay4 :@"On"];
        
        double delayinSeconds5 =0.3;
        double totalDelay5 = totalDelay4 + delayinSeconds5;
        [self CapImg:totalDelay5 :@"OFF"];
        
        //First TurnBack
        double delayinSeconds6 = 1;
        double totalDelay6 = totalDelay5 + delayinSeconds6;
        [self DriveMacro:totalDelay6 :@"Left"];
        
        double delayinSeconds7 = 1;
        double totalDelay7 = totalDelay6 +delayinSeconds7;
        [self StopMacro:totalDelay7 :@"Left"];
        
        //Second Forward
        double delayinSeconds8 = 1;
        double totalDelay8 =totalDelay7+delayinSeconds8;
        [self DriveMacro:totalDelay8 :@"Forward"];
        
        double delayinSeconds9 = 2;
        double totalDelay9 = totalDelay8 = delayinSeconds9;
        [self StopMacro:totalDelay9 :@"Forward"];
        
        //Second TurnOut
        double delayinSeconds10 = 1;
        double totalDelay10 = totalDelay9 +delayinSeconds10;
        [self DriveMacro:totalDelay10 :@"Right"];
        
        double delayinSeconds11 = 1;
        double totalDelay11 = totalDelay10 + delayinSeconds11;
        [self StopMacro:totalDelay11 :@"Right"];
        
        //Second Pic
        double delayinSeconds12 = 1;
        double totalDelay12 = totalDelay11 + delayinSeconds12;
        [self CapImg:totalDelay12 :@"On"];
        
        double delayinSeconds13 = 0.3;
        double totalDelay13 = totalDelay12+delayinSeconds13;
        [self CapImg:totalDelay13 :@"OFF"];
        
        //Second TurnBack
        double delayinSeconds14 = 1;
        double totalDelay14 = totalDelay13+delayinSeconds14;
        [self DriveMacro:totalDelay14 :@"Left"];
        
        double delayinSeconds15 = 1;
        double totalDelay15 = totalDelay14+delayinSeconds15;
        [self StopMacro:totalDelay15 :@"Left"];
        
        
        
        
        
            PlayStatusLabel.text=@"-";
            DRViewController.PathCount = 0;
            NSLog(@"Sequence 2-4");
        
    }
    else if (DRViewController.PathCount == 1)
    {
        NSLog(@"Invalid Macro Collide");
    }
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
    
    
    if(DRViewController.LockMovement == 0)
    {
        NSLog(@"DoubleDriveShouldUpdate");
        float drive = (DriveFrontButton.highlighted) ? kDRDriveDirectionForward : ((driveBackwardButton.highlighted) ? kDRDriveDirectionBackward : kDRDriveDirectionStop);
        NSLog(@"drive : %f", drive);
        
        
        float turn = (driveRightButton.highlighted) ? 1.0 : ((driveLeftButton.highlighted) ? 	-1.0 : 0.0);
        NSLog(@"Turn : %f", turn);
        [theDouble drive:drive turn:turn];
    }
    else if(DRViewController.LockMovement == 1)
    {
        NSLog(@"DoubleDriveShouldUpdate2");
        float drive = (DriveFrontButton.highlighted) ? kDRDriveDirectionForward : ((driveBackwardButton.highlighted) ? kDRDriveDirectionBackward : kDRDriveDirectionStop);
        NSLog(@"drive : %f", drive);
        
        
        float turn = (driveRightButton.highlighted) ? 1.0 : ((driveLeftButton.highlighted) ? 	-1.0 : 0.0);
        NSLog(@"Turn : %f", turn);
        [theDouble drive:drive turn:turn];
    }
    
        RecordLabel1.text = [NSString stringWithFormat:@"%d", RecordedCommands[0]];
        RecordLabel2.text = [NSString stringWithFormat:@"%d", RecordedCommands[1]];
        RecordLabel3.text = [NSString stringWithFormat:@"%d", RecordedCommands[2]];
        RecordLabel4.text = [NSString stringWithFormat:@"%d", RecordedCommands[3]];
        RecordLabel5.text = [NSString stringWithFormat:@"%d", RecordedCommands[4]];
        RecordLabel6.text = [NSString stringWithFormat:@"%d", RecordedCommands[5]];
        RecordLabel7.text = [NSString stringWithFormat:@"%d", RecordedCommands[6]];
        RecordLabel8.text = [NSString stringWithFormat:@"%d", RecordedCommands[7]];
        RecordLabel9.text = [NSString stringWithFormat:@"%d", RecordedCommands[8]];
        RecordLabel10.text = [NSString stringWithFormat:@"%d", RecordedCommands[9]];
        
    
    if([RecordLabel1.text isEqual: @"1"])
    {
        RecordLabel1.text = @"Up";
    }
    else if ([RecordLabel1.text isEqual: @"2"])
    {
        RecordLabel1.text = @"Down";
    }
    else if ([RecordLabel1.text isEqual: @"3"])
    {
        RecordLabel1.text = @"Left";
    }
    else if ([RecordLabel1.text isEqual: @"4"])
    {
        RecordLabel1.text = @"Right";
    }
    
    
    
    if([RecordLabel2.text isEqual: @"1"])
    {
        RecordLabel2.text = @"Up";
    }
    else if ([RecordLabel2.text isEqual: @"2"])
    {
        RecordLabel2.text = @"Down";
    }
    else if ([RecordLabel2.text isEqual: @"3"])
    {
        RecordLabel2.text = @"Left";
    }
    else if ([RecordLabel2.text isEqual: @"4"])
    {
        RecordLabel2.text = @"Right";
    }
    
    
    
    if([RecordLabel3.text isEqual: @"1"])
    {
        RecordLabel3.text = @"Up";
    }
    else if ([RecordLabel3.text isEqual: @"2"])
    {
        RecordLabel3.text = @"Down";
    }
    else if ([RecordLabel3.text isEqual: @"3"])
    {
        RecordLabel3.text = @"Left";
    }
    else if ([RecordLabel3.text isEqual: @"4"])
    {
        RecordLabel3.text = @"Right";
    }
    
    
    
    if([RecordLabel4.text isEqual: @"1"])
    {
        RecordLabel4.text = @"Up";
    }
    else if ([RecordLabel4.text isEqual: @"2"])
    {
        RecordLabel4.text = @"Down";
    }
    else if ([RecordLabel4.text isEqual: @"3"])
    {
        RecordLabel4.text = @"Left";
    }
    else if ([RecordLabel4.text isEqual: @"4"])
    {
        RecordLabel4.text = @"Right";
    }
    
    
    
    if([RecordLabel5.text isEqual: @"1"])
    {
        RecordLabel5.text = @"Up";
    }
    else if ([RecordLabel5.text isEqual: @"2"])
    {
        RecordLabel5.text = @"Down";
    }
    else if ([RecordLabel5.text isEqual: @"3"])
    {
        RecordLabel5.text = @"Left";
    }
    else if ([RecordLabel5.text isEqual: @"4"])
    {
        RecordLabel5.text = @"Right";
    }
    
    
    
    if([RecordLabel6.text isEqual: @"1"])
    {
        RecordLabel6.text = @"Up";
    }
    else if ([RecordLabel6.text isEqual: @"2"])
    {
        RecordLabel6.text = @"Down";
    }
    else if ([RecordLabel6.text isEqual: @"3"])
    {
        RecordLabel6.text = @"Left";
    }
    else if ([RecordLabel6.text isEqual: @"4"])
    {
        RecordLabel6.text = @"Right";
    }
    
    
    
    if([RecordLabel7.text isEqual: @"1"])
    {
        RecordLabel7.text = @"Up";
    }
    else if ([RecordLabel7.text isEqual: @"2"])
    {
        RecordLabel7.text = @"Down";
    }
    else if ([RecordLabel7.text isEqual: @"3"])
    {
        RecordLabel7.text = @"Left";
    }
    else if ([RecordLabel7.text isEqual: @"4"])
    {
        RecordLabel7.text = @"Right";
    }

    
    if([RecordLabel8.text isEqual: @"1"])
    {
        RecordLabel8.text = @"Up";
    }
    else if ([RecordLabel8.text isEqual: @"2"])
    {
        RecordLabel8.text = @"Down";
    }
    else if ([RecordLabel8.text isEqual: @"3"])
    {
        RecordLabel8.text = @"Left";
    }
    else if ([RecordLabel8.text isEqual: @"4"])
    {
        RecordLabel8.text = @"Right";
    }
    
    
    if([RecordLabel9.text isEqual: @"1"])
    {
        RecordLabel9.text = @"Up";
    }
    else if ([RecordLabel9.text isEqual: @"2"])
    {
        RecordLabel9.text = @"Down";
    }
    else if ([RecordLabel9.text isEqual: @"3"])
    {
        RecordLabel9.text = @"Left";
    }
    else if ([RecordLabel9.text isEqual: @"4"])
    {
        RecordLabel9.text = @"Right";
    }
    
    
    if([RecordLabel10.text isEqual: @"1"])
    {
        RecordLabel10.text = @"Up";
    }
    else if ([RecordLabel10.text isEqual: @"2"])
    {
        RecordLabel10.text = @"Down";
    }
    else if ([RecordLabel10.text isEqual: @"3"])
    {
        RecordLabel10.text = @"Left";
    }
    else if ([RecordLabel10.text isEqual: @"4"])
    {
        RecordLabel10.text = @"Right";
    }



    
    
    if(DRViewController.LockSequenceCounter == 0)
    {
        for(int i = 0; i <= 10; i++)
        {
            if(RecordedCommands[i] != 0)	
            {
                SequenceLabel.text = [NSString stringWithFormat: @"%ld", (long)DRViewController.SequenceCount];
                DRViewController.SequenceCount++;
                
            }
            
        }
        DRViewController.SequenceCount = 0;
    }
    else if(DRViewController.LockSequenceCounter == 1)
    {
        NSLog(@"Waiting to be unlocked D:");
    }
    

}


// CAMERA
#pragma mark - DRCameraKitConnectionDelegate

- (void)cameraKitConnectionStatusDidChange:(DRCameraKit *)theKit {
    NSLog(@"CamerakitConnectionStatusDidChange");
    if(DRViewController.CameraQuality == 0)
    {
        DRViewController.CameraQuality++;
        LowButton.enabled = true;
        MediumQuality.enabled = true;
        HighButton.enabled = false;
        QualityLabel.text = @"High Quality";
        AutoCaptureSwitch.enabled = true;
    }
    
    // THESE WILL CHANGE VARIABLES WHEN YOU LOAD UP THE APPLICATION
	//connectionStatusLabel.text = (theKit.isConnected) ? @"Connected" : @"Not Connected";
	//firmwareLabel.text = (theKit.isConnected) ? [NSString stringWithFormat:@"%ld", (long)theKit.firmwareVersion] : @"-";
	//serialLabel.text = (theKit.isConnected) ? theKit.iAPSerialNumber : @"-";
}


// Camera Functions (Image Capture and Saving)
#pragma mark - DRCameraKitImageDelegate
- (void)cameraKit:(DRCameraKit *)theKit didReceiveImage:(UIImage *)theImage sizeInBytes:(NSInteger)length {
    NSLog(@"CameraKit");
	mainImageView.image = theImage;
    
    // Image Manual Capture (Start)
    if(CaptureImage.highlighted)
    {
        UIImageWriteToSavedPhotosAlbum(theImage,nil,nil,nil);
        SavedImage.image = theImage;
        
    }
    // Image Manual Capture (End)
    else if(DRViewController.AutoCounter == 2){
        UIImageWriteToSavedPhotosAlbum(theImage,nil,nil,nil);
        SavedImage.image = theImage;
    }
    
    // Image Auto Capture (Start)
    else if(DRViewController.AutoCounter == 1)
    {
        UIImageWriteToSavedPhotosAlbum(theImage,nil,nil,nil);
        SavedImage.image = theImage;
        DRViewController.AutoCounter = 0;
        [self AutoCapture];
        DRViewController.Numberofpictures++;
        PictureCounterLabel.text = [NSString stringWithFormat: @"%ld", (long)DRViewController.Numberofpictures];
    }
    
    
    
    //Image Auto Capture (End)
    

}



- (IBAction)RecordButton:(id)sender {
   
    Stop.enabled = true;
    Record.enabled = false;
    DRViewController.LockMovement = 1;
    Stop.hidden = false;
    Record.hidden = true;
}

- (IBAction)ClearMacroButton:(id)sender {
    for(int i = 0; i <= 10; i++)
    {
        RecordedCommands[i] = 0;
    }
    DRViewController.RecordCount = 0;
    SequenceLabel.text = @"0";
    
}

- (IBAction)StopButton:(id)sender {
    Record.enabled = true;
    Stop.enabled = false;
    DRViewController.LockMovement = 0;
    Stop.hidden = true;
    Record.hidden = false;
}

- (IBAction)DriveForward:(id)sender {
    if(DRViewController.MoveCount == 0)
{
    
    if(DRViewController.LockMovement == 1)
    {
        DRViewController.MoveCount = 1;
        NSLog(@"Press Forward");
        RecordedCommands[DRViewController.RecordCount] = 1;
        driveLeftButton.enabled = false;
        driveRightButton.enabled = false;
//        DriveFrontButton.enabled = false;
        driveBackwardButton.enabled = false;
        DriveFrontButton.highlighted = 1;
        NSLog(@"Front button");
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            DriveFrontButton.highlighted = 0;
            driveLeftButton.enabled = true;
            driveRightButton.enabled = true;
           // DriveFrontButton.enabled = true;
            driveBackwardButton.enabled = true;
            DRViewController.MoveCount = 0;
            
            
        });
        
        if (DRViewController.RecordCount <= 9)
        {
            DRViewController.RecordCount++;
        }
        
        
        
    }
}
    
    
}


- (IBAction)DriveBackwards:(id)sender {
    
    if(DRViewController.MoveCount == 0)
    {
        
        if(DRViewController.LockMovement == 1)
        {
            DRViewController.MoveCount = 1;
            NSLog(@"Press Backwards");
            RecordedCommands[DRViewController.RecordCount] = 2;
            driveLeftButton.enabled = false;
            driveRightButton.enabled = false;
            DriveFrontButton.enabled = false;
            //driveBackwardButton.enabled = false;
            driveBackwardButton.highlighted = 1;
            NSLog(@"Back button");
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                driveBackwardButton.highlighted = 0;
                driveLeftButton.enabled = true;
                driveRightButton.enabled = true;
                DriveFrontButton.enabled = true;
                //driveBackwardButton.enabled = true;
                DRViewController.MoveCount = 0;
                
                
            });
            
            if (DRViewController.RecordCount <= 9)
            {
                DRViewController.RecordCount++;
            }
            
            
            
        }
    }

}

- (IBAction)DriveLeft:(id)sender {
    if(DRViewController.MoveCount == 0)
    {
        
        if(DRViewController.LockMovement == 1)
        {
            DRViewController.MoveCount = 1;
            NSLog(@"Press Left");
            RecordedCommands[DRViewController.RecordCount] = 3;
            //driveLeftButton.enabled = false;
            driveRightButton.enabled = false;
            DriveFrontButton.enabled = false;
            driveBackwardButton.enabled = false;
            driveLeftButton.highlighted = 1;
            NSLog(@"Left button");
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //driveLeftButton.highlighted = 0;
                driveLeftButton.enabled = true;
                driveRightButton.enabled = true;
                DriveFrontButton.enabled = true;
                driveBackwardButton.enabled = true;
                DRViewController.MoveCount = 0;
                
                
            });
            
            if (DRViewController.RecordCount <= 9)
            {
                DRViewController.RecordCount++;
            }
            
            
            
        }
    }
}

- (IBAction)DriveRight:(id)sender {
    if(DRViewController.MoveCount == 0)
    {
        
        if(DRViewController.LockMovement == 1)
        {
            DRViewController.MoveCount = 1;
            NSLog(@"Press Right");
            RecordedCommands[DRViewController.RecordCount] = 4;
            driveLeftButton.enabled = false;
            //driveRightButton.enabled = false;
            DriveFrontButton.enabled = false;
            driveBackwardButton.enabled = false;
            driveRightButton.highlighted = 1;
            NSLog(@"Right button");
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                driveRightButton.highlighted = 0;
                driveLeftButton.enabled = true;
                //driveRightButton.enabled = true;
                DriveFrontButton.enabled = true;
                driveBackwardButton.enabled = true;
                DRViewController.MoveCount = 0;
                
                
            });
            
            if (DRViewController.RecordCount <= 9)
            {
                DRViewController.RecordCount++;
            }
            
            
            
        }
    }
}

- (IBAction)PlayMacro:(id)sender {
    
    
    
    if(DRViewController.RecordCount == 0)
    {
        PlayStatusLabel.text = @"Record Sequence is empty";
    }
    else
    {
        DRViewController.CircleCount = 1;
        if(DRViewController.RecordCount == 0)
        {
            PlayStatusLabel.text = @"Record Sequence is empty";
        }
        else
        {
            PlayStatusLabel.text = @"Playing Recorded Sequence";
            double SequenceMinus = 10;
            NSString *inputString = SequenceLabel.text;
            int value = [inputString intValue];
            DRViewController.SequenceCountLeft = value;
            DRViewController.LockSequenceCounter = 1;
            
            //first macro
            double delayinSeconds =0;
            double totalDelay = delayinSeconds;
            if(RecordedCommands[0] != 0 && SequenceMinus != 0)
            {
                if(RecordedCommands[0] == 1)
                {
                    [self DriveMacro:totalDelay:@"Forward"];
                }
                else if (RecordedCommands [0] == 2)
                {
                    [self DriveMacro:totalDelay:@"Backward"];
                }
                else if (RecordedCommands[0] == 3)
                {
                    [self DriveMacro:totalDelay:@"Left"];
                }
                else if (RecordedCommands[0] == 4)
                {
                    [self DriveMacro:totalDelay:@"Right"];
                }}
            
        
        double delayinSeconds1 =1;
        double totalDelay1 =totalDelay+delayinSeconds1;
        [self StopMacro:totalDelay1:@"All"];
        
        //second macro
        double delayinSeconds2 =1;
        double totalDelay2 =totalDelay1+delayinSeconds2;
        if(RecordedCommands[1] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[1] == 1)
            {
                [self DriveMacro:totalDelay2:@"Forward"];
            }
            else if (RecordedCommands [1] == 2)
            {
                [self DriveMacro:totalDelay2:@"Backward"];
            }
            else if (RecordedCommands[1] == 3)
            {
                [self DriveMacro:totalDelay2:@"Left"];
            }
            else if (RecordedCommands[1] == 4)
            {
                [self DriveMacro:totalDelay2:@"Right"];
            }}
        
        double delayinSeconds3 =1;
        double totalDelay3 =totalDelay2+delayinSeconds3;
        [self StopMacro:totalDelay3:@"All"];

        //Third macro
        double delayinSeconds4 =1;
        double totalDelay4 =totalDelay3+delayinSeconds4;
        if(RecordedCommands[2] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[2] == 1)
            {
                [self DriveMacro:totalDelay4:@"Forward"];
            }
            else if (RecordedCommands [2] == 2)
            {
                [self DriveMacro:totalDelay4:@"Backward"];
            }
            else if (RecordedCommands[2] == 3)
            {
                [self DriveMacro:totalDelay4:@"Left"];
            }
            else if (RecordedCommands[2] == 4)
            {
                [self DriveMacro:totalDelay4:@"Right"];
            }}
        double delayinSeconds5 =1;
        double totalDelay5 =totalDelay4+delayinSeconds5;
        [self StopMacro:totalDelay5:@"All"];
        
        //fourth macro
        double delayinSeconds6 =1;
        double totalDelay6 =totalDelay5+delayinSeconds6;
        if(RecordedCommands[3] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[3] == 1)
            {
                [self DriveMacro:totalDelay6:@"Forward"];
            }
            else if (RecordedCommands [3] == 2)
            {
                [self DriveMacro:totalDelay6:@"Backward"];
            }
            else if (RecordedCommands[3] == 3)
            {
                [self DriveMacro:totalDelay6:@"Left"];
            }
            else if (RecordedCommands[3] == 4)
            {
                [self DriveMacro:totalDelay6:@"Right"];
            }}
        double delayinSeconds7 =1;
        double totalDelay7 =totalDelay6+delayinSeconds7;
        [self StopMacro:totalDelay7:@"All"];
        
        //Fifth Macro
        double delayinSeconds8 =1;
        double totalDelay8 =totalDelay7+delayinSeconds8;
        if(RecordedCommands[4] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[4] == 1)
            {
                [self DriveMacro:totalDelay8:@"Forward"];
            }
            else if (RecordedCommands [4] == 2)
            {
                [self DriveMacro:totalDelay8:@"Backwards"];
            }
            else if (RecordedCommands[4] == 3)
            {
                [self DriveMacro:totalDelay8:@"Left"];
            }
            else if (RecordedCommands[4] == 4)
            {
                [self DriveMacro:totalDelay8:@"Right"];
            }}
        double delayinSeconds9 =1;
        double totalDelay9 =totalDelay8+delayinSeconds9;
        [self StopMacro:totalDelay9:@"All"];
        
        //Sixth Macro
        double delayinSeconds10 =1;
        double totalDelay10 =totalDelay9+delayinSeconds10;
        if(RecordedCommands[5] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[5] == 1)
            {
                [self DriveMacro:totalDelay10:@"Forward"];
            }
            else if (RecordedCommands [5] == 2)
            {
                [self DriveMacro:totalDelay10:@"Backward"];
            }
            else if (RecordedCommands[5] == 3)
            {
                [self DriveMacro:totalDelay10:@"Left"];
            }
            else if (RecordedCommands[5] == 4)
            {
                [self DriveMacro:totalDelay10:@"Right"];
            }}
        double delayinSeconds11 =1;
        double totalDelay11 =totalDelay10+delayinSeconds11;
        [self StopMacro:totalDelay11:@"All"];
        
        //Seventh Macro
        double delayinSeconds12 =1;
        double totalDelay12 =totalDelay11+delayinSeconds12;
        if(RecordedCommands[6] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[6] == 1)
            {
                [self DriveMacro:totalDelay12:@"Forward"];
            }
            else if (RecordedCommands [6] == 2)
            {
                [self DriveMacro:totalDelay12:@"Backward"];
            }
            else if (RecordedCommands[6] == 3)
            {
                [self DriveMacro:totalDelay12:@"Left"];
            }
            else if (RecordedCommands[6] == 4)
            {
                [self DriveMacro:totalDelay12:@"Right"];
            }}
        double delayinSeconds13 =1;
        double totalDelay13 =totalDelay12+delayinSeconds13;
        [self StopMacro:totalDelay13:@"All"];
        
        //Eighth Macro
        double delayinSeconds14 =1;
        double totalDelay14 =totalDelay13+delayinSeconds14;
        if(RecordedCommands[7] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[7] == 1)
            {
                [self DriveMacro:totalDelay14:@"Forward"];
            }
            else if (RecordedCommands [7] == 2)
            {
                [self DriveMacro:totalDelay14:@"Backward"];
            }
            else if (RecordedCommands[7] == 3)
            {
                [self DriveMacro:totalDelay14:@"Left"];
            }
            else if (RecordedCommands[7] == 4)
            {
                [self DriveMacro:totalDelay14:@"Right"];
            }}
        double delayinSeconds15 =1;
        double totalDelay15 =totalDelay14+delayinSeconds15;
        [self StopMacro:totalDelay15:@"All"];
        
        //ninth macro
        double delayinSeconds16 =1;
        double totalDelay16 =totalDelay15+delayinSeconds16;
        if(RecordedCommands[8] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[8] == 1)
            {
                [self DriveMacro:totalDelay16:@"Forward"];
            }
            else if (RecordedCommands [8] == 2)
            {
                [self DriveMacro:totalDelay16:@"Backward"];
            }
            else if (RecordedCommands[8] == 3)
            {
                [self DriveMacro:totalDelay16:@"Left"];
            }
            else if (RecordedCommands[8] == 4)
            {
                [self DriveMacro:totalDelay16:@"Right"];
            }}
        double delayinSeconds17 =1;
        double totalDelay17 =totalDelay16+delayinSeconds17;
        [self StopMacro:totalDelay17:@"All"];
        
        //tenth macro
        double delayinSeconds18 =1;
        double totalDelay18 =totalDelay17+delayinSeconds18;
        if(RecordedCommands[9] != 0 && SequenceMinus != 0)
        {
            if(RecordedCommands[9] == 1)
            {
                [self DriveMacro:totalDelay18:@"Forward"];
            }
            else if (RecordedCommands [9] == 2)
            {
                [self DriveMacro:totalDelay18:@"Backward"];
            }
            else if (RecordedCommands[9] == 3)
            {
                [self DriveMacro:totalDelay18:@"Left"];
            }
            else if (RecordedCommands[9] == 4)
            {
                [self DriveMacro:totalDelay18:@"Right"];
            }}
        double delayinSeconds19 =1;
        double totalDelay19 =totalDelay18+delayinSeconds19;
        [self StopMacro:totalDelay19:@"All"];
        
            PlayStatusLabel.text=@"-";
        DRViewController.LockSequenceCounter = 0;
        
    }
    //DRViewController.LockSequenceCounter = 0;
    SequenceLabel.text = [NSString stringWithFormat: @"%ld", (long)DRViewController.SequenceCount];
}
}
-(void)AutoCapture{
    if([AutoStatus.text isEqualToString:@"ON"]){
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    }
    else if ([AutoStatus.text isEqualToString:@"OFF"]){
        timer = nil;
    }
    else{
        timer= nil;
        NSLog(@"Error-timer");
    }
}

    
- (IBAction)startTimer:(id)sender {
    if (DRViewController.timeTick == 0)
    {
       //[timer invalidate];
        [timer invalidate];
        AutoStatus.text = @"ON";
        AutoStatus.textColor = [UIColor greenColor];
        DRViewController.timeTick = 1;
        [self AutoCapture];
        
    }
    else if (DRViewController.timeTick == 1)
    {
        [timer invalidate];
        timer = nil;
        AutoStatus.text = @"OFF";
        [self AutoCapture];
        AutoStatus.textColor = [UIColor redColor];
        //CounterLabel.text = @"30";
        timeTicker = 10;
        DRViewController.timeTick = 0;

    }
    
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
-(void)CapImg:(double) totaldelay :(NSString *)Status{
    if([Status isEqualToString:@"On"]){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CaptureImage.highlighted =1;
            
        });
         }
        else if ([Status isEqualToString:@"OFF"]){
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totaldelay * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                CaptureImage.highlighted =0;
           });
        }
    }



- (IBAction)DemoButton:(id)sender
{
    double totalDelay3 =0;
    
    //test
    double delayinSeconds4 =1;
    double totalDelay4 = totalDelay3 + delayinSeconds4;
    [self CapImg:totalDelay4 :@"On"];
    
    double delayinSeconds5 =1;
    double totalDelay5 = totalDelay4 + delayinSeconds5;
    [self CapImg:totalDelay5 :@"OFF"];
}
-(void)myTicker
{
    timeTicker--;
    
    CounterLabel.text = [[NSString alloc] initWithFormat:@"%ld", (long)timeTicker];
    
    //NSString *timeString =[[NSString alloc] initWithFormat:@"%ld", (long)DRViewController.timeTick];
    //if we want the timer to stop after a certain number of seconds we can do
    if(timeTicker == 0){//stop the timer after 60 seconds
        [timer invalidate];
        DRViewController.AutoCounter = 1;
        timeTicker = 10;
    }
}
   
    @end
    
