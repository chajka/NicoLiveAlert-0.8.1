//
//  AccountController.h
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NLAUsers.h"

@interface AccountController : NSViewController {
	IBOutlet NSComboBox				*comboMaladdresses;
	IBOutlet NSTextField			*txtfldPassword;
	IBOutlet NSArrayController		*aryctrlAccounts;

	IBOutlet NSButton				*btnAddAccount;
	IBOutlet NSButton				*btnDeleteAccount;

	NLAUsers						*watchedUsers;
}
- (id) initWithUsers:(NLAUsers *)users;
@end
