//
//  Photo.h
//  Terra
//
//  Created by Jonathan Harris on 9/9/15.
//  Copyright (c) 2015 Jonathan Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, assign) int _id;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float lat;
@property (nonatomic, assign) float lng;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *attribution;
@property (nonatomic, strong) NSString *mapsLink;
@property (nonatomic, strong) NSString *mapsTitle;
@property (nonatomic, strong) NSString *nextUrl;
@property (nonatomic, strong) NSString *nextApi;
@property (nonatomic, strong) NSString *prevUrl;
@property (nonatomic, strong) NSString *prevApi;

- (id)init;
- (id)initWithDictionary:(NSDictionary *)dict;

@end