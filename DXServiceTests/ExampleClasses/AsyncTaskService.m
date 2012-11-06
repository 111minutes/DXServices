//
// Created by zen on 11/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AsyncTaskService.h"
#import "DXServiceIntentProxy.h"
#import "AsyncTaskIntent.h"
#import "AsyncTaskServiceProvider.h"


@implementation AsyncTaskService
{

}

- (id <DXServiceProvider>)serviceProviderForIntentClass:(Class)IntentClass
{
    return [AsyncTaskServiceProvider new];
}

- (DXServiceIntentProxy *)createAsyncTaskWithBlock:(id(^)())block
{
    return [super buildProxyForIntentClass:[AsyncTaskIntent class] constructor:^(AsyncTaskIntent *intent) {
        intent.block = block;
    }];
}

@end