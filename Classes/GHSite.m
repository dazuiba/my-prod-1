//
//  GHSite.m
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GHSite.h"
//@interface GHSite() 
//
//@end

@implementation GHSite

@synthesize dict, name, position_name, number;


- (id)initWithDictionary:(NSDictionary *)theDict{
	[super init];
	[theDict retain];
	self.dict = theDict;
	return self;
}

- (BOOL) haveLocation{
	return [self valueInDict:@"lng"] > 0;
}


- (NSInteger *)number { 
	NSLog(@"ss:%@",[[self valueInDict:@"lat"] class]);
	return (NSInteger *)[self valueInDict:@"uid"];
}


- (NSString *)name {
	return [self valueInDict:@"name"];
}

- (NSString *)position_name {
	return [self valueInDict:@"position_name"];
}

- (CLLocationCoordinate2D)coordinate;
{
	CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = [(NSDecimalNumber *)[self valueInDict:@"lat"] doubleValue];
	theCoordinate.longitude =[(NSDecimalNumber *)[self valueInDict:@"lng"] doubleValue];
	return theCoordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
	return self.name;
}

// optional
- (NSString *)subtitle
{
	return self.position_name;
}


	 
- (id)valueInDict:(NSString *)key {
	return [self.dict valueForKey:key];
}

- (void)dealloc {
	[dict release];
	[super dealloc];
}

@end
