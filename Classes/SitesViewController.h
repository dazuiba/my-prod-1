//
//  FirstViewController.h
//  HandHZ
//
//  Created by sam on 10-12-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GHSearch.h"
#import "SiteCell.h"
#import "GHSite.h"
#import "OverlayController.h"
#import "TableViewController.h"
#import "MapIndexViewController.h"

@class TableViewController;
@class MapIndexViewController;
@interface SitesViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate> {
  @private
	 UISearchBar *searchBar;
	 IBOutlet UINavigationItem *navigationItem;
	 IBOutlet UIToolbar *toolBar;
	
	 OverlayController *overlayController;
	 TableViewController *tableViewController; 
	 MapIndexViewController *mapIndexViewController;
	
	 UISegmentedControl *searchControl;
	
	 CLLocation *coords;	
	 CLLocationManager *locationManager;
	 GHSearch *searchResult;
}


@property (nonatomic, retain) GHSearch *searchResult;
@property (nonatomic, retain) IBOutlet UISegmentedControl *searchControl;
@property (nonatomic, retain) IBOutlet TableViewController *tableViewController;
@property (nonatomic, retain) IBOutlet MapIndexViewController *mapIndexViewController;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain, readonly) CLLocationManager *locationManager;

- (IBAction)switchViews:(id)sender;


@end
