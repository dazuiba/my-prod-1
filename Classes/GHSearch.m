#import "GHSearch.h"


@implementation GHSearch

@synthesize results;
@synthesize searchTerm;

+ (id)searchWithURLFormat:(NSString *)theFormat{
	return [[[[self class] alloc] initWithURLFormat:theFormat] autorelease];
}

- (id)initWithURLFormat:(NSString *)theFormat{
	[super init];
	urlFormat = [theFormat retain];
	return self;
}

- (void)dealloc {
	[searchTerm release], searchTerm = nil;
	[urlFormat release], urlFormat = nil;
	[results release], results = nil;
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<GHSearch searchTerm:'%@' resourceURL:'%@'>", searchTerm, self.resourceURL];
}
  

- (void)parsingFinished:(id)theResult {
	if ([theResult isKindOfClass:[NSError class]]) {
		self.error = theResult;
		self.loadingStatus = GHResourceStatusNotLoaded;
	} else {
		// Mark the results as not loaded, because the search doesn't contain all attributes
		for (GHResource *res in theResult) res.loadingStatus = GHResourceStatusNotLoaded;
		self.results = theResult;
		self.loadingStatus = GHResourceStatusLoaded;
	}
}

@end
