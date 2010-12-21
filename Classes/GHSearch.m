#import "GHSearch.h"
#import "GHSite.h"

@implementation GHSearch

@synthesize searchTerm,location,results;

+ (id)searchWithURLFormat:(NSString *)theFormat{
	return [[[[self class] alloc] initWithURLFormat:theFormat] autorelease];
}

- (id)initWithURLFormat:(NSString *)theFormat{
	[super init];
	urlFormat = [theFormat retain];
	return self;
}

- (NSURL *)resourceURL {
	NSString *key = @"";
	NSString *ll = @"";	
	
	if (searchTerm) {
		key = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
	}
	
	if (location.center.latitude) {
		ll = [NSString stringWithFormat:@"%f,%f&span=%f,%f",location.center.latitude,location.center.longitude,location.span.latitudeDelta,location.span.longitudeDelta];
	}
	NSString *urlString = [NSString stringWithFormat:urlFormat, key,ll];
	NSURL *url = [NSURL URLWithString:urlString];
	return url;
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
  
- (GHSite *)findSiteByNumber: (NSInteger *)number{
	for (GHSite *site in self.results) {
		if (site.number == number) {
			return site;
		}
	}
	NSAssert(NO,@"shoud find");
}

- (void)parsingFinished:(NSArray *)dictArray {
	
		
	if ([dictArray isKindOfClass:[NSError class]]) {
		self.error = (NSError *)dictArray;
		self.loadingStatus = GHResourceStatusNotLoaded;
		
	} else {
		
		self.results = [[NSMutableArray alloc] initWithCapacity:dictArray.count];
		for (NSDictionary *dict in dictArray){ 
			GHSite *site = [[GHSite alloc] initWithDictionary:[dict objectForKey:@"byc_site"]];
			[self.results addObject:site];
			[site release];
		}
		
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		self.loadingStatus = GHResourceStatusLoaded;
		[pool release];
	}
	
}

@end
