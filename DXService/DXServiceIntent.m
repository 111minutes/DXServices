//
//  DXServiceIntent.m
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntent.h"
#import "DXServiceIntentProxy.h"

const struct DXServiceIntentConstants DXServiceIntentConstants = {
        .beginEvent = @"DXServiceIntentBeginEvent",
        .finishEvent = @"DXServiceIntentFinishEvent",
        .commitResultsEvent = @"DXServiceIntentCommitResultsEvent",
        .finishWithErrorEvent = @"DXServiceIntentFinishWithErrorEvent"
};

@interface DXServiceIntent ()

@property(nonatomic, weak) id <DXServiceProvider> serviceProvider;
@property(nonatomic, strong) NSMutableArray *observers;

@end

@implementation DXServiceIntent

- (id)initWithServiceProvider:(id <DXServiceProvider>)provider
{
    self = [super init];
    if (self) {
        self.serviceProvider = provider;
        self.observers = [NSMutableArray new];
    }
    return self;
}

- (void)perform
{
    [self.serviceProvider performIntent:self];
}

- (void)cancel
{
    [self.serviceProvider cancelIntent:self];
}

- (void)finish
{
    [self emitEventWithName:DXServiceIntentConstants.finishEvent value:nil];
}

- (void)finishWithResult:(id)result
{
    [self emitEventWithName:DXServiceIntentConstants.finishEvent value:result];
}

- (void)finishWithError:(NSError*)error
{
    [self emitEventWithName:DXServiceIntentConstants.finishWithErrorEvent value:error];
}

- (void)commitResults:(id)results
{
    [self emitEventWithName:DXServiceIntentConstants.commitResultsEvent value:results];
}

- (void)addProxy:(DXServiceIntentProxy *)emitter
{
    [self.observers addObject:emitter];
}

- (void)removeProxy:(DXServiceIntentProxy *)emitter
{
    [self.observers removeObject:emitter];
    if (self.observers.count == 0) {
        [self cancel];
    }
}

- (NSArray *)allProxies
{
    return [self.observers copy];
}

- (void)emitEventWithName:(NSString *)eventName value:(id)eventValue
{
    [self.observers enumerateObjectsUsingBlock:^(DXServiceIntentProxy *emitter, NSUInteger idx, BOOL *stop) {
        [emitter absorbEventWithName:eventName value:eventValue];
    }];
}

@end
