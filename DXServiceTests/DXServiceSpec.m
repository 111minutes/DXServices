//
//  DXService.m
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright 2012 111Minutes. All rights reserved.
//


#import "Kiwi.h"
#import "DXService.h"
#import "DXServiceProvider.h"
#import "DXServiceIntent.h"
#import "DXServiceProvider.h"


SPEC_BEGIN(DXServiceSpec)

    describe(@"Provider cache", ^{
        it(@"Should cache service provider for intent class", ^{
            DXService *service = [DXService new];

            NSString *providerMock = @"providerMock";

            [[service stubAndReturn:providerMock] serviceProviderForIntentClass:[NSString class]];

            [[(id)[service buildServiceProviderForIntentClass:[NSString class]] should] equal:providerMock];

            [[(id)[service buildServiceProviderForIntentClass:[NSString class]] should] equal:providerMock];
        });
    });

SPEC_END


