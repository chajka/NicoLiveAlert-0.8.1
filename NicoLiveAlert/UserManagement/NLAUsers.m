//
//  NLAUsers.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/4/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NLAUsers.h"
#import "NLAUser.h"

@interface NLAUsers ()

@end

@implementation NLAUsers
#pragma mark - synthesize properties
@synthesize users;
@synthesize watchItems;
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) initWithAccountList:(NSArray *)list
{
	self = [super init];
	if (self) {
		users = [[NSMutableArray alloc] init];
		for (NSDictionary *accnt in list) {
			NSString *accountname = [accnt valueForKey:@"MailAddress"];
			BOOL watchEnable = [[accnt valueForKey:@"WatchEnabled"] boolValue];
			NLAUser *acc = [[NLAUser alloc] initWithAccount:accountname wathEnabled:watchEnable];
			if (acc != nil)
				[users addObject:acc];
		}// end foreach
	}// end if self

	return self;
}// end - (id) initWithAccounts:(NSArray *)accnts
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions

@end
