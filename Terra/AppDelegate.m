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
	
	[self createStatusItem];
	
	self.photoArray = [[NSMutableArray alloc] init];
	
	NSArray *screenArray = [NSScreen screens];
	int index = 0;
	for (NSScreen *screen in screenArray) {
		Photo *photo = [self getInitialPhoto];
		
		
		NSData* imageData = [NSData dataWithContentsOfURL:photo.photoUrl];
		
		NSString *photoPath = [NSString stringWithFormat:@"%@/Pictures/%d.jpg", NSHomeDirectory(), photo._id];
		
		[imageData writeToFile:photoPath atomically:YES];
		
		NSDictionary *screenOptions = [[NSWorkspace sharedWorkspace] desktopImageOptionsForScreen:[screenArray objectAtIndex:index]];
		[[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:photoPath] forScreen:screen options:screenOptions error:nil];
		
		[self.photoArray addObject:photo];
		index++;
	}
	
	[self startTimer];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)createStatusItem {
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	// The text that will be shown in the menu bar
	self.statusItem.title = @"";
	
	// The image that will be shown in the menu bar, a 16x16 black png works best
	self.statusItem.image = [NSImage imageNamed:@"earth16-white.png"];
	
	// The highlighted image, use a white version of the normal image
	self.statusItem.alternateImage = [NSImage imageNamed:@"earth16-white.png"];
	
	// The image gets a blue background when the item is selected
	self.statusItem.highlightMode = YES;
	
	
	NSMenu *menu = [[NSMenu alloc] init];
	[menu addItemWithTitle:@"Refresh" action:@selector(refreshPhotos) keyEquivalent:@""];
	
	[menu addItem:[NSMenuItem separatorItem]]; // A thin grey line
	[menu addItemWithTitle:@"Quit Terra" action:@selector(terminate:) keyEquivalent:@""];
	self.statusItem.menu = menu;
}

- (void)startTimer {
	[self performSelector:@selector(refreshPhotos) withObject:nil afterDelay:1800 ];
}

- (Photo*)getInitialPhoto {
	NSString *url = @"http://earthview.withgoogle.com";
	NSURL *urlRequest = [NSURL URLWithString:url];
	NSError *err = nil;
	
	NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"data-photo=\"([^\"]*)\"" options:NSRegularExpressionCaseInsensitive error:&err];
	NSTextCheckingResult *match = [regex firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];
	NSRange range = [match rangeAtIndex: 1];
	NSString *photoData = [html substringWithRange:range];
	photoData = [photoData stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
	
	NSData *objectData = [photoData dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
														 options:NSJSONReadingMutableContainers
														   error:&err];
	
	return [[Photo alloc] initWithDictionary:json];
}

- (void)refreshPhotos {
	int index = 0;
	NSArray *screenArray = [NSScreen screens];
	for (Photo *photo in self.photoArray) {
		AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
		@try {
			NSString *photoURL = [NSString stringWithFormat:@"http://earthview.withgoogle.com/%@", photo.nextApi];
			[manager GET:photoURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
				
				Photo *photo = [[Photo alloc] initWithDictionary:responseObject];
				
				NSData* imageData = [NSData dataWithContentsOfURL:photo.photoUrl];
				
				NSString *photoPath = [NSString stringWithFormat:@"%@/Pictures/%d.jpg", NSHomeDirectory(), photo._id];
				
				[imageData writeToFile:photoPath atomically:YES];
				
				NSScreen *screen = [screenArray objectAtIndex:index];
				NSDictionary *screenOptions = [[NSWorkspace sharedWorkspace] desktopImageOptionsForScreen:[screenArray objectAtIndex:index]];
				[[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:photoPath] forScreen:screen options:screenOptions error:nil];
				
				[self.photoArray replaceObjectAtIndex:index withObject:photo];
			} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
				NSLog(@"Error: %@", error);
			}];
		}
		@catch (NSException *exception) {
			self.photoArray = [[NSMutableArray alloc] init];
			
			NSArray *screenArray = [NSScreen screens];
			int index = 0;
			for (NSScreen *screen in screenArray) {
				Photo *photo = [self getInitialPhoto];
				
				
				NSData* imageData = [NSData dataWithContentsOfURL:photo.photoUrl];
				
				NSString *photoPath = [NSString stringWithFormat:@"%@/Pictures/%d.jpg", NSHomeDirectory(), photo._id];
				
				[imageData writeToFile:photoPath atomically:YES];
				
				NSDictionary *screenOptions = [[NSWorkspace sharedWorkspace] desktopImageOptionsForScreen:[screenArray objectAtIndex:index]];
				[[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:photoPath] forScreen:screen options:screenOptions error:nil];
				
				[self.photoArray addObject:photo];
				index++;
			}
		}
		index++;
	}
	[self startTimer];
}

@end
