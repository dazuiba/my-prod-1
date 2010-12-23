//
//  GHPlotCount.m
//  handhz
//
//  Created by sam on 10-12-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GHPlotCount.h"


@implementation GHPlotCount

@synthesize empty_count, used_count, created_at;

- (id)initWithDictionary:(NSDictionary *)theDict{
	[super init];
	
	self.created_at = [theDict valueForKey:@"created_at"];
	self.empty_count = [[theDict valueForKey:@"empty_count"] intValue];
	self.used_count = [[theDict valueForKey:@"used_count"] intValue];
	return self;
}


- (float)percent{
	return ((float)self.used_count)/((float)(self.empty_count+self.used_count));
}


@end