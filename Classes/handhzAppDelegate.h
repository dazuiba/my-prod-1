//
//  handhzAppDelegate.h
//  handhz
//
//  Created by sam on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SitesViewController.h"
@interface handhzAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	  SitesViewController *viewController;
	  UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SitesViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

-(void)hideMainViewNavigationBar:(BOOL) hidden;

@end

