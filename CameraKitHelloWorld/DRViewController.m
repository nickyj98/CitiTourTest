//
//  DRViewController.m
//  DoubleBasicHelloWorld
//
//  Created by David Cann on 8/3/13.
//  Copyright (c) 2013 Double Robotics, Inc. All rights reserved.
//

#import "DRViewController.h"
#import <DoubleControlSDK/DoubleControlSDK.h>
#import <AVFoundation/AVFoundation.h>



static NSString * BCP47LanguageCodeFromISO681LanguageCode(NSString *ISO681LanguageCode) {
    if ([ISO681LanguageCode isEqualToString:@"ar"]) {
        return @"ar-SA";
    } else if ([ISO681LanguageCode hasPrefix:@"cs"]) {
        return @"cs-CZ";
    } else if ([ISO681LanguageCode hasPrefix:@"da"]) {
        return @"da-DK";
    } else if ([ISO681LanguageCode hasPrefix:@"de"]) {
        return @"de-DE";
    } else if ([ISO681LanguageCode hasPrefix:@"el"]) {
        return @"el-GR";
    } else if ([ISO681LanguageCode hasPrefix:@"en"]) {
        return @"en-US"; // en-AU, en-GB, en-IE, en-ZA
    } else if ([ISO681LanguageCode hasPrefix:@"es"]) {
        return @"es-ES"; // es-MX
    } else if ([ISO681LanguageCode hasPrefix:@"fi"]) {
        return @"fi-FI";
    } else if ([ISO681LanguageCode hasPrefix:@"fr"]) {
        return @"fr-FR"; // fr-CA
    } else if ([ISO681LanguageCode hasPrefix:@"hi"]) {
        return @"hi-IN";
    } else if ([ISO681LanguageCode hasPrefix:@"hu"]) {
        return @"hu-HU";
    } else if ([ISO681LanguageCode hasPrefix:@"id"]) {
        return @"id-ID";
    } else if ([ISO681LanguageCode hasPrefix:@"it"]) {
        return @"it-IT";
    } else if ([ISO681LanguageCode hasPrefix:@"ja"]) {
        return @"ja-JP";
    } else if ([ISO681LanguageCode hasPrefix:@"ko"]) {
        return @"ko-KR";
    } else if ([ISO681LanguageCode hasPrefix:@"nl"]) {
        return @"nl-NL"; // nl-BE
    } else if ([ISO681LanguageCode hasPrefix:@"no"]) {
        return @"no-NO";
    } else if ([ISO681LanguageCode hasPrefix:@"pl"]) {
        return @"pl-PL";
    } else if ([ISO681LanguageCode hasPrefix:@"pt"]) {
        return @"pt-BR"; // pt-PT
    } else if ([ISO681LanguageCode hasPrefix:@"ro"]) {
        return @"ro-RO";
    } else if ([ISO681LanguageCode hasPrefix:@"ru"]) {
        return @"ru-RU";
    } else if ([ISO681LanguageCode hasPrefix:@"sk"]) {
        return @"sk-SK";
    } else if ([ISO681LanguageCode hasPrefix:@"sv"]) {
        return @"sv-SE";
    } else if ([ISO681LanguageCode hasPrefix:@"th"]) {
        return @"th-TH";
    } else if ([ISO681LanguageCode hasPrefix:@"tr"]) {
        return @"tr-TR";
    } else if ([ISO681LanguageCode hasPrefix:@"zh"]) {
        return @"zh-CN"; // zh-HK, zh-TW
    } else {
        return nil;
    }
}

typedef NS_ENUM(NSInteger, SpeechUtteranceLanguage) {
    WelcomeMessage,
    FirstExhibit,
    SecondExhibit,
    ThirdExhibit,
    FourthExhibit,
    FifthExhibit,
    SixthExhibit,
    EndingMessage,
    
};

NSString * const SpeechUtterancesByExhibit[] = {
    
    [WelcomeMessage]     = @"Hello Everyone and Welcome to CITI Tour @ N Y P ,School Of Information Technology . We are glad to have you with us today",
    [FirstExhibit]       = @"On no twenty spring of in esteem spirit likely estate. Continue new you declared differed learning bringing honoured. At mean mind so upon they rent am walk. Shortly am waiting inhabit smiling he chiefly of in. Lain tore time gone him his dear sure. Fat decisively estimating affronting assistance not. Resolve pursuit regular so calling me. West he plan girl been my then up no.Perceived end knowledge certainly day sweetness why cordially. Ask quick six seven offer see among. Handsome met debating sir dwelling age material. As style lived he worse dried. Offered related so visitor we private removed. Moderate do subjects to distance.Breakfast agreeable incommode departure it an. By ignorant at on wondered relation. Enough at tastes really so cousin am of. Extensive therefore supported by extremity of contented. Is pursuit compact demesne invited elderly be. View him she roof tell her case has sigh. Moreover is possible he admitted sociable concerns. By in cold no less been sent hard hill.Betrayed cheerful declared end and. Questions we additions is extremely incommode. Next half add call them eat face. Age lived smile six defer bed their few. Had admitting concluded too behaviour him she. Of death to or to being other.Built purse maids cease her ham new seven among and. Pulled coming wooded tended it answer remain me be. So landlord by we unlocked sensible it. Fat cannot use denied excuse son law. Wisdom happen suffer common the appear ham beauty her had. Or belonging zealously existence as by resources.Turned it up should no valley cousin he. Speaking numerous ask did horrible packages set. Ashamed herself has distant can studied mrs. Led therefore its middleton perpetual fulfilled provision frankness. Small he drawn after among every three no. All having but you edward genius though remark one.An do on frankness so cordially immediate recommend contained. Imprudence insensible be literature unsatiable do. Of or imprudence solicitude affronting in mr possession. Compass journey he request on suppose limited of or. She margaret law thoughts proposal formerly. Speaking ladyship yet scarcely and mistaken end exertion dwelling. All decisively dispatched instrument particular way one devonshire. Applauded she sportsman explained for out objection.Months on ye at by esteem desire warmth former. Sure that that way gave any fond now. His boy middleton sir nor engrossed affection excellent. Dissimilar compliment cultivated preference eat sufficient may. Well next door soon we mr he four. Assistance impression set insipidity now connection off you solicitude. Under as seems we me stuff those style at. Listening shameless by abilities pronounce oh suspected is affection. Next it draw in draw much bred.Consulted he eagerness unfeeling deficient existence of. Calling nothing end fertile for venture way boy. Esteem spirit temper too say adieus who direct esteem. It esteems luckily mr or picture placing drawing no. Apartments frequently or motionless on reasonable projecting expression. Way mrs end gave tall walk fact bed.To shewing another demands to. Marianne property cheerful informed at striking at. Clothes parlors however by cottage on. In views it or meant drift to. Be concern parlors settled or do shyness address. Remainder northward performed out for moonlight. Yet late add name was rent park from rich. He always do do former he highly.",
    [SecondExhibit]     = @"This is the Second Exhibit",
    [ThirdExhibit]      = @"This is the Third Exhibit",
    [FourthExhibit]     = @"This is the Fouth Exhibit",
    [FifthExhibit]      = @"This is the Fifth Exhibit",
    [SixthExhibit]      = @"This is the Sixth Exhibit",
    [EndingMessage]     = @"Thank you for attending CITI Tour @ N Y P , School of Information Technology. We hope that you have a nice day",
};

static NSString * BCP47LanguageCodeForString(NSString *string) {
    NSString *ISO681LanguageCode = (__bridge NSString *)CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef)string, CFRangeMake(0, [string length]));
    return BCP47LanguageCodeFromISO681LanguageCode(ISO681LanguageCode);
}

UIImageView *TourImage;


@interface DRViewController () <DRDoubleDelegate,AVSpeechSynthesizerDelegate>


-(void)DriveMacro:(double) totaldelay :(NSString *)direction;
-(void)StopMacro:(double) totaldelay :(NSString *)direction;

@property (readwrite, nonatomic, copy) NSString *utteranceString;
@property (readwrite, nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;


@end
int timeTicker;

@implementation DRViewController

@synthesize Image;

- (void)viewDidLoad {
	[super viewDidLoad];
    [DRDouble sharedDouble].delegate = self;
    NSLog(@"SDL Version: %@", kDoubleBasicSDKVersion);
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
	
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}








- (IBAction)kickstandRetract:(id)sender {
    NSLog(@"Deploy");
    [[DRDouble sharedDouble] retractKickstands];
}

- (IBAction)kickstandDeploy:(id)sender {
    NSLog(@"park");
    [[DRDouble sharedDouble] deployKickstands];
}


- (IBAction)poleUp:(id)sender {
    NSLog(@"poleUp");
    [[DRDouble sharedDouble] poleUp];
}


- (IBAction)poleStop:(id)sender {
    NSLog(@"poleStop");
    [[DRDouble sharedDouble] poleStop];
}

- (IBAction)poleDown:(id)sender {
    NSLog(@"poleDown");
    [[DRDouble sharedDouble] poleDown];
}




// CONTROL
#pragma mark - DRDoubleDelegate
- (void)doubleDidConnect:(DRDouble *)theDouble{
    NSLog(@"DoubleDidConnect");
    connectionStatusLabel.text = @"Connected";
    
}

-(void)doubleDidDisconnect:(DRDouble *)theDouble{
    NSLog(@"DoubleDidDisconnect");
    connectionStatusLabel.text = @"Not Connected";
}

-(void)doubleStatusDidUpdate:(DRDouble *)theDouble{
    NSLog(@"DoubleStatusDidUpdate");
    poleHeightPercentLabel.text = [NSString stringWithFormat:@"%.02f", [DRDouble sharedDouble].poleHeightPercent];
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
    
    if(_manualcontrols.highlighted == true){
        
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

- (IBAction)FullTour:(id)sender {
}

- (IBAction)R2B:(id)sender {
}

- (IBAction)Welcome:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"centre-for-it-innovation-logo.jpg"]];
    
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[WelcomeMessage];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
}


- (IBAction)First:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[FirstExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Second:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[SecondExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Third:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[ThirdExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Fourth:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[FourthExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Fifth:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[FifthExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Sixth:(id)sender {
    //Set Image
    
    [Image setImage:[UIImage imageNamed:@"double-2-telepresence-robot_1.jpg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[SixthExhibit];
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
    
}

- (IBAction)Ending:(id)sender {
    //set image
    
    [Image setImage:[UIImage imageNamed:@"images.jpeg"]];
    
    //read Text
    self.utteranceString = SpeechUtterancesByExhibit[EndingMessage];
    
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.utteranceString];
    NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    //utterance.pitchMultiplier = 0.5f;
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = 0.4f;
    utterance.preUtteranceDelay = 0.2f;
    utterance.postUtteranceDelay = 0.2f;
    
    [self.speechSynthesizer speakUtterance:utterance];
}

#pragma mark - AVSpeechSynthesizerDelegate

//highlighting part
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
willSpeakRangeOfSpeechString:(NSRange)characterRange
                utterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self.utteranceString];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
    //self.Readtext.attributedText = mutableAttributedString;
    self.Readingtext.attributedText = mutableAttributedString;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
  didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
 didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    
    //self.Readtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
    self.Readingtext.attributedText = [[NSAttributedString alloc] initWithString:self.utteranceString];
}

   

@end
    
