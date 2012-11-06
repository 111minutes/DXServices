//
//  DXService.m
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXService.h"
#import "DXServiceIntentProxy.h"

@interface DXService ()

@property (nonatomic, strong) NSMutableDictionary *providersCache;

@end

@implementation DXService

+ (instancetype)shared
{
    return [[self class] new];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.providersCache = [NSMutableDictionary new];
    }
    return self;
}

- (id <DXServiceProvider>)serviceProviderForIntentClass:(Class)IntentClass
{
    return nil;
}

- (id <DXServiceProvider>)buildServiceProviderForIntentClass:(Class)IntentClass
{
    id<DXServiceProvider> provider = self.providersCache[NSStringFromClass(IntentClass)];
    if (!provider) {
        provider = [self serviceProviderForIntentClass:IntentClass];
        assert(provider);
        self.providersCache[NSStringFromClass(IntentClass)] = provider;
    }
    return provider;
}

- (id) buildProxyForIntentClass:(Class)IntentClass constructor:(void(^)(id intent))constructor
{
    id intent = [[IntentClass alloc] initWithServiceProvider:[self buildServiceProviderForIntentClass:IntentClass]];

    if (constructor) {
        constructor(intent);
    }

    return [DXServiceIntentProxy proxyWithIntent:intent];
}

@end
