//
//  NicoLiveAlert.h
//  NicoLiveAlert
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesWindowController.h"

#import "WatchlistController.h"
#import "WatchItemsManager.h"
#import "NLAUsers.h"

@interface NicoLiveAlert : NSObject <NSApplicationDelegate> {
		// preference
	BOOL							firstTimePreference;
	MASPreferencesWindowController	*prefWindowController;

	WatchlistController				*manualWatchListController;
	WatchItemsManager				*watchItemsManager;

	NLAUsers						*users;
}

@end

