//
//  DXService.m
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXService.h"
#import "DXServiceIntentProxy.h"
#import "DXServiceIntentProviderMapping.h"

@interface DXService ()

@property (nonatomic, strong) NSMutableDictionary *providersCache;

@end

@implementation DXService

- (id)init
{
    self = [super init];
    if (self) {
        self.providersCache = [NSMutableDictionary new];
    }
    return self;
}

- (id <DXServiceProvider>)buildServiceProviderForIntentClass:(Class)IntentClass
{
    id<DXServiceProvider> provider = self.providersCache[NSStringFromClass(IntentClass)];
    if (!provider) {
        Class providerClass = [[DXServiceIntentProviderMapping shared] serviceProviderClassForIntentClass:IntentClass];
        
        NSParameterAssert(providerClass);
        
        provider = [providerClass new];
        
        NSParameterAssert(provider);
        
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
