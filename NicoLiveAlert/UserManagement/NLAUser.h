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
	NSString						*userID;
	NSString						*nickname;
	BOOL							watchEnabled;
	NSMutableArray					*joined;

	NSString						*ticket;
	NSString						*messageServerAddress;
	NSInteger						messageServerPort;
	NSString						*messageServerThread;

	HTTPConnection					*connection;
	NSMutableString					*stringBuffer;
	NSDictionary					*elementsDict;
}
@property (readonly) NSString		*userID;
@property (readonly) NSString		*nickname;
@property (readonly) BOOL			watchEnabled;
@property (readonly) NSMutableArray	*joined;
@property (readonly) NSString		*ticket;
@property (readonly) NSString		*messageServerAddress;
@property (readonly) NSInteger		messageServerPort;
@property (readonly) NSString		*messageServerThread;

- (id) initWithAccount:(NSString *)acct wathEnabled:(BOOL)enable;
- (NSString *) account;
- (NSString *) password;
@end
