//
//  NLAUsers.h
//  NicoLiveAlert
//
//  Created by Чайка on 7/4/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatchItemsManager.h"

@interface NLAUsers : NSObject {
	NSMutableArray						*users;
	WatchItemsManager					*watchItems;
}
@property (readonly) NSMutableArray		*users;
@property (readwrite) WatchItemsManager	*watchItems;
@end
