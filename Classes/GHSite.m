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
	NSLog(@"#number: %@", [[self valueInDict:@"uid"] class]);
	
	NSLog(@"#position_name: %@", [self valueInDict:@"position_name"]);
	return [self valueInDict:@"uid"];
}


- (NSString *)name {
	return [self valueInDict:@"name"];
}

- (NSString *)position_name {
	return [self valueInDict:@"position_name"];
}

	 
- (id)valueInDict:(NSString *)key {
	return [self.dict valueForKey:key];
}

- (void)dealloc {
	[dict release];
	[super dealloc];
}

@end
