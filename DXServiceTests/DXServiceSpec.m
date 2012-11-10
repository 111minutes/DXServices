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
#import "DXServiceIntentProviderMapping.h"


SPEC_BEGIN(DXServiceSpec)

    describe(@"Provider cache", ^{
        it(@"Should cache service provider for intent class", ^{
            DXService *service = [DXService new];
            
            [[DXServiceIntentProviderMapping shared] addMappingFromIntentClass:[NSString class] toProviderClass:[NSArray class]];

            id serviceProvider = [service buildServiceProviderForIntentClass:[NSString class]];
            
            [[(id)[service buildServiceProviderForIntentClass:[NSString class]] should] equal:serviceProvider];
        });
    });

SPEC_END


