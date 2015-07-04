//
//  NicoLiveAlertDefinitions.h
//  NicoLiveAlert
//
//  Created by Чайка on 7/2/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#ifndef NicoLiveAlert_NicoLiveAlertDefinitions_h
#define NicoLiveAlert_NicoLiveAlertDefinitions_h

#define EmptyString									@""

#define NicoLoginFormFQDN							@"https://secure.nicovideo.jp/secure/login_form"
#define NicoLoginGetTicketURL						@"https://secure.nicovideo.jp/secure/login"
#define NicoLiveGetAlertStatusURL					@"http://live.nicovideo.jp/api/getalertstatus"

#define UsersDefaultResourceType					@"plist"
#define UsersDefaultFileName						@"UsersDefaults"

#define KeyWatchEnabled								@"WatchEnabled"
#define KeyUserID									@"UserID"
#define KeyNickname									@"Nickname"
#define KeyMailAddress								@"MailAddress"

#pragma mark - getalertstatu elements
#define ElementNameUserID							@"user_id"
#define ElementNameUserName							@"user_name"
#define ElementNameCommunityID						@"community_id"
#define ElementNameMSAddress						@"addr"
#define ElementNameMSPort							@"port"
#define ElementNameMSThread							@"thread"
enum {
	idxElementUserID = 1,
	idxElementUserName,
	idxElementCommunityID,
	idxElementMSAddress,
	idxElementMSPort,
	idxElementMSThread
};

#pragma mark - preference keys
#define SavedManualWatchList						@"WatchListTable"
#define SavedWatchAccountList						@"AccountsList"
#endif
