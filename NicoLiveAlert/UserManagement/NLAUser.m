//
//  NLAUser.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/3/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NLAUser.h"
#import "NicoLiveAlertDefinitions.h"
#import <CocoaOniguruma/OnigRegexp.h>

@interface NLAUser ()
- (BOOL) getTicket;
- (void) getAlertStatus;
@end

@implementation NLAUser
#pragma mark - synthesize properties
@synthesize userID;
@synthesize nickname;
@synthesize watchEnabled;
@synthesize joined;
@synthesize ticket;
@synthesize messageServerAddress;
@synthesize messageServerPort;
@synthesize messageServerThread;
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) initWithAccount:(NSString *)acct
{
	self = [super init];
	if (self) {
		account = [YCHTTPSKeychainItem userInKeychain:acct forURL:[NSURL URLWithString:NicoLoginFormFQDN]];
		if (![self getTicket])
			return nil;
		[self getAlertStatus];
		watchEnabled = YES;
	}// end if self
	
	return self;
}// end - (id) initWithAccount:(NSString *)acct

- (id) initWithAccount:(NSString *)acct wathEnabled:(BOOL)enable
{
	self = [super init];
	if (self) {
		account = [YCHTTPSKeychainItem userInKeychain:acct forURL:[NSURL URLWithString:NicoLoginFormFQDN]];
		if (![self getTicket])
			return nil;
		[self getAlertStatus];
		watchEnabled = enable;
	}// end if self

	return self;
}// end - (id) initWithAccount:(NSString *)acct wathEnabled:(BOOL)enable

#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
- (NSString *) account	{ return account.account; }
- (NSString *) password	{ return account.password; }
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
- (BOOL) getTicket
{
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
							@"nicolive_antenna", @"site",
							account.account, @"mail",
							 account.password, @"password", nil];
	connection = [[HTTPConnection alloc] initWithURL:[NSURL URLWithString:NicoLoginGetTicketURL] andParams:params];
	NSError *err = nil;
	NSString *ticketXML = [connection stringByPost:&err];

	OnigRegexp *ticketRegex = [OnigRegexp compile:@"<ticket>(.*)</ticket>"];
	OnigResult *result = [ticketRegex search:ticketXML];
	if (result == nil)
		return NO;

	ticket = [[NSString alloc] initWithString:[result stringAt:1]];
	return YES;
}// end - (void) getTicket

- (void) getAlertStatus
{
	NSMutableDictionary *param = [NSMutableDictionary dictionary];
	[param setObject:ticket forKey:@"ticket"];
	
	[connection setURL:[NSURL URLWithString:NicoLiveGetAlertStatusURL] andParams:param];
	 NSError *err = nil;
	 NSData *status = [connection dataByPost:&err];
	joined = [[NSMutableArray alloc] init];
	 elementsDict = [[NSDictionary alloc] initWithObjectsAndKeys:
		[NSNumber numberWithInteger:idxElementUserID], ElementNameUserID,
		[NSNumber numberWithInteger:idxElementUserName], ElementNameUserName,
		[NSNumber numberWithInteger:idxElementCommunityID], ElementNameCommunityID,
		[NSNumber numberWithInteger:idxElementMSAddress], ElementNameMSAddress,
		[NSNumber numberWithInteger:idxElementMSPort], ElementNameMSPort,
		[NSNumber numberWithInteger:idxElementMSThread], ElementNameMSThread, nil];

	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:status];
	[parser setDelegate:self];
	[parser parse];
}// end - (void) getAler
	 
#pragma mark - C functions

#pragma mark - NSXMLParser degegate methods
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	stringBuffer = [[NSMutableString alloc] init];
}// end - (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	NSUInteger index = [[elementsDict valueForKey:elementName] integerValue];
	NSString *communityID = nil;
	switch (index) {
		case idxElementUserID:
			userID = [[NSString alloc] initWithString:stringBuffer];
			break;
		case idxElementUserName:
			nickname = [[NSString alloc] initWithString:stringBuffer];
			break;
		case idxElementCommunityID:
			communityID = [[NSString alloc] initWithString:stringBuffer];
			[joined addObject:communityID];
			break;
		case idxElementMSAddress:
			messageServerAddress = [[NSString alloc] initWithString:stringBuffer];
			break;
		case idxElementMSPort:
			messageServerPort = [stringBuffer integerValue];
			break;
		case idxElementMSThread:
			messageServerThread = [[NSString alloc] initWithString:stringBuffer];
			break;
		default:
			break;
	}// end switch-case element index
}// end - (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[stringBuffer appendString:string];
}// end - (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

/*
- (void) parserDidStartDocument:(NSXMLParser *)parser
{
	<#code#>
}// end - (void) parserDidStartDocument:(NSXMLParser *)parser

- (void) parserDidEndDocument:(NSXMLParser *)parser
{
	<#code#>
}// end - (void) parserDidEndDocument:(NSXMLParser *)parser

- (void) parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI

- (void) parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix

- (NSData *) parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)entityName systemID:(NSString *)systemID
{
	<#code#>
	
	return <#NSData#>;
}// end - (NSData *) parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)entityName systemID:(NSString *)systemID

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError

- (void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validError
{
	<#code#>
}// end - (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validError

- (void) parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString

- (void) parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data

- (void) parser:(NSXMLParser *)parser foundComment:(NSString *)comment
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundComment:(NSString *)comment

- (void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock

#pragma mark DTD
- (void) parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue

- (void) parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model

- (void) parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)entityName publicID:(NSString *)publicID systemID:(NSString *)systemID
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)entityName publicID:(NSString *)publicID systemID:(NSString *)systemID

- (void) parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value

- (void) parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName

- (void) parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
{
	<#code#>
}// end - (void) parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
*/
@end
