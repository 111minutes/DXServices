//
// Created by zen on 11/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DXServiceProvider.h"
#import "AsyncTaskServiceProvider.h"
#import "DXServiceIntent.h"
#import "AsyncTaskIntent.h"
#import "DXServiceIntentProviderMapping.h"

@interface AsyncTaskServiceProvider ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation AsyncTaskServiceProvider
{

}

+ (void)load
{
    [[DXServiceIntentProviderMapping shared] addMappingFromIntentClass:[AsyncTaskIntent class] toProviderClass:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.queue = [NSOperationQueue new];
    }
    return self;
}

- (void)performIntent:(AsyncTaskIntent *)intent
{
    [self.queue addOperationWithBlock:^{
        [intent finishWithResult:intent.block()];
    }];
}

- (void)cancelIntent:(DXServiceIntent *)intent
{

}


@end