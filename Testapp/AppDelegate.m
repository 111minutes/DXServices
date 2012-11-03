//
//  AppDelegate.m
//  Testapp
//
//  Created by zen on 10/30/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [RootViewController new];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
