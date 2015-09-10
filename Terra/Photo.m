//
//  Photo.m
//  Terra
//
//  Created by Jonathan Harris on 9/9/15.
//  Copyright (c) 2015 Jonathan Harris. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)init {
	self = [super init];
	if (!self) {
		return self;
	}
	
	self._id         = -1;
	self.slug        = @"";
	self.url         = nil;
	self.title       = @"";
	self.lat         = -1.0;
	self.lng         = -1.0;
	self.photoUrl    = nil;
	self.thumbUrl    = nil;
	self.downloadUrl = @"";
	self.region      = @"";
	self.country     = @"";
	self.attribution = @"";
	self.mapsLink    = @"";
	self.mapsTitle   = @"";
	self.nextUrl     = @"";
	self.nextApi     = @"";
	self.prevUrl     = @"";
	self.prevApi     = @"";
	
	return self;
}

- (id)initWithDictionary:(NSDictionary *)dict {
	self = [super init];
	if (!self || ![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	
	self._id         = [[dict objectForKey:@"id"] intValue];
	self.slug        = [dict objectForKey:@"slug"];
	self.url         = [dict objectForKey:@"url"];
	self.title       = [dict objectForKey:@"title"];;
	self.lat         = [[dict objectForKey:@"lat"] floatValue];
	self.lng         = [[dict objectForKey:@"lng"] floatValue];
	self.photoUrl    = [NSURL URLWithString:[dict objectForKey:@"photoUrl"]];
	self.thumbUrl    = [NSURL URLWithString:[dict objectForKey:@"thumbUrl"]];
	self.downloadUrl = [dict objectForKey:@"downloadUrl"];
	self.region      = [dict objectForKey:@"region"];
	self.country     = [dict objectForKey:@"country"];
	self.attribution = [dict objectForKey:@"attribution"];
	self.mapsLink    = [dict objectForKey:@"mapsLink"];
	self.mapsTitle   = [dict objectForKey:@"mapsTitle"];
	self.nextUrl     = [dict objectForKey:@"nextUrl"];
	self.nextApi     = [dict objectForKey:@"nextApi"];
	self.prevUrl     = [dict objectForKey:@"prevUrl"];
	self.prevApi     = [dict objectForKey:@"prevApi"];
	
	return self;
}

@end
