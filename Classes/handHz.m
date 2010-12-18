//
//  handHz.m
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "handHz.h"
#import "AppConstants.h"

@implementation handHz
+ (ASINetworkQueue *)queue {
	static ASINetworkQueue *queue;
	if (queue == nil) {
		queue = [[ASINetworkQueue queue] retain];
		[queue go];
	}
	return queue;
}

+ (MKCoordinateRegion)region{
	return [self region:kMapInitLat withLng:kMapInitLng];
}

+ (MKCoordinateRegion)region:(double)lat withLng:(double)lng{
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = lat;
	newRegion.center.longitude = lng;
	newRegion.span.latitudeDelta = kMapInitSpanDeltaLat;
	newRegion.span.longitudeDelta = kMapInitSpanDeltaLng;
	return newRegion;
}

@end
