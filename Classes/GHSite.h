//
//  GHSite.h
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GHSite : NSObject <MKAnnotation> {
	NSDictionary *dict;
}

@property(nonatomic,retain)NSDictionary *dict;

@property(nonatomic)NSInteger *number;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *position_name;
@property(nonatomic,readonly)double lat;
@property(nonatomic,readonly)double lng;

+ (id)initWithDictionary:(NSDictionary *)dict;
- (BOOL)haveLocation;

- (id)valueInDict:(NSString *)key;
@end
