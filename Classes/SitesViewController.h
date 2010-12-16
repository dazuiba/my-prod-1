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

@interface SitesViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate> {
  @private
	 UITableView *tableView;
	 UISearchBar *searchBar;
	 IBOutlet UINavigationItem *navigationItem;
	 IBOutlet UIToolbar *toolBar;

	 UISegmentedControl *searchControl;
	 UITableViewCell *loadingCell;
	 UITableViewCell *noResultsCell;
	 CLLocation *coords;	
	 CLLocationManager *locationManager;
	 GHSearch *searchResult;
}


@property (nonatomic, retain) GHSearch *searchResult;
@property (nonatomic, retain) IBOutlet UISegmentedControl *searchControl;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *loadingCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *noResultsCell;

@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain, readonly) CLLocationManager *locationManager;
@end
