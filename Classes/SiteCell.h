#import <UIKit/UIKit.h>
#import "GHSite.h"


@interface SiteCell : UITableViewCell {
	GHSite *site;
}

@property(nonatomic,retain)GHSite *site;


@end
