//
//  DXServiceIntnetProviderMappingSpec.m
//  DXService
//
//  Created by zen on 11/10/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXServiceIntentProviderMapping.h"

SPEC_BEGIN(DXServiceIntentProviderMappingSpec)

describe(@"Mapping", ^{
    it(@"Should be singleton", ^{
        [[[DXServiceIntentProviderMapping shared] should] equal:[DXServiceIntentProviderMapping shared]];
    });
    
    it(@"Should allow to add new mapping", ^{
        DXServiceIntentProviderMapping *mapping = [DXServiceIntentProviderMapping new];
        
        [mapping addMappingFromIntentClass:[NSString class] toProviderClass:[NSArray class]];
        
        Class providerClass = [mapping serviceProviderClassForIntentClass:[NSString class]];
        
        [[providerClass should] equal:[NSArray class]];
    });
});

SPEC_END


