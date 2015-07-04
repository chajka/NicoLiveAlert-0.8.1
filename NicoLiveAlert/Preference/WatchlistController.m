//
//  WatchlistController.m
//  NicoLiveAlert
//
//  Created by Чайка on 6/30/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "WatchlistController.h"
#import "NicoLiveAlertPreferencesDefinitions.h"
#import "NicoLiveAlertDefinitions.h"

@interface WatchlistController ()

@end

@implementation WatchlistController
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) initWithWatchlist:(NSArray *)list
{
	self = [super initWithNibName:WatchlistNibName bundle:nil];
	if (self) {
		watchList = list;
	}// end if self

	return self;
}// end - (id) init
#pragma mark - override
- (void) awakeFromNib
{
	[aryctrlWatchlist addObjects:watchList];
	[tblviewManualWatchList deselectAll:self];
}// - (void) awakeFromNib

- (void) controlTextDidChange:(NSNotification *)obj
{
	if (![[watchItem stringValue] isEqualToString:EmptyString])
		[btnAddItem setEnabled:YES];
	else
		[btnAddItem setEnabled:NO];
}// end  (void) controlTextDidChange:(NSNotification *)obj

#pragma mark -
#pragma mark MASPreferencesViewController protocol methods

- (NSString *)identifier
{
	return WatchlistIdentifier;
}// end - (NSString *)identifier

- (NSImage *)toolbarItemImage
{
	return [NSImage imageNamed:WatchlistIconName];
}// end - (NSImage *)toolbarItemImage

- (NSString *)toolbarItemLabel
{
	return WatchlistTitileName;
}// end - (NSString *)toolbarItemLabel

#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
- (IBAction) addWatchItem:(id)sender
{
	NSNumber *autoOpen = [NSNumber numberWithBool:NO];
	NSString *item = [watchItem stringValue];
	NSString *note = [watchItemNote stringValue];
	NSMutableDictionary *newWatchItem = [NSMutableDictionary dictionary];

	[newWatchItem setValue:autoOpen forKey:WatchlistAutoOpenKey];
	[newWatchItem setValue:item forKey:WatchlistItemKey];
	[newWatchItem setValue:note forKey:WatchlistNoteKey];

	[aryctrlWatchlist addObject:newWatchItem];

	[watchItem setStringValue:EmptyString];
	[watchItemNote setStringValue:EmptyString];

	[btnAddItem setEnabled:NO];
}// end - (IBAction) addWatchItem:(id)sender

- (IBAction) deleteWatchItem:(id)sender
{
	NSInteger row = [tblviewManualWatchList selectedRow];
	NSDictionary *item = [[aryctrlWatchlist arrangedObjects] objectAtIndex:row];
	[aryctrlWatchlist removeObjectAtArrangedObjectIndex:selectedRow];

	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSMutableArray *watchItems = [NSMutableArray arrayWithArray:[ud arrayForKey:SavedManualWatchList]];
	for (NSDictionary *watchitem in [watchItems reverseObjectEnumerator]) {
		if ([[watchitem valueForKey:WatchlistItemKey] isEqualTo:[item valueForKey:WatchlistItemKey]]) {
			[watchItems removeObject:watchitem];
			[ud setObject:watchItems forKey:SavedManualWatchList];
			break;
		}// end if
	}// end foreach

	[btnDeleteItem setEnabled:NO];
}// end - (IBAction) deleteWatchItem:(id)sender
#pragma mark - messages
- (void) setManualWatchList:(NSArray *)watchlist
{
	for (NSDictionary *item in watchlist) {
		[aryctrlWatchlist addObject:item];
	}
}// end - (void) setManualWatchList:(NSArray *)watchlist

- (void) removeLive:(NSString *)liveID
{
	for (NSDictionary *item in [[aryctrlWatchlist arrangedObjects] reverseObjectEnumerator]) {
		if ([[item valueForKey:WatchlistItemKey] isEqualToString:liveID]) {
			[aryctrlWatchlist removeObject:item];
			break;
		}// end if found live
	}// end foreach
}// end - (void) removeLive:(NSString *)liveID
#pragma mark - private
#pragma mark - C functions
#pragma mark - NSTableView delegae methods
- (BOOL) tableView:(NSTableView *)table shouldSelectRow:(NSInteger)row
{
	if (row > ([[aryctrlWatchlist arrangedObjects] count] - 1))
		return NO;

	selectedRow = row;

	
	[btnDeleteItem setEnabled:TRUE];
	
	return TRUE;
}// end - (BOOL) tableView:(NSTableView *)table shouldSelectRow:(NSInteger)row

/*
- (NSView *) tableView:(NSTableView *)table viewForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#NSView#>;
}// end - (NSView *) tableView:(NSTableView *)table viewForTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (NSTableRowView *) tableView:(NSTableView *)table rowViewForRow:(NSInteger)row
{
	<#code#>
	
	return <#NSTableRowView#>;
}// end - (NSTableRowView *) tableView:(NSTableView *)table rowViewForRow:(NSInteger)row

- (void) tableView:(NSTableView *)table didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row
{
	<#code#>
}// end - (void) tableView:(NSTableView *)table didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row

- (void) tableView:(NSTableView *)table didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row
{
	<#code#>
}// end - (void) tableView:(NSTableView *)table didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row

- (BOOL) tableView:(NSTableView *)table isGroupRow:(NSInteger)row
{
	<#code#>
}// end - (BOOL) tableView:(NSTableView *)table isGroupRow:(NSInteger)row

- (void) tableView:(NSTableView *)table willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)column row:(NSInteger)rowIndex
{
	<#code#>
}// end - (void) tableView:(NSTableView *)table willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)column row:(NSInteger)rowIndex

- (NSCell *)tableView:(NSTableView *)table dataCellForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#NSCell#>;
}// end - (NSCell *) tableView:(NSTableView *)table dataCellForTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (BOOL) tableView:(NSTableView *)table shouldShowCellExpansionForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#BOOL#>
}// end - (BOOL) tableView:(NSTableView *)table shouldShowCellExpansionForTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (BOOL) tableView:(NSTableView *)table shouldShowCellExpansionForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) tableView:(NSTableView *)table shouldShowCellExpansionForTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (BOOL) tableView:(NSTableView *)table shouldEditTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) tableView:(NSTableView *)table shouldEditTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (CGFloat) tableView:(NSTableView *)table heightOfRow:(NSInteger)row
{
	<#code#>
	
	return <#height#>;
}// end - (CGFloat) tableView:(NSTableView *)table heightOfRow:(NSInteger)row

- (CGFloat) tableView:(NSTableView *)table sizeToFitWidthOfColumn:(NSInteger)column
{
	<#code#>
	
	return <#size#>;
}// end - (CGFloat) tableView:(NSTableView *)table sizeToFitWidthOfColumn:(NSInteger)column

- (BOOL) selectionShouldChangeInTableView:(NSTableView *)table
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) selectionShouldChangeInTableView:(NSTableView *)table

- (NSIndexSet *) tableView:(NSTableView *)table selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes
{
	<#code#>
	
	return <#NSIndexSet#>;
}// end - (NSIndexSet *) tableView:(NSTableView *)table selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes

- (BOOL) tableView:(NSTableView *)table shouldSelectTableColumn:(NSTableColumn *)column
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) tableView:(NSTableView *)table shouldSelectTableColumn:(NSTableColumn *)column

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
	<#code#>
}// end - (void) tableViewSelectionDidChange:(NSNotification *)notification

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
	<#code#>
}// end - (void) tableViewSelectionDidChange:(NSNotification *)notification

- (BOOL) tableView:(NSTableView *)table shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) tableView:(NSTableView *)table shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString

- (NSString *) tableView:(NSTableView *)table typeSelectStringForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#NSString#>;
}// end - (NSString *) tableView:(NSTableView *)table typeSelectStringForTableColumn:(NSTableColumn *)column row:(NSInteger)row

- (NSInteger) tableView:(NSTableView *)table nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow forString:(NSString *)searchString
{
	<#code#>
	
	return <#NSInteger#>
}// end - (NSInteger) tableView:(NSTableView *)table nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow forString:(NSString *)searchString

- (BOOL) tableView:(NSTableView *)table shouldReorderColumn:(NSInteger)columnIndex toColumn:(NSInteger)newColumnIndex
{
	<#code#>
	
	return <#BOOL#>
}// end - (BOOL) tableView:(NSTableView *)table shouldReorderColumn:(NSInteger)columnIndex toColumn:(NSInteger)newColumnIndex

- (void) tableView:(NSTableView *)table didDragTableColumn:(NSTableColumn *)column
{
	<#code#>
}// end - (void) tableView:(NSTableView *)table didDragTableColumn:(NSTableColumn *)column

- (void) tableViewColumnDidMove:(NSNotification *)notification
{
	<#code#>
}// end - (void) tableViewColumnDidMove:(NSNotification *)notification

- (void) tableViewColumnDidResize:(NSNotification *)notification
{
	<#code#>
}// end - (void) tableViewColumnDidResize:(NSNotification *)notification

- (void) tableView:(NSTableView *)table mouseDownInHeaderOfTableColumn:(NSTableColumn *)column
{
	<#code#>
}// end - (void) tableView:(NSTableView *)table mouseDownInHeaderOfTableColumn:(NSTableColumn *)column

- (BOOL) tableView:(NSTableView *)table shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
	<#code#>
	
	return <#BOOL#>;
}// end - (BOOL) tableView:(NSTableView *)table shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)column row:(NSInteger)row
*/
@end
