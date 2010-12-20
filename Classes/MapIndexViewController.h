//
//  MapIndexViewController.h
//  handhz
//
//  Created by sam on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GHSearch.h"
#import "GHSite.h"
#import "handHz.h"
@class MKAnnotation;

@interface MapIndexViewController : UIViewController <MKMapViewDelegate> {
	
	IBOutlet MKMapView *mapView;
	GHSearch *searchResult;
}
@property (nonatomic, retain) GHSearch *searchResult;

- (void)update;
- (void)moveToCurrentLocation;
@end
