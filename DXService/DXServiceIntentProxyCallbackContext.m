//
// Created by zen on 11/7/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXServiceIntentProxyCallbackContext.h"


@interface DXServiceIntentProxyCallbackContext ()

@property (nonatomic, copy) DXServiceIntentProxyCallBack callback;
@property (nonatomic, assign) dispatch_queue_t callbackQueue;

@end

@implementation DXServiceIntentProxyCallbackContext
{

}

+ (DXServiceIntentProxyCallbackContext*)contextWithCallback:(DXServiceIntentProxyCallBack)callback onQueue:(dispatch_queue_t)anQueue;
{
    return [[[self class] alloc] initWithCallback:callback onQueue:anQueue];
}

- (id)initWithCallback:(DXServiceIntentProxyCallBack)callback onQueue:(dispatch_queue_t)anQueue;
{
    NSParameterAssert(callback);

    self = [super init];
    if (self) {
        self.callback = callback;
        self.callbackQueue = anQueue;
    }
    return self;
}

- (void)invokeWithResult:(id)result
{
    if (self.callback) {
        if (self.callbackQueue) {
            dispatch_async(self.callbackQueue, ^{
                self.callback(result);
            });
        } else {
            self.callback(result);
        }
    }
}
@end