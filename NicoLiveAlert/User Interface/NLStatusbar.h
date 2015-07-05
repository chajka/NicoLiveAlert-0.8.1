//
//  NLStatusbar.h
//  NicoLiveAlert
//
//  Created by Чайка on 7/5/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface NLStatusbar : NSObject {
	NSStatusItem				*statusBarItem;
	NSStatusBar					*statusBar;
	NSMenu						*statusbarMenu;
	BOOL						connected;
	BOOL						watchOfficial;
	NSCellStateValue			userState;
	NSInteger					numberOfPrograms;
	NSSize						iconSize;
	CIImage						*sourceImage;
	NSImage						*statusbarIcon;
	NSImage						*statusbarAlt;
	CIFilter					*gammaFilter;
	NSNumber					*gammaPower;
	CIVector					*noProgVect;
	CIVector					*haveProgVect;
	CIFilter					*invertFilter;
	NSPoint						drawPoint;
	NSFont						*progCountFont;
	NSDictionary				*fontAttrDict;
	NSDictionary				*fontAttrInvertDict;
	NSBezierPath				*progCountBackground;
	NSBezierPath				*disconnectPath;
	NSColor						*progCountBackColor;
	NSColor						*disconnectColor;
	NSInteger					userProgramCount;
	NSInteger					officialProgramCount;
	
}

- (id) initWithMenu:(NSMenu *)menu andImageName:(NSString *)name;
@end
