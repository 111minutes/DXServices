//
// Created by zen on 11/7/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXServiceIntentProxy.h"

@interface DXServiceIntentProxyCallbackContext : NSObject

+ (DXServiceIntentProxyCallbackContext*)contextWithCallback:(DXServiceIntentProxyCallBack)callback onQueue:(dispatch_queue_t)anQueue;

- (id)initWithCallback:(DXServiceIntentProxyCallBack)callback onQueue:(dispatch_queue_t)anQueue;
- (void)invokeWithResult:(id)result;

@end