//
//  SitesController.m
//  HandHZ
//
//  Created by sam on 10-12-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SitesViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SitesViewController() 
- (void) addTopSearchBar;	
- (void)quitSearching:(id)sender;
- (void)currentLocationButtonClicked;
- (UIViewController *)currentViewController;

- (void)switchViews:(UIViewController *)switchViews hideView:(UIViewController *)toHide;
@end

@implementation SitesViewController

@synthesize toolBar,searchControl, tableViewController,mapIndexViewController;
@synthesize searchResult;

CLLocation *coords ;

- (void)viewDidLoad {
	[super viewDidLoad]; 
	self.title = @"主界面";
	coords = [[CLLocation alloc] initWithLatitude:kMapInitLat longitude: kMapInitLng];
	NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:3];
	[toolbarItems addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reticle.png"]  style:UIBarButtonItemStyleDone target:self action:@selector(currentLocationButtonClicked)]];
	[toolbarItems addObjectsFromArray:self.toolBar.items];
	[self addTopSearchBar];
	
	overlayController = [[OverlayController alloc] initWithTarget:self andSelector:@selector(quitSearching:)];
	overlayController.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);

	[self.toolBar setItems:toolbarItems animated:NO];
	
	self.searchResult = [GHSearch searchWithURLFormat:kResourceSearchBikeSite];
	
	[self.searchResult addObserver:self forKeyPath:kResourceLoadingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
	self.mapIndexViewController.searchResult = searchResult;
//	[self.searchResult loadData];
	[self.view insertSubview:self.mapIndexViewController.view atIndex:0];
} 


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {	
		GHSearch *search = (GHSearch *)object;
		if (!search.isLoading && search.error) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading error" message:@"Could not load the search results" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}else {
			NSLog(@"observ: %@",search.results);
			if(search.results && [search.results count] > 0){
				[self.mapIndexViewController update];
			}
		}

	}
}
 
- (IBAction)switchViews:(id)sender{
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.43];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if(self.tableViewController.view.superview == nil){
		self.tableViewController.searchResult = searchResult;
		[self switchViews:self.tableViewController hideView:self.mapIndexViewController];		
 	}else{
		self.mapIndexViewController.searchResult = searchResult;		
		NSLog(@"mapIndexViewController: %@",self.mapIndexViewController);
		NSLog(@"mapIndexViewController.view: %@",self.mapIndexViewController.view);
		[self switchViews:self.mapIndexViewController hideView:self.tableViewController];
	}

}

- (void)switchViews:(UIViewController *)toShow hideView:(UIViewController *)toHide{
	
	[UIView setAnimationTransition:
	 UIViewAnimationTransitionFlipFromRight
												 forView:self.view cache:YES];
	
	[toShow viewWillAppear:YES];
	[toHide viewWillDisappear:YES];
	[toHide.view removeFromSuperview];
	NSLog(@"switchViews: %@",toShow);
	NSLog(@"switchViews.view: %@",toShow.view);
	[self.view insertSubview:toShow.view atIndex:0];
	[toHide viewDidDisappear:YES];
	[toShow viewDidAppear:YES];
	[UIView commitAnimations];
}

//
//- (void) viewWillAppear:(BOOL)animated {
//	
//	[self addTopSearchBar];
//	handhzAppDelegate *appDelegate = (handhzAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[appDelegate hideMainViewNavigationBar:YES];
//	
//	[super viewWillAppear:animated];
//}

- (void) addTopSearchBar{
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 300.0, 44.0)];
	searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
	searchBarView.autoresizingMask = 0;
	searchBar.delegate = self;
	[searchBarView addSubview:searchBar];
	self.navigationItem.titleView = searchBarView;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(se:)] autorelease];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	NSLog(@"Search: %@", searchBar.text);
	self.searchResult.searchTerm = searchBar.text;
	[self.searchResult loadData];
	[self quitSearching:nil];
}





- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	[self.view insertSubview:overlayController.view aboveSubview:self.parentViewController.view];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(quitSearching:)] autorelease];
}

- (void)quitSearching:(id)sender {
	searchBar.text = self.searchResult.searchTerm;
	[searchBar resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	[overlayController.view removeFromSuperview];
}

- (void)currentLocationButtonClicked{
	[self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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
	[searchResult removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
	[searchResult release];
	[searchBar release];
	[self.tableViewController release];
	[searchControl release];
    [super dealloc];
}

@end
