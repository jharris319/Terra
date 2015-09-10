//
//  AppDelegate.h
//  Terra
//
//  Created by Jonathan Harris on 9/9/15.
//  Copyright (c) 2015 Jonathan Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Photo.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, assign) bool state;
@property (nonatomic, assign) int *oldId;

@end

