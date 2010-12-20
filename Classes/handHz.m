//
//  handHz.m
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "handHz.h"
#import "AppConstants.h"
#import <MapKit/MapKit.h>
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
	static CLLocationCoordinate2D MapInitCord; 
	if(!MapInitCord.latitude){
		MapInitCord.latitude =  kMapInitLat;
		MapInitCord.longitude = kMapInitLng;
	}
	return [self region:MapInitCord];
}


+ (BOOL)regionInHz:(CLLocationCoordinate2D) cord{	
	return (cord.latitude <= kMapLatMax)&&(cord.latitude>=kMapLatMin) && (cord.longitude <= kMapLngMax)&&(cord.longitude>=kMapLngMin);
}

+ (MKCoordinateRegion)region:(CLLocationCoordinate2D)cord{
	MKCoordinateRegion newRegion;
	newRegion.center = cord;
	newRegion.span.latitudeDelta = kMapInitSpanDeltaLat;
	newRegion.span.longitudeDelta = kMapInitSpanDeltaLng;
	return newRegion;
}

@end
