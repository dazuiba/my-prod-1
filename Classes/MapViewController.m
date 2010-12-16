//
//  MapViewController.m
//  handhz
//
//  Created by sam on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GHSite.h"


@implementation MapViewController

@synthesize site;

- (id)initWithSite:(GHSite *)theSite {
	[super initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
	self.site = theSite;
	return self;
}



- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Back"; 
	[self gotoLocation];
	[mapView addAnnotation:self.site];
}


- (void)gotoLocation
{
	// start off by default in San Francisco
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = site.coordinate.latitude;
	newRegion.center.longitude = site.coordinate.longitude;
	newRegion.span.latitudeDelta = 0.012872;
	newRegion.span.longitudeDelta = 0.009863;
	[mapView setRegion:newRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
}
- (void)dealloc {
	[super dealloc];
}

@end
