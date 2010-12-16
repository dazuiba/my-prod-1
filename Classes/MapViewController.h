#import <UIKit/UIKit.h>
#import "SitesViewController.h"
#import "GHSite.h"


@interface MapViewController : UIViewController <MKMapViewDelegate> {
	GHSite *site;
	IBOutlet MKMapView *mapView;
}

@property(nonatomic,retain) GHSite *site;


- (id)initWithSite:(GHSite *)theSite;

@end
