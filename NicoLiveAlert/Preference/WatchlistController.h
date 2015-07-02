//
//  WatchlistController.h
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WatchlistController : NSViewController {
	IBOutlet NSArrayController			*aryctrlWatchlist;
	IBOutlet NSTableView				*tblviewManualWatchList;
	
	IBOutlet NSTextField				*watchItem;
	IBOutlet NSTextField				*watchItemNote;

	IBOutlet NSButton					*btnAddItem;
	IBOutlet NSButton					*btnDeleteItem;

	NSInteger							selectedRow;
	NSArray								*watchList;
}
- (id) initWithWatchlist:(NSArray *)list;
- (void) setManualWatchList:(NSArray *)watchlist;

@end
