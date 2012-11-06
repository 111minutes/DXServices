//
//  DXServiceIntentEmitter.h
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXServiceIntent.h"

@interface DXServiceIntentProxy : NSObject

+ (DXServiceIntentProxy *)proxyWithIntent:(DXServiceIntent *)intent;

- (id)initWithIntent:(DXServiceIntent *)intent;

- (void)perform;
- (void)cancel;

- (void)absorbEventWithName:(NSString *)eventName value:(id)eventValue;

- (void)on:(NSString *)eventName notify:(void (^)(id))listener;

- (void)onSuccess:(void (^)(id))callback;

- (void)onError:(void (^)(id))callback;

- (void)onCommitResult:(void (^)(id))callback;

@end
