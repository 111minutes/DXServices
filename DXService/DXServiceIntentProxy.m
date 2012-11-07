//
//  DXServiceIntentEmitter.m
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntentProxy.h"
#import "DXServiceIntentProxyCallbackContext.h"

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
    [listenersForEvent enumerateObjectsUsingBlock:^(DXServiceIntentProxyCallbackContext *context, NSUInteger idx, BOOL *stop) {
        [context invokeWithResult:eventValue];
    }];
}

- (void)on:(NSString *)eventName notify:(void (^)(id))listener
{
    [self on:eventName notify:listener onQueue:nil];
}

- (void)on:(NSString *)eventName notify:(void (^)(id))listener onQueue:(dispatch_queue_t)anQueue
{
    NSParameterAssert(listener);
    NSParameterAssert(eventName);

    NSMutableArray *listenersForEvent = self.listeners[eventName];
    if (!listenersForEvent) {
        listenersForEvent = [NSMutableArray new];
        self.listeners[eventName] = listenersForEvent;
    }

    [listenersForEvent addObject:[DXServiceIntentProxyCallbackContext contextWithCallback:listener onQueue:anQueue]];
}

- (void)onSuccess:(DXServiceIntentProxyCallBack)callback
{
    [self on:DXServiceIntentConstants.finishEvent notify:callback];
}

- (void)onError:(DXServiceIntentProxyCallBack)callback
{
    [self on:DXServiceIntentConstants.finishWithErrorEvent notify:callback];
}

- (void)onCommitResult:(DXServiceIntentProxyCallBack)callback
{
    [self on:DXServiceIntentConstants.commitResultsEvent notify:callback];
}
@end
