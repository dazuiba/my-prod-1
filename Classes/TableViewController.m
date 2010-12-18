//
//  TableViewController.m
//  handhz
//
//  Created by sam on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

@synthesize searchResult, tableView;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.searchResult addObserver:self forKeyPath:kResourceLoadingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
	[self.searchResult loadData];
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
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"#%@ %@", site.number, site.name];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", site.position_name];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	id object = [self.searchResult.results objectAtIndex:indexPath.row];
	UIViewController *viewController = [(MapViewController *)[MapViewController alloc] initWithSite:(GHSite *)object];
	
	viewController.hidesBottomBarWhenPushed = YES;
	[[self navigationController] pushViewController:viewController animated:YES];	
	handhzAppDelegate *appDelegate = (handhzAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate hideMainViewNavigationBar:NO];
	[viewController release];
} 


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
		[self.tableView reloadData];
		GHSearch *search = (GHSearch *)object;
		if (!search.isLoading && search.error) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading error" message:@"Could not load the search results" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

@end
