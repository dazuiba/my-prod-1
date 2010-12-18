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
	return (NSInteger *)[self valueInDict:@"uid"];
}


- (NSString *)name {
	return [self valueInDict:@"name"];
}

- (NSString *)position_name {
	return [self valueInDict:@"position_name"];
}

- (CLLocationCoordinate2D)coordinate;{
	CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = self.lat;
	theCoordinate.longitude = self.lng;
	return theCoordinate; 
}


- (double)uid{
	return [(NSDecimalNumber *)[self valueInDict:@"lat"] doubleValue];
}

- (double)lat{
	return [(NSDecimalNumber *)[self valueInDict:@"lat"] doubleValue];
}

- (double)lng{
	return [(NSDecimalNumber *)[self valueInDict:@"lng"] doubleValue];
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title{
	return self.name;
}

// optional
- (NSString *)subtitle{
	return self.position_name;
}


	 
- (id)valueInDict:(NSString *)key {
	return [self.dict valueForKey:key];
}

- (BOOL)isEqual:(id)other {
	if (other == self)
		return YES;
	if (!other || ![other isKindOfClass:[self class]])
		return NO;
	
	GHSite *otherSite = (GHSite *)other;
	return (self.number == otherSite.number);
}

- (void)dealloc {
	[dict release];
	[super dealloc];
}

@end
