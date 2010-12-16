#import "SiteCell.h"


@implementation SiteCell

@synthesize site;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	self.textLabel.font = [UIFont systemFontOfSize:16.0f];
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.opaque = YES;
	return self;
}

- (void)dealloc {
	[site release];
	[super dealloc];
}

- (void)setSite:(GHSite *)theSite {
	[theSite retain];
	[site release];
	site = theSite;
	self.imageView.image = [UIImage imageNamed:([site haveLocation] ? @"no-location.png" : @"have-location.png")];
	self.textLabel.text = [NSString stringWithFormat:@"%@/%@", site.name, site.position_name];
}
@end