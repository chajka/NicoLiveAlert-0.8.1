//
//  NLAUsers.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/4/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NLAUsers.h"
#import "NicoLiveAlertDefinitions.h"

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
			NSString *accountname = [accnt valueForKey:KeyMailAddress];
			BOOL watchEnable = [[accnt valueForKey:KeyWatchEnabled] boolValue];
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
- (NSString *) messageServerAddress
{
	NLAUser *user = [users objectAtIndex:0];
	return user.messageServerAddress;
}// end - (NSString *) messageServerAddress

- (NSInteger) messageServerPort
{
	NLAUser *user = [users objectAtIndex:0];
	return user.messageServerPort;
}// end - (NSInteger) messageServerPort

- (NSString *) messageServerThread
{
	NLAUser *user = [users objectAtIndex:0];
	return user.messageServerThread;
}// end - (NSString *) messageServerThread
#pragma mark - actions
#pragma mark - messages
- (NLAUser *) addAccount:(NSString *)accnt
{
	NLAUser *user = [[NLAUser alloc] initWithAccount:accnt];
	if (user == nil)
		return nil;
	
	[users addObject:accnt];
	
	return user;
}// - (NLAUser *) addAccount:(NSString *)accnt

- (NLAUser *) addAccount:(NSString *)accnt password:(NSString *)passwd
{
	NLAUser *user = [[NLAUser alloc] initWithAccount:accnt password:passwd];
	if (user == nil)
		return nil;

	[users addObject:accnt];

	return user;
}// end - (NLAUser *) addAccount:(NSString *)accnt password:(NSString *)passwd

- (BOOL) refreshUserInformation
{
	BOOL success = YES;
	for (NLAUser *user in users) {
		success |= [user refreshUserInformation];
	}// end foreach

	return success;
}//end - (BOOL) refreshUserInformation
#pragma mark - private
#pragma mark - C functions

@end
