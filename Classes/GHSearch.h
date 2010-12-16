#import <Foundation/Foundation.h>
#import "GHResource.h"


@interface GHSearch : GHResource {
	NSMutableArray *results;
  @private
	NSString *urlFormat;
	NSString *searchTerm;
}

@property(nonatomic,retain)NSMutableArray *results;
@property(nonatomic,retain)NSString *searchTerm;

+ (id)searchWithURLFormat:(NSString *)theFormat;
- (id)initWithURLFormat:(NSString *)theFormat;

@end


