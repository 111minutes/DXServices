//
//  AsyncServiceSpec.m
//  DXService
//
//  Created by zen on 11/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AsyncTaskService.h"
#import "DXServiceIntentProxy.h"
#import "Kiwi.h"


SPEC_BEGIN(AsyncServiceSpec)
    describe(@"Execution", ^{
        it(@"Should execute and return value of block", ^{
            AsyncTaskService *service = [AsyncTaskService new];

            NSString *input = @"input";

            DXServiceIntentProxy *proxy = [service createAsyncTaskWithBlock:^{return input;}];
            
            __block NSString *result;

            [proxy onSuccess:^(id data) {
                result = data;
            }];

            [proxy perform];

            [[expectFutureValue(result) shouldEventually] equal:input];

        });
    });

SPEC_END


