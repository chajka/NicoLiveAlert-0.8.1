//
//  NLAUser.h
//  NicoLiveAlert
//
//  Created by Чайка on 7/3/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCKeychainService.h"
#import "HTTPConnection.h"

@interface NLAUser : NSObject <NSXMLParserDelegate> {
	YCHTTPSKeychainItem				*account;
	NSString						*nickname;
	BOOL							*watchEnabled;
	NSMutableArray					*joined;

	NSString						*ticket;
	NSString						*messageServerAddress;
	NSInteger						messageServerPort;
	NSString						*messageServerThread;

	HTTPConnection					*connection;
	NSMutableString					*stringBuffer;
	NSDictionary					*elementsDict;
}
- (id) initWithAccount:(NSString *)acct wathEnabled:(BOOL)enable;

@end
