//
//  SitesController.m
//  HandHZ
//
//  Created by sam on 10-12-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SitesViewController.h"
#import <CoreLocation/CoreLocation.h>
@implementation SitesViewController

@synthesize tableView,toolBar,searchControl,loadingCell,noResultsCell;
@synthesize searchResult;


CLLocation *coords;
- (void)viewDidLoad {
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
	searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
	searchBarView.autoresizingMask = 0;
	searchBar.delegate = self;
	[searchBarView addSubview:searchBar];
	self.navigationItem.titleView = searchBarView;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showActions:)];

	NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:3];
	NSLog(@"VI:%@",self.toolBar.items);
	[toolbarItems addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reticle.png"]  style:UIBarButtonItemStyleDone target:self action:@selector(showActions:)]];
	[toolbarItems addObjectsFromArray:self.toolBar.items];
	[self.toolBar setItems:toolbarItems animated:NO];
	[super viewDidLoad];
	self.searchResult = [GHSearch searchWithURLFormat:kUserSearchFormat];
	[searchResult addObserver:self forKeyPath:kResourceLoadingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self.locationManager startUpdatingLocation];
} 

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	self.searchResult.searchTerm = searchBar.text;
	[self.searchResult loadData];
	//[self quitSearching:nil];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if (self.searchResult.isLoading) return 1;
	if (self.searchResult.isLoaded && self.searchResult.results.count == 0) return 1;
	return self.searchResult.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return loadingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
        return locationManager;
    }
	
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
	
    return locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
													 fromLocation:(CLLocation *)oldLocation {
    
    coords = newLocation;
    NSLog(@"Location: %@", [newLocation description]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@", [error description]);
}


- (void)dealloc {
	[searchBar release];
	[tableView release];
	[searchControl release];
	[loadingCell release];
	[noResultsCell release];
    [super dealloc];
}

@end
