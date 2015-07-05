//
//  NLStatusbar.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/5/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "NLStatusbar.h"
#import <QuartzCore/QuartzCore.h>
#import "NicoLiveAlertDefinitions.h"

static CGFloat origin = 0.0;
static CGFloat iconSizeH = 20.0;
static CGFloat iconSizeW = 20.0;
static CGFloat noProgWidth = 20.0;
static CGFloat disconnectPathWidth = 3.0;
static CGFloat disconnectPathOffset = 5.0;
static CGFloat haveProgWidth = 41.0;
static CGFloat noProgPower = 0.3;
static CGFloat progCountFontSize = 11;
static CGFloat progCountPointY = 1.5;
static CGFloat progCountPointSingleDigitX = 27.0;
static CGFloat progCountBackGroundWidth = 14.8;
static CGFloat progCountBackGrountFromX = 28.0;
static CGFloat progCountBackGrountFromY = 8.5;
static CGFloat progCountBackGrountToX = 34.0;
static CGFloat progCountBackGrountToY = 8.5;
static CGFloat progCountBackDigitOffset = 6.5;
static CGFloat progCountBackColorRed = 000.0/256.0;
static CGFloat progCountBackColorGreen = 153.0/256.0;
static CGFloat progCountBackColorBlue = 051.0/256.0;
static CGFloat progCountBackColorAlpha = 1.00;
static CGFloat disconnectedColorRed = 256.0/256.0;
static CGFloat disconnectedColorGreen = 000.0/256.0;
static CGFloat disconnectedColorBlue = 000.0/256.0;
static CGFloat disconnectedColorAlpha = 0.70;

@interface NLStatusbar ()
- (void) setupMembers:(NSString *)imageName;
- (CIImage *) createFromResource:(NSString *)imageName;
- (void) installStatusbar;
@end

@implementation NLStatusbar
#pragma mark - synthesize properties
@synthesize numberOfPrograms;
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) initWithMenu:(NSMenu *)menu andImageName:(NSString *)name
{
	self = [super init];
	if (self) {
		connected = NO;
		userState = NSOffState;
		statusbarMenu = menu;
		[self setupMembers:name];

		userProgramCount = 0;
		officialProgramCount = 0;
		[self installStatusbar];
		[self makeStatusbarIcon];
	}// end if self

	return self;
}// end - (id) initWithMenu:(NSMenu *)menu andImageName:(NSString *)name
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
- (BOOL) connected
{
	return connected;
}// - (BOOL) connected

- (void) setConnected:(BOOL)connected_
{
	connected = connected_;
	[self makeStatusbarIcon];
}// - (void) setConnected:(BOOL)connected_

- (void) toggleConnected
{
	connected = !connected;
	[self makeStatusbarIcon];
}// end - (void) toggleConnected

- (NSCellStateValue) userState
{
	return userState;
}// end - (NSInteger) userState

- (void) setUserState:(NSCellStateValue)state
{
	userState = state;
	[self makeStatusbarIcon];
}// end - (void) setUserState:(NSInteger)state

- (BOOL) watchOfficial
{
	return watchOfficial;
}// end - (BOOL) watchOfficial

- (void) setWatchOfficial:(BOOL)watch
{
	watchOfficial = watch;
	[[statusbarMenu itemWithTag:tagOfficial] setHidden:!watchOfficial];
}

#pragma mark - actions
#pragma mark - messages
- (void) connectionRised:(NSNotification *)aNotification
{
	if (connected == YES)
		return;
	// end if recieve rise but already conected
	
	connected = YES;
	[self makeStatusbarIcon];
}// end - (void) connectionRised

- (void) connectionDown:(NSNotification *)aNotification
{
	connected = NO;
	[self makeStatusbarIcon];
}// end - (void) connectionDown

#pragma mark - private
- (void) updateToolTip
{
	NSMutableString *tooltip = nil;
	NSMutableArray *array = [NSMutableArray array];
	if (connected == NO)
	{
		[statusBarItem setToolTip:DeactiveConnection];
		return;
	}// end if disconnected
	
	if ((userProgramCount == 0) && (officialProgramCount == 0))
	{
		[statusBarItem setToolTip:ActiveNoprogString];
		return;
	}// end if program not found
	
	if (userProgramCount > 0)
	{
		tooltip = [NSMutableString stringWithFormat:userProgramOnly, userProgramCount];
		if (userProgramCount > 1)
			[tooltip appendString:TwoOrMoreSuffix];
		// end if program count is two or more
		[array addObject:tooltip];
		tooltip = nil;
	}// end if user program found
	
	if (officialProgramCount > 0)
	{
		tooltip = [NSMutableString stringWithFormat:officialProgramOnly, officialProgramCount];
		if (officialProgramCount > 1)
			[tooltip appendString:TwoOrMoreSuffix];
		// end if program count is two or more
		[array addObject:tooltip];
		tooltip = nil;
	}// end if user program found
	
	[statusBarItem setToolTip:[array componentsJoinedByString:StringConcatinater]];
}// end - (void) updateToolTip

- (void) setupMembers:(NSString *)imageName
{
#if __has_feature(objc_arc)
#else
#endif
	drawPoint = NSMakePoint(progCountPointSingleDigitX, progCountPointY);
	iconSize = NSMakeSize(iconSizeW, iconSizeH);
	sourceImage = [self createFromResource:imageName];
	statusbarIcon = [[NSImage alloc] initWithSize:iconSize];
	statusbarAlt = [[NSImage alloc] initWithSize:iconSize];
	gammaFilter = [CIFilter filterWithName:@"CIGammaAdjust"];
	gammaPower = [NSNumber numberWithFloat:noProgPower];
	invertFilter = [CIFilter filterWithName:@"CIColorInvert"];
	progCountFont = [NSFont fontWithName:@"CourierNewPS-BoldItalicMT" size:progCountFontSize];
	fontAttrDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSColor whiteColor], NSForegroundColorAttributeName, progCountFont,NSFontAttributeName, nil];
	fontAttrInvertDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSColor blackColor], NSForegroundColorAttributeName, progCountFont ,NSFontAttributeName, nil];
	// create bezier path for program number's background
	progCountBackground = [NSBezierPath bezierPath];
	[progCountBackground setLineCapStyle:NSRoundLineCapStyle];
	[progCountBackground setLineWidth:progCountBackGroundWidth];
	[progCountBackground moveToPoint:NSMakePoint(progCountBackGrountFromX, progCountBackGrountFromY)];
	[progCountBackground lineToPoint:NSMakePoint(progCountBackGrountToX, progCountBackGrountToY)];
	
	// create bezier path for dissconect cross mark
	disconnectPath = [[NSBezierPath alloc] init];
	[disconnectPath setLineCapStyle:NSRoundLineCapStyle];
	[disconnectPath setLineWidth:disconnectPathWidth];
	[disconnectPath moveToPoint:NSMakePoint(disconnectPathOffset, disconnectPathOffset)];
	[disconnectPath lineToPoint:NSMakePoint((iconSizeW - disconnectPathOffset), (iconSizeH - disconnectPathOffset))];
	[disconnectPath moveToPoint:NSMakePoint(disconnectPathOffset, (iconSizeH - disconnectPathOffset))];
	[disconnectPath lineToPoint:NSMakePoint(iconSizeH - disconnectPathOffset, disconnectPathOffset)];
	
	// make each color for background and disconnect cross
	progCountBackColor = [NSColor colorWithCalibratedRed:progCountBackColorRed green:progCountBackColorGreen blue:progCountBackColorBlue alpha:progCountBackColorAlpha];
	disconnectColor = [NSColor colorWithCalibratedRed:disconnectedColorRed green:disconnectedColorGreen blue:disconnectedColorBlue alpha:disconnectedColorAlpha];
#if __has_feature(objc_arc)
#else
#endif
}// end - (void) setupMembers

- (CIImage *) createFromResource:(NSString *)imageName
{
	NSImage *image = [NSImage imageNamed:imageName];
	NSData *imageData = [image TIFFRepresentation];
	
	return [CIImage imageWithData:imageData];
}// end - (CIImage *) createFromResource:(NSString *)imageName


- (void) installStatusbar
{
	statusBar = [NSStatusBar systemStatusBar];
	statusBarItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];

	[statusBarItem setTitle:EmptyString];
	[statusBarItem setImage:statusbarIcon];
	[statusBarItem setAlternateImage:statusbarAlt];
	[statusBarItem setToolTip:@"NicoLiveAlert"];
	[statusBarItem setHighlightMode:YES];
	[statusBarItem setMenu:statusbarMenu];
}// end - (void) installStatusbar

- (void) makeStatusbarIcon
{
	@autoreleasepool {
		CIImage *invertImage = nil;
		CIImage *destImage = nil;
		[statusbarIcon setSize:iconSize];
		[statusbarAlt setSize:iconSize];
		if ((userState == NSOffState) || (connected == NO))
		{		// crop image
			// gamma adjust image
			[gammaFilter setValue:sourceImage forKey:@"inputImage"];
			[gammaFilter setValue:gammaPower forKey:@"inputPower"];
			destImage = [gammaFilter valueForKey:@"outputImage"];
		}
		else
		{
			destImage = sourceImage;
		}// end if number of programs
		
		[invertFilter setValue:destImage forKey:@"inputImage"];
		invertImage = [invertFilter valueForKey:@"outputImage"];
		
		NSCIImageRep *sb = [NSCIImageRep imageRepWithCIImage:destImage];
		NSCIImageRep *alt = [NSCIImageRep imageRepWithCIImage:invertImage];
		
		// draw program count on image
		NSString *progCountStr = [NSString stringWithFormat:@"%ld", numberOfPrograms];
		if ((numberOfPrograms == 0) || (connected == NO))
		{
			statusbarIcon = [[NSImage alloc] initWithSize:NSMakeSize(noProgWidth, iconSizeW)];
			statusbarAlt = [[NSImage alloc] initWithSize:NSMakeSize(noProgWidth, iconSizeW)];
		}
		else if (numberOfPrograms > 99)
		{
			[progCountBackground removeAllPoints];
			[progCountBackground moveToPoint:NSMakePoint(progCountBackGrountFromX, progCountBackGrountFromY)];
			[progCountBackground lineToPoint:NSMakePoint(progCountBackGrountToX + (progCountBackDigitOffset * 2), progCountBackGrountToY)];
			statusbarIcon = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth + (progCountBackDigitOffset * 2), iconSizeW)];
			statusbarAlt = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth + (progCountBackDigitOffset * 2), iconSizeW)];
		}
		else if (numberOfPrograms > 9)
		{
			[progCountBackground removeAllPoints];
			[progCountBackground moveToPoint:NSMakePoint(progCountBackGrountFromX, progCountBackGrountFromY)];
			[progCountBackground lineToPoint:NSMakePoint(progCountBackGrountToX + progCountBackDigitOffset, progCountBackGrountToY)];
			statusbarIcon = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth + progCountBackDigitOffset, iconSizeW)];
			statusbarAlt = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth + progCountBackDigitOffset, iconSizeW)];
		}
		else if (numberOfPrograms > 0)
		{
			[progCountBackground removeAllPoints];
			[progCountBackground moveToPoint:NSMakePoint(progCountBackGrountFromX, progCountBackGrountFromY)];
			[progCountBackground lineToPoint:NSMakePoint(progCountBackGrountToX, progCountBackGrountToY)];
			statusbarIcon = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth, iconSizeW)];
			statusbarAlt = [[NSImage alloc] initWithSize:NSMakeSize(haveProgWidth, iconSizeW)];
		}// end if adjust icon withd by program count.
		
		// draw for image.
		[statusbarIcon lockFocus];
		[sb drawAtPoint:NSMakePoint(origin, origin)];
		// set connect/disconnect status
		if (connected == NO)
		{
			[disconnectColor set];
			[disconnectPath stroke];
		}// end if disconnected
		[progCountBackColor set];
		[progCountBackground stroke];
		[progCountStr drawAtPoint:drawPoint withAttributes:fontAttrDict];
		[statusbarIcon unlockFocus];
		
		// draw for alt image.
		[statusbarAlt lockFocus];
		[alt drawAtPoint:NSMakePoint(origin, origin)];
		[[NSColor whiteColor] set];
		if (connected == NO)
		{
			[disconnectPath stroke];
		}// end if disconnected
		[progCountBackground stroke];
		[progCountStr drawAtPoint:drawPoint withAttributes:fontAttrInvertDict];
		[statusbarAlt unlockFocus];
		
		// update status bar icon.
		[statusBarItem setImage:statusbarIcon];
		[statusBarItem setAlternateImage:statusbarAlt];
		
		// update tooltip
		[self updateToolTip];
		
	}
}// end - (CIImage *) makeStatusbarIcon

#pragma mark - C functions

@end
