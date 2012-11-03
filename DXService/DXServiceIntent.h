//
//  DXServiceIntent.h
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXServiceProvider.h"

@class DXServiceIntentObserver;

extern const struct DXServiceIntentConstants
{
    __unsafe_unretained NSString *beginEvent;
    __unsafe_unretained NSString *finishEvent;
    __unsafe_unretained NSString *commitResultsEvent;

} DXServiceIntentConstants;

@interface DXServiceIntent : NSObject

- (id)initWithServiceProvider:(id<DXServiceProvider>)provider;
- (void)perform;
- (void)cancel;

- (void)begin;
- (void)commitResults:(id)results;
- (void)finishWithResult:(id)result;
- (void)finish;

- (void)addObserver:(DXServiceIntentObserver*)emitter;
- (void)removeObserver:(DXServiceIntentObserver*)emitter;
- (NSArray*)allObservers;

- (void)emitEventWithName:(NSString*)eventName value:(id)eventValue;

@end
