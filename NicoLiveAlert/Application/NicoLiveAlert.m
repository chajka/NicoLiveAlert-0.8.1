//
//  NicoLiveAlert.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NicoLiveAlert.h"

@interface NicoLiveAlert ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation NicoLiveAlert
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
#pragma mark - override
- (void) applicationWillFinishLaunching:(NSNotification *)notification
{
	firstTimePreference = YES;
}// end - (void) applicationWillFinishLaunching:(NSNotification *)notification

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}// end - (void) applicationDidFinishLaunching:(NSNotification *)aNotification

- (void) applicationWillTerminate:(NSNotification *)aNotification
{
	// Insert code here to tear down your application
}// end - (void) applicationWillTerminate:(NSNotification *)aNotification

#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
- (IBAction) openPreference:(id)sender
{
	@autoreleasepool {
		NSWindowController *winController = [self preferencesWindowController];
		if (firstTimePreference == YES) {
			firstTimePreference = NO;
			[prefWindowController selectControllerAtIndex:0];
		}
		[winController showWindow:nil];
	}
}// end - (IBAction) openPreference:(id)sender
#pragma mark - messages
#pragma mark - private
- (MASPreferencesWindowController *) preferencesWindowController
{
	if (prefWindowController == nil) {
	}// end if

	return prefWindowController;
}
#pragma mark - C functions

@end
