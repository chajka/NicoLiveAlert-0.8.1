//
//  AccountController.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "AccountController.h"

@interface AccountController ()

@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
#pragma mark - override
#pragma mark -
#pragma mark MASPreferencesViewController protocol methods

- (NSString *)identifier
{
	return @"Account";
}// end - (NSString *)identifier

- (NSImage *)toolbarItemImage
{
	return [NSImage imageNamed:@"Password"];
}// end - (NSImage *)toolbarItemImage

- (NSString *)toolbarItemLabel
{
	return @"Account";
}// end - (NSString *)toolbarItemLabel

#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions

@end
