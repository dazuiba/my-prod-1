#import <UIKit/UIKit.h>
#import "GHSite.h"
#import "LabeledCell.h"

@class LabeledCell;
@interface SitePointViewController :  UITableViewController <UIActionSheetDelegate>  {
	GHSite *site;	
	IBOutlet LabeledCell *nameCell;
	IBOutlet LabeledCell *countCell;
	IBOutlet LabeledCell *locationCell;
	IBOutlet LabeledCell *servicePhoneCell;
	IBOutlet LabeledCell *serviceTimeCell;
}

@property(nonatomic,retain) GHSite *site;


- (SitePointViewController *)initWithSite:(GHSite *)theSite;

@end
