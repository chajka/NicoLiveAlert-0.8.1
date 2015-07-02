//
//  WatchlistController.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "WatchlistController.h"
#import "NicoLiveAlertPreferencesDefinitions.h"

@interface WatchlistController ()

@end
#define WatchlistNibName						@"WatchlistController"

@implementation WatchlistController
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) init {
	self = [super initWithNibName:WatchlistNibName bundle:nil];
	if (self) {
		
	}// end if self

	return self;
}// end - (id) init
#pragma mark - override
#pragma mark -
#pragma mark MASPreferencesViewController protocol methods

- (NSString *)identifier
{
	return WatchlistIdentifier;
}// end - (NSString *)identifier

- (NSImage *)toolbarItemImage
{
	return [NSImage imageNamed:WatchlistIconName];
}// end - (NSImage *)toolbarItemImage

- (NSString *)toolbarItemLabel
{
	return WatchlistTitileName;
}// end - (NSString *)toolbarItemLabel

#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions

@end
