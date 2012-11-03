//
//  DXServiceIntentEmitterSpec.m
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXServiceIntentObserver.h"

SPEC_BEGIN(DXServiceIntentEmitterSpec)

describe(@"Performing", ^{
    it(@"Should make intent perform", ^{
        id intent = [DXServiceIntent mock];
        
        DXServiceIntentObserver *emitter = [DXServiceIntentObserver observerWithIntent:intent];
        
        [[[intent should] receive] perform];
        
        [emitter perform];
    });
});

SPEC_END


