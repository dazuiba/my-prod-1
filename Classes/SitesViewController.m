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
static SitesViewController *_sharedInstance;

+ (SitesViewController*) sharedInstance{
    return _sharedInstance;
}

//- (void)viewWillAppear:(BOOL)animated{
//	NSLog(@"1.navigationController: %@",self.navigationController);
//	[self.navigationController setNavigationBarHidden:YES animated:NO];
//}


- (void) viewWillAppear:(BOOL)animated {
	
//	[self addTopSearchBar];
//	handhzAppDelegate *appDelegate = (handhzAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[appDelegate hideMainViewNavigationBar:YES];
	
//	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	coords = [[CLLocation alloc] initWithLatitude:kMapInitLat longitude: kMapInitLng];
	NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:3];
	[toolbarItems addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reticle.png"]  
																													 style:UIBarButtonItemStyleDone target:self.mapIndexViewController
																													 action:@selector(moveToCurrentLocation)]];
	[toolbarItems addObjectsFromArray:self.toolBar.items];
	[self addTopSearchBar];
	
	overlayController = [[OverlayController alloc] initWithTarget:self andSelector:@selector(quitSearching:)];
	overlayController.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);

	[self.toolBar setItems:toolbarItems animated:NO];
	
	self.searchResult = [GHSearch searchWithURLFormat:kResourceSearchBikeSite];
	
	[self.searchResult addObserver:self forKeyPath:kResourceLoadingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
	self.mapIndexViewController.searchResult = searchResult;
	//[self.searchResult loadData];
	[self.view insertSubview:self.mapIndexViewController.view atIndex:0];
	[toolbarItems release];
	_sharedInstance=self;
} 


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	
	
	
	if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {	
		GHSearch *search = (GHSearch *)object;
		if (!search.isLoading && search.error) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务器故障" message:@"服务器链接失败，请稍候重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}else {
			if(!search.isLoading && search.results && [search.results count] > 0){
				[self.mapIndexViewController update];
			}
		}
	}
	
	
}
 
- (IBAction)switchViews:(id)sender{
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:kFlipDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if(self.tableViewController.view.superview == nil){
		self.tableViewController.searchResult = searchResult;
		[self switchViews:self.tableViewController hideView:self.mapIndexViewController];
		[self.tableViewController.tableView reloadData];
 	}else{
		self.mapIndexViewController.searchResult = searchResult;		
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
	[self.view insertSubview:toShow.view atIndex:0];
	[toHide viewDidDisappear:YES];
	[toShow viewDidAppear:YES];
	[UIView commitAnimations];
}


- (void) addTopSearchBar{
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 300.0, 44.0)];
	searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
	searchBarView.autoresizingMask = 0;
	searchBar.delegate = self;
	[searchBarView addSubview:searchBar];
	self.navigationItem.titleView = searchBarView;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(se:)] autorelease];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	NSLog(@"Search: %@", searchBar.text);
	if(searchBar.text){
		self.searchResult.searchTerm = searchBar.text;
	}
	[self.searchResult loadData];
	[self quitSearching:nil];
}





- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	[self.view insertSubview:overlayController.view aboveSubview:self.parentViewController.view];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(quitSearching:)] autorelease];
}

- (void)quitSearching:(id)sender {
	searchBar.text = self.searchResult.searchTerm;
	[searchBar resignFirstResponder];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(se:)] autorelease];
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
	[coords release];
	[self.tableViewController release];
	[searchControl release];
    [super dealloc];
}

@end
