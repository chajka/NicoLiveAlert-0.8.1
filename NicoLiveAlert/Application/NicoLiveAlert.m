//
//  NicoLiveAlert.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NicoLiveAlert.h"
#import "NicoLiveAlertDefinitions.h"

#import "WatchlistController.h"
#import "AccountController.h"
#import "CollaborationController.h"
#import "AboutController.h"

@interface NicoLiveAlert ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation NicoLiveAlert
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
#pragma mark - override
- (void) awakeFromNib
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *defaultsPath = [bundle pathForResource:UsersDefaultFileName ofType:UsersDefaultResourceType];
	NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:defaultsPath];
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];

	watchItemsManager = [[WatchItemsManager alloc] init];
}// end - (void) awakeFromNib

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
		manualWatchListController = [[WatchlistController alloc] initWithWatchlist:watchItemsManager.manualWatchItems];
		AccountController *account = [[AccountController alloc] init];
		CollaborationController *collabo = [[CollaborationController alloc] init];
		AboutController *about = [[AboutController alloc] init];
		NSArray *controllers = [NSArray arrayWithObjects:manualWatchListController, account, collabo, about, nil];
		prefWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers];
	}// end if

	return prefWindowController;
}
#pragma mark - C functions

@end
