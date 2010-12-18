#import <Foundation/Foundation.h>
#import "GHResource.h"


@interface GHSearch : GHResource {
	NSMutableArray *results;
  @private
	NSString *urlFormat;
	NSString *searchTerm;
	MKCoordinateRegion location;
}

@property(nonatomic,retain)NSMutableArray *results;
@property(nonatomic,retain)NSString *searchTerm;
@property(nonatomic)MKCoordinateRegion location;

+ (id)searchWithURLFormat:(NSString *)theFormat;
- (id)initWithURLFormat:(NSString *)theFormat;

@end


