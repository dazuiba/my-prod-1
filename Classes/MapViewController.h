#import <UIKit/UIKit.h>
#import "SitesViewController.h"
#import "GHSite.h"


@interface MapViewController : UIViewController <UIActionSheetDelegate> {
	GHSite *site;
}

@property(nonatomic,retain) GHSite *site;


- (id)initWithSite:(GHSite *)theSite;

@end
