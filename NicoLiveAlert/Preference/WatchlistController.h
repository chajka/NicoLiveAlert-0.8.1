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
	IBOutlet NSTableView				*tblviewWatchlist;
	
	IBOutlet NSTextField				*watchItem;
	IBOutlet NSTextField				*watchItemNote;

	IBOutlet NSButton					*btnAddItem;
	IBOutlet NSButton					*btnDeleteItem;

	NSInteger							selectedRow;
}

@end
