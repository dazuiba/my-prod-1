//
//  MapIndexViewController.m
//  handhz
//
//  Created by sam on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapIndexViewController.h"
@implementation MapIndexViewController

@synthesize searchResult;
- (void)viewDidLoad {
	[super viewDidLoad];	
	[mapView setRegion:[handHz region] animated:YES];
	[self.searchResult loadData];
}


- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated
{
	NSLog(@"Center: %f",[mapView region].center.latitude);
 
	self.searchResult.location = [mapView region];
	//if ([self.searchResult isLoaded]) {		
		[self.searchResult loadData];
	//}
}


- (void)update {
//	NSArray *oldAnnotations = mapView.annotations;
//	[mapView removeAnnotations:oldAnnotations];
	if (self.searchResult.results && [self.searchResult.results count]>0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		NSLog(@"Map update: %@---%@", mapView, self.searchResult.results);
		[mapView addAnnotations:self.searchResult.results];
		GHSite *first = [self.searchResult.results objectAtIndex:0];
		//[mapView setRegion:[handHz region:first.coordinate] animated:YES];
		[super viewDidLoad];
	}
}


@end
