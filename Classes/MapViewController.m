//
//  MapViewController.m
//  handhz
//
//  Created by sam on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GHSite.h"


@implementation MapViewController

@synthesize site;

- (id)initWithSite:(GHSite *)theSite {
	[super initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
	self.site = theSite;
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Back";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActions:)];
}

- (void)dealloc {
	[super dealloc];
}

@end
