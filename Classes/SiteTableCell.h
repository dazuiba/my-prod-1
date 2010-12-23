#import <Foundation/Foundation.h>
#import "RatingView.h"
#import "GHSite.h"
#import "OHAttributedLabel.h"
@interface SiteTableCell : UITableViewCell
{
	IBOutlet UILabel *numberView;
	IBOutlet UILabel *nameLabel;
	IBOutlet UIView *ratingView;
	IBOutlet OHAttributedLabel *numRatingsLabel;
}
@property (nonatomic, retain) GHSite *site;

@end
