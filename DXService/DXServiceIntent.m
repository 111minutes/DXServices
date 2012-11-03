//
//  DXServiceIntent.m
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntent.h"
#import "DXServiceIntentObserver.h"

const struct DXServiceIntentConstants DXServiceIntentConstants = {
    .beginEvent = @"DXServiceIntentBeginEvent",
    .finishEvent = @"DXServiceIntentFinishEvent",
    .commitResultsEvent = @"DXServiceIntentCommitResultsEvent"
};

@interface DXServiceIntent ()

@property (nonatomic, weak) id<DXServiceProvider> serviceProvider;
@property (nonatomic, strong) NSMutableArray *observers;

@end

@implementation DXServiceIntent

- (id)initWithServiceProvider:(id<DXServiceProvider>)provider
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
    
}

- (void)begin
{
    [self emitEventWithName:DXServiceIntentConstants.beginEvent value:nil];
}

- (void)finish
{
    [self emitEventWithName:DXServiceIntentConstants.finishEvent value:nil];
}

- (void)finishWithResult:(id)result
{
    [self emitEventWithName:DXServiceIntentConstants.finishEvent value:result];
}

- (void)commitResults:(id)results
{
    [self emitEventWithName:DXServiceIntentConstants.commitResultsEvent value:results];
}

- (void)addObserver:(DXServiceIntentObserver*)emitter
{
    [self.observers addObject:emitter];
}

- (void)removeObserver:(DXServiceIntentObserver*)emitter
{
    [self.observers removeObject:emitter];
    if (self.observers.count == 0) {
        [self cancel];
    }
}

- (NSArray*)allObservers
{
    return [self.observers copy];
}

- (void)emitEventWithName:(NSString*)eventName value:(id)eventValue
{
    [self.observers enumerateObjectsUsingBlock:^(DXServiceIntentObserver *emitter, NSUInteger idx, BOOL *stop) {
        [emitter absorbEventWithName:eventName value:eventValue];
    }];
}

@end
