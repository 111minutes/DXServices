//
//  DXService.h
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DXServiceProvider;

@interface DXService : NSObject

+ (instancetype)shared;

- (id <DXServiceProvider>)serviceProviderForIntentClass:(Class)IntentClass;
- (id <DXServiceProvider>)buildServiceProviderForIntentClass:(Class)IntentClass;

- (id)buildProxyForIntentClass:(Class)IntentClass constructor:(void(^)(id intent))constructor;

@end
