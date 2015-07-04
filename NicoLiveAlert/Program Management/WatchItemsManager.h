//
//  WatchItemsManager.h
//  NicoLiveAlert
//
//  Created by Чайка on 7/2/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchItemsManager : NSObject {
	NSMutableDictionary					*watchlist;
	NSMutableArray						*manualWatchItems;
	NSMutableDictionary					*manualWatchList;
}
@property (readonly) NSMutableDictionary	*watchlist;
@property (readonly) NSMutableArray			*manualWatchItems;
@property (readonly) NSMutableDictionary	*manualWatchList;

- (void) addCommunities:(NSArray *)communities;
- (BOOL) removeLive:(NSString *)liveID;
- (void) removeManualWatchItem:(NSDictionary *)item;
@end
