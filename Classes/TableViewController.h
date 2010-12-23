#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GHSearch.h"
#import "SiteTableCell.h"
#import "GHSite.h"
#import "OverlayController.h"
#import "MapViewController.h"
#import "handhzAppDelegate.h"

@interface TableViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate>  {
	
	UITableView *tableView;
	UITableViewCell *loadingCell;
	UITableViewCell *noResultsCell;
	SiteTableCell *tmpCell;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *loadingCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *noResultsCell;
@property (nonatomic, retain) GHSearch *searchResult;
@property (nonatomic, assign) IBOutlet SiteTableCell *tmpCell;

@end
