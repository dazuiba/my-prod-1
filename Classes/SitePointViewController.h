#import <UIKit/UIKit.h>
#import "GHSite.h"
#import "LabeledCell.h"
#import "SitesViewController.h"
@class LabeledCell;
@interface SitePointViewController :  UIViewController <UIActionSheetDelegate>  {
	GHSite *site;	
	IBOutlet UITableView *tableView;
	IBOutlet LabeledCell *nameCell;
	IBOutlet LabeledCell *countCell;
	IBOutlet LabeledCell *locationCell;
	IBOutlet LabeledCell *servicePhoneCell;
	IBOutlet LabeledCell *serviceTimeCell;
}

@property(nonatomic,retain) GHSite *site;


- (SitePointViewController *)initWithSite:(GHSite *)theSite;
- (IBAction)goBack;

@end
