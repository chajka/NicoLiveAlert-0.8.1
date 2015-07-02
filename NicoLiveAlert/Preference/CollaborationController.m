//
//  CollaborationController.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "CollaborationController.h"
#import "NicoLiveAlertPreferencesDefinitions.h"

@interface CollaborationController ()

@end

@implementation CollaborationController
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) init
{
	self = [super initWithNibName:CollaborationNibName bundle:nil];
	if (self) {
		
	}// end if

	return self;
}// end - (id) init
#pragma mark - override
#pragma mark -
#pragma mark MASPreferencesViewController protocol methods

- (NSString *)identifier
{
	return CollaborationIdentifier;
}// end - (NSString *)identifier

- (NSImage *)toolbarItemImage
{
	return [NSImage imageNamed:CollaborationIconName];
}// end - (NSImage *)toolbarItemImage

- (NSString *)toolbarItemLabel
{
	return CollaborationTitileName;
}// end - (NSString *)toolbarItemLabel

#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions

@end
