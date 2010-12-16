//
//  GHSite.h
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GHSite : NSObject {
	NSDictionary *dict;
}

@property(nonatomic,retain)NSDictionary *dict;

@property(nonatomic)NSInteger *number;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *position_name;

+ (id)initWithDictionary:(NSDictionary *)dict;
- (BOOL)haveLocation;

- (id)valueInDict:(NSString *)key;
@end
