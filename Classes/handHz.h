//
//  handHz.h
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "ASINetworkQueue.h"
#import <MapKit/MapKit.h>
@interface handHz : NSObject {
	
}
+ (ASINetworkQueue *)queue;
+ (MKCoordinateRegion)region;
+ (MKCoordinateRegion)region:(double)lat withLng:(double)lng;

@end
