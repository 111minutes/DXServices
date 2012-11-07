//
//  DXServiceIntentEmitter.h
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXServiceIntent.h"

typedef void (^DXServiceIntentProxyCallBack)(id data);

@interface DXServiceIntentProxy : NSObject

+ (DXServiceIntentProxy *)proxyWithIntent:(DXServiceIntent *)intent;

- (id)initWithIntent:(DXServiceIntent *)intent;

- (void)perform;
- (void)cancel;

- (void)absorbEventWithName:(NSString *)eventName value:(id)eventValue;

- (void)on:(NSString *)eventName notify:(DXServiceIntentProxyCallBack)listener;
- (void)on:(NSString *)eventName notify:(void (^)(id))listener onQueue:(dispatch_queue_t)anQueue;

- (void)onSuccess:(DXServiceIntentProxyCallBack)callback;

- (void)onError:(DXServiceIntentProxyCallBack)callback;

- (void)onCommitResult:(DXServiceIntentProxyCallBack)callback;

@end
