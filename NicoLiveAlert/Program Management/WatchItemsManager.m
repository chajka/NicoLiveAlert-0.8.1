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

@interface WatchItemsManager ()
- (void) loadManualWatchlist;
- (void) makeWatchList;
@end

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
		[self makeWatchList];
	}// end if self

	return self;
}// end - (id) init
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
- (void) addCommunities:(NSArray *)commus
{
	NSNumber *no = [NSNumber numberWithBool:NO];
	for (NSString *community in commus) {
		if ([watchlist valueForKey:community] == nil)
			[watchlist setValue:no forKey:community];
	}// end foreach communities
}// end - (void) addCommunities:(NSArray *)commus
#pragma mark - private
- (void) loadManualWatchlist
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSArray *prefWatchlistItems = [ud arrayForKey:SavedManualWatchList];
	manualWatchItems = [[NSMutableArray alloc] initWithArray:prefWatchlistItems];
}// - (void) loadManualWatchlist

- (void) makeWatchList
{
	for (NSDictionary *item in manualWatchItems) {
		NSNumber *autoOpen = [item objectForKey:WatchlistAutoOpenKey];
		NSString *watchItem = [item objectForKey:WatchlistItemKey];
		[watchlist setValue:autoOpen forKey:watchItem];
	}// end foreach manualWatchItems
}// end - (void) makeWatchList
#pragma mark - C functions

@end
