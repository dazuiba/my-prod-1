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
	lastResult = [NSArray array];
	[mapView setRegion:[handHz region] animated:YES];
	[self.searchResult loadData];
}


- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated
{
	self.searchResult.location = [mapView region];
	//if ([self.searchResult isLoaded]) {		
	lastResult = self.searchResult.results;
		[self.searchResult loadData];
	//}
}


- (void)update {
//	NSArray *oldAnnotations = mapView.annotations;
//	[mapView removeAnnotations:oldAnnotations];
	NSLog(@"lastResult: %d",[lastResult count]);
	if (self.searchResult.results && [self.searchResult.results count]>0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		for (GHSite *site in self.searchResult.results) {
			BOOL found = NO;
			for (MKAnnotation *ann in [mapView annotations]) {
				NSLog(@"%@,%@,%d", [ann title], site.title,([ann title]== site.title));
				if ([[ann title] isEqualToString:site.title]) {
					found =YES;
				}
			}
			if(!found)		 
				[mapView addAnnotation:site];
		}
		//GHSite *first = [self.searchResult.results objectAtIndex:0];
		//[mapView setRegion:[handHz region:first.coordinate] animated:YES];
		[super viewDidLoad];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{ 
	static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)
	[mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
	if (!pinView)
	{
		// if an existing pin view was not available, create one
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
																					 initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
		customPinView.pinColor = MKPinAnnotationColorPurple;
		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;
		
		// add a detail disclosure button to the callout which will open a new view controller page
		//
		// note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
		//  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
		//
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
	// the detail view does not want a toolbar so hide it
	[self.navigationController setToolbarHidden:YES animated:NO];
}
- (void)dealloc {
	[lastResult release];
	[super dealloc];
}


@end
