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
	self.searchResult.location = [mapView region];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self.searchResult loadData];
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
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)
	[mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
	if (!pinView)
	{
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
																					 initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
		customPinView.pinColor = MKPinAnnotationColorPurple;
		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;
		
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self
										action:@selector(showDetails:)
					forControlEvents:UIControlEventTouchUpInside];
		customPinView.rightCalloutAccessoryView = rightButton;
		
		return customPinView;
	}
	else
	{
		pinView.annotation = annotation;
	}
	return pinView;
	
}


- (void)showDetails:(id)sender{
	[self.navigationController setToolbarHidden:YES animated:NO];
}
- (void)dealloc {
	[searchResult release];
	[super dealloc];
}


@end
