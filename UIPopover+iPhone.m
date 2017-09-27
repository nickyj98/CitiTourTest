//
//  UIPopover+iPhone.m
//  CameraKitHelloWorld
//
//  Created by Kinky V2 on 14/8/17.
//  Copyright © 2017 Double Robotics, Inc. All rights reserved.
//

#import "UIPopover+iPhone.h"

@implementation UIPopoverController (overrides)

    + (BOOL)_popoversDisabled
    {
        return NO;
    }

@end
