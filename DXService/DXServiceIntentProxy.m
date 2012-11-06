//
//  DXServiceIntentEmitter.m
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntentProxy.h"

@interface DXServiceIntentProxy ()

@property(nonatomic, strong) DXServiceIntent *intent;
@property(nonatomic, strong) NSMutableDictionary *listeners;

@end

@implementation DXServiceIntentProxy

+ (DXServiceIntentProxy *)proxyWithIntent:(DXServiceIntent *)intent
{
    return [[self alloc] initWithIntent:intent];
}

- (id)initWithIntent:(DXServiceIntent *)anIntent
{
    NSParameterAssert(anIntent);
    
    self = [super init];
    if (self) {
        self.intent = anIntent;
        [self.intent addProxy:self];

        self.listeners = [NSMutableDictionary new];
    }
    return self;
}

- (void)perform
{
    [self.intent perform];
}

- (void)cancel
{
    [self.intent cancel];
    self.intent = nil;
}

- (void)absorbEventWithName:(NSString *)eventName value:(id)eventValue
{
    NSParameterAssert(eventName);

    NSMutableArray *listenersForEvent = self.listeners[eventName];
    [listenersForEvent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        void(^block)(id) = obj;
        block(eventValue);
    }];
}

- (void)on:(NSString *)eventName notify:(void (^)(id))listener
{
    NSParameterAssert(listener);
    NSParameterAssert(eventName);
    
    NSMutableArray *listenersForEvent = self.listeners[eventName];
    if (!listenersForEvent) {
        listenersForEvent = [NSMutableArray new];
        self.listeners[eventName] = listenersForEvent;
    }

    [listenersForEvent addObject:[listener copy]];
}

- (void)onSuccess:(void (^)(id))callback
{
    [self on:DXServiceIntentConstants.finishEvent notify:callback];
}

- (void)onError:(void (^)(id))callback
{
    [self on:DXServiceIntentConstants.finishWithErrorEvent notify:callback];
}

- (void)onCommitResult:(void (^)(id))callback
{
    [self on:DXServiceIntentConstants.commitResultsEvent notify:callback];
}
@end
