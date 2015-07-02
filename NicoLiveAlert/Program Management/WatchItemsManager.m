//
//  WatchItemsManager.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/2/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "WatchItemsManager.h"
#import "NicoLiveAlertDefinitions.h"
#import "NicoLiveAlertPreferencesDefinitions.h"

@implementation WatchItemsManager
#pragma mark - synthesize properties
@synthesize watchlist;
@synthesize manualWatchItems;

#pragma mark - class method
#pragma mark - constructor / destructor
- (id) init
{
	self = [super init];
	if (self) {
		watchlist = [[NSMutableDictionary alloc] init];
		manualWatchItems = [[NSMutableArray alloc] init];
	
		[self loadManualWatchlist];
	}// end if self

	return self;
}// end - (id) init
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
- (void) loadManualWatchlist
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSArray *prefWatchlistItems = [ud arrayForKey:SavedManualWatchList];
	manualWatchItems = [[NSMutableArray alloc] initWithArray:prefWatchlistItems];
}// - (void) loadManualWatchlist
#pragma mark - C functions

@end
