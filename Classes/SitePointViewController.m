//
//  SitePointViewController.m
//  handhz
//
//  Created by sam on 10-12-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SitePointViewController.h"


@interface SitePointViewController ()
- (void)displaySite;
@end

@implementation SitePointViewController
@synthesize site;

- (SitePointViewController *)initWithSite:(GHSite *)theSite {
	[super initWithNibName:@"SitePointView" bundle:nil];
	self.site = theSite;
	return self;
}
- (IBAction)goBack{
	[[[SitesViewController sharedInstance] navigationController] popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
	//[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
	[super viewDidLoad];	
	[self displaySite];
	[tableView reloadData];
}

- (void)displaySite {
	NSLog(@"SITE: %@",site);
	[nameCell setContentText: [NSString stringWithFormat:@"#%@:%@",site.number,site.name]];
	[locationCell setContentText:site.position_name];
}

#pragma mark TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = indexPath.section;
	NSInteger row = indexPath.row;
	if (section == 0) {
		LabeledCell *cell;
		switch (row) {
			case 0: cell = nameCell; break;
			case 1: cell = countCell; break;
			case 2: cell = locationCell; break;
			case 3: cell = serviceTimeCell; break;
			case 4: cell = servicePhoneCell; break;
			default: cell = nil;
		}
		BOOL isSelectable = row != 0 && cell.hasContent;
		cell.selectionStyle = isSelectable ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
		cell.accessoryType = isSelectable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
		return cell;
	}
	return nil;
}


- (void)dealloc {
	[site release];
	[super dealloc];
}
@end