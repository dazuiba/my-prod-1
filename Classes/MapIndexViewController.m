#import "MapIndexViewController.h"
@implementation MapIndexViewController

@synthesize searchResult;
- (void)viewDidLoad {
	mapView.showsUserLocation = YES;

	[super viewDidLoad];	
	
	[mapView setRegion:[handHz region] animated:YES];
	[self.searchResult loadData];
}


- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"navigationController: %@",[SitesViewController sharedInstance].navigationController);
	[[SitesViewController sharedInstance].navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated{
	self.searchResult.location = [mapView region];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self.searchResult loadData];
}

- (void)moveToCurrentLocation {
	CLLocationCoordinate2D theLocation = [mapView.userLocation coordinate];
	if (![handHz regionInHz:theLocation]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您不在杭州市区内" message:@"系统将使用缺省位置" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		theLocation = [handHz region].center;
	}
	[mapView setCenterCoordinate:theLocation animated:YES];
}

- (void)update {
	NSArray *sitesResult = [[NSArray alloc] initWithArray:self.searchResult.results];
	if (sitesResult && [sitesResult count]>0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		for (GHSite *site in sitesResult) {
			BOOL found = NO;
			for (MKAnnotation *ann in [mapView annotations]) {
				if ([[ann title] isEqualToString:site.title]) {
					found =YES;
				}
			}
			if(!found)		 
				[mapView addAnnotation:site];
		}		
	}
	
	[sitesResult release];
	[super viewDidLoad];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{ 
	static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
	if ([annotation isKindOfClass:[GHSite class]]) {
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
		if (!pinView){
			MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
																						 initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
			customPinView.pinColor = MKPinAnnotationColorPurple;
			customPinView.animatesDrop = YES;
			customPinView.canShowCallout = YES;
			
			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			rightButton.tag = ((GHSite *)annotation).number;
			[rightButton addTarget:self
											action:@selector(showDetails:)
						forControlEvents:UIControlEventTouchUpInside];
			customPinView.rightCalloutAccessoryView = rightButton;
			return customPinView;
		}else{
			pinView.annotation = annotation;
		}
		return pinView;		
	}else {
		return [mapView viewForAnnotation:mapView.userLocation];
	}	
} 

- (void) showDetails:(id)sender{
	NSInteger *siteID = ((UIButton*)sender).tag;
	GHSite *site = [searchResult findSiteByNumber:siteID];
	NSLog(@"ss: %@",site);
	
	SitePointViewController *viewController = [(SitePointViewController *)[SitePointViewController alloc] initWithSite:site];
	
  [[SitesViewController sharedInstance].navigationController pushViewController:viewController animated:YES];
	[viewController release];
}



- (void)dealloc {
	[searchResult release];
	[super dealloc];
}


@end
