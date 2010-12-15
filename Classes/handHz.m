//
//  handHz.m
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "handHz.h"


@implementation handHz
+ (ASINetworkQueue *)queue {
	static ASINetworkQueue *queue;
	if (queue == nil) {
		queue = [[ASINetworkQueue queue] retain];
		[queue go];
	}
	return queue;
}
@end
