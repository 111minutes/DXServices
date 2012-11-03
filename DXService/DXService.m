//
//  DXService.m
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXService.h"
#import "DXServiceIntentObserver.h"

@implementation DXService

+ (instancetype)shared
{
    return [[self class] new];
}

- (id<DXServiceProvider>)serviceProviderForIntentClass:(Class)IntentClass
{
    return nil;
}

- (id)buildEmitterForIntentClass:(Class)IntentClass constructor:(id(^)(id intent))constructor
{
    id intent = [[IntentClass alloc] initWithServiceProvider:[self serviceProviderForIntentClass:IntentClass]];
    
    if (constructor) {
        constructor(intent); 
    }
    
    return [DXServiceIntentObserver observerWithIntent:intent];
}

@end
