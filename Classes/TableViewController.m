//
//  TableViewController.m
//  handhz
//
//  Created by sam on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

@synthesize searchResult, tableView,tmpCell;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.rowHeight = 73.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
	NSLog(@"numberOfRowsInSection:  %d",self.searchResult.results.count);
	if (self.searchResult.isLoading) return 1;
	if (self.searchResult.isLoaded && self.searchResult.results.count == 0) return 1;
	return self.searchResult.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(!self.searchResult.isLoaded) return loadingCell;
	if(self.searchResult.results.count == 0) return noResultsCell;
	
	GHSite *site = [self.searchResult.results objectAtIndex:indexPath.row];
	
	static NSString *kCellIdentifier = @"SiteCellID";
	SiteTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"SiteTableCell" owner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;	
	}
	
	cell.site = site;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	GHSite *site = [self.searchResult.results objectAtIndex:indexPath.row];
	SitePointViewController *viewController = [(SitePointViewController *)[SitePointViewController alloc] initWithSite:site];
	[SitesViewController sharedInstance].navigationItem.title = site.title;
	[[SitesViewController sharedInstance].navigationController pushViewController:viewController animated:YES];
	[viewController release];	
}

@end
