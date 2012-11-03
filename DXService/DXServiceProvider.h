//
//  DXServiceProvider.h
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DXServiceIntent;

@protocol DXServiceProvider <NSObject>

- (void)performIntent:(DXServiceIntent*)intent;

@end
