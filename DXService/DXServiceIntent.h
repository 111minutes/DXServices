//
//  DXServiceIntent.h
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXServiceProvider.h"

@class DXServiceIntentProxy;

extern const struct DXServiceIntentConstants
{
    __unsafe_unretained NSString *beginEvent;
    __unsafe_unretained NSString *finishEvent;
    __unsafe_unretained NSString *commitResultsEvent;
    __unsafe_unretained NSString *finishWithErrorEvent;
} DXServiceIntentConstants;

@interface DXServiceIntent : NSObject

- (id)initWithServiceProvider:(id <DXServiceProvider>)provider;

- (void)perform;

- (void)cancel;

- (void)commitResults:(id)results;

- (void)finishWithResult:(id)result;

- (void)finish;

- (void)addProxy:(DXServiceIntentProxy *)emitter;

- (void)removeProxy:(DXServiceIntentProxy *)emitter;

- (NSArray *)allProxies;

- (void)emitEventWithName:(NSString *)eventName value:(id)eventValue;

@end
