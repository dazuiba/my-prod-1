//
//  MapViewController.m
//  handhz
//
//  Created by sam on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GHSite.h"
#import "handHz.h"
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
	[mapView setRegion:[handHz region:site.coordinate.latitude withLng: site.coordinate.longitude] animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
}
- (void)dealloc {
	[super dealloc];
}

@end
