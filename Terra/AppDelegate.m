//
//  AppDelegate.m
//  Terra
//
//  Created by Jonathan Harris on 9/9/15.
//  Copyright (c) 2015 Jonathan Harris. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

#import "Photo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager GET:@"http://earthview.withgoogle.com/_api/taylor-county-united-states-1780.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		self.photo = [[Photo alloc] initWithDictionary:responseObject];
		NSLog(@"JSON: %@", responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	[self startTimer];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)startTimer {
	[self performSelector:@selector(updatePhoto) withObject:nil afterDelay:1.0 ];
}

- (void)updatePhoto {
	
	NSArray *screenArray = [NSScreen screens];
	
	[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"/Users/jonathan/Terra/%d.jpg", self.photo._id] error:nil];
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager GET:[NSString stringWithFormat:@"http://earthview.withgoogle.com/%@", self.photo.nextApi] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		self.photo = [[Photo alloc] initWithDictionary:responseObject];
		
		
		
		
		NSData* imageData = [NSData dataWithContentsOfURL:self.photo.photoUrl];
		
		[imageData writeToFile:[NSString stringWithFormat:@"/Users/jonathan/Terra/%d.jpg", self.photo._id] atomically:YES];
		
		for (NSScreen *screen in screenArray) {
			
			NSDictionary *screenOptions = [[NSWorkspace sharedWorkspace] desktopImageOptionsForScreen:[screenArray objectAtIndex:0]];
			
			[[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Users/jonathan/Terra/%d.jpg", self.photo._id]] forScreen:screen options:screenOptions error:nil];
			
			
			
			
			
			
		}
		[self startTimer];
		
		NSLog(@"JSON: %@", responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	
	
}

@end
