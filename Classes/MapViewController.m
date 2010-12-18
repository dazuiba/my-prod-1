//
//  MapViewController.m
//  handhz
//
//  Created by sam on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GHSite.h"

#import "AppConstants.h"
@interface MapViewController()
- (void)gotoLocation;
@end

@implementation MapViewController

@synthesize site;

- (id)initWithSite:(GHSite *)theSite {
	[super initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
	self.site = theSite;
	return self;
}



- (void)viewDidLoad {
	[super viewDidLoad];
	[mapView addAnnotation:self.site];
	[self gotoLocation];
}


- (void)gotoLocation {
	// start off by default in San Francisco
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = site.coordinate.latitude;
	newRegion.center.longitude = site.coordinate.longitude;
	newRegion.span.latitudeDelta = kMapInitSpanDeltaLat;
	newRegion.span.longitudeDelta = kMapInitSpanDeltaLng;
	[mapView setRegion:newRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
}
- (void)dealloc {
	[super dealloc];
}

@end
