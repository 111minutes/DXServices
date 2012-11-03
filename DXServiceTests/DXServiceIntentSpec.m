//
//  DXServiceIntent.m
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXServiceIntent.h"
#import "DXServiceIntentObserver.h"

SPEC_BEGIN(DXServiceIntentSpec)

describe(@"Performing", ^{
    it(@"should perform on provider which was sended to init", ^{
        id provider = [KWMock mockForProtocol:@protocol(DXServiceProvider)];
        
        DXServiceIntent *intent = [[DXServiceIntent alloc] initWithServiceProvider:provider];
        
        [[[provider should] receive] performIntent:intent];
        
        [intent perform];
    });
});

describe(@"Notifications", ^{
    __block DXServiceIntent *_intent;
    __block DXServiceIntentObserver *_observer;
    
    beforeEach(^{
        _intent = [[DXServiceIntent alloc] initWithServiceProvider:nil];
        _observer = [DXServiceIntentObserver mock];
    });
    
    describe(@"Observers managing", ^{
        it(@"should have no observer after creating", ^{
            [[_intent.allObservers should] beEmpty];
        });
        
        it(@"should add new observer to emitters list", ^{
            [_intent addObserver:_observer];
            
            [[_intent.allObservers should] contain:_observer];
        });
        
        it(@"should remove observer from emitters list", ^{
            
            [_intent addObserver:_observer];
            [_intent removeObserver:_observer];
            
            [[_intent.allObservers shouldNot] contain:_observer];
        });
        
        it(@"should cancel self if no more observers left", ^{
            [_intent addObserver:_observer];
            
            [[[_intent should] receive] cancel];
            
            [_intent removeObserver:_observer];
        });
    });
    
    describe(@"Sending", ^{
        it(@"Should send notifications to observers", ^{
            [_intent addObserver:_observer];
            
            NSString *eventName = @"EventName";
            NSString *eventValue = @"EventValue";
            
            [[[_observer should] receive] absorbEventWithName:eventName value:eventValue];
            
            [_intent emitEventWithName:eventName value:eventValue];
        });
        
        it(@"should sends event for multiple observers", ^{
            [_intent addObserver:_observer];
            
            DXServiceIntentObserver *observer2 = [DXServiceIntentObserver mock];
            
            [_intent addObserver:observer2];
            
            NSString *eventName = @"EventName";
            NSString *eventValue = @"EventValue";
            
            [[[_observer should] receive] absorbEventWithName:eventName value:eventValue];
            [[[observer2 should] receive] absorbEventWithName:eventName value:eventValue];
            
            [_intent emitEventWithName:eventName value:eventValue];
        });
        
        it(@"Should send DXServiceIntentConstants.beginEvent notification for begin method call", ^{
            [[[_observer should] receive] absorbEventWithName:DXServiceIntentConstants.beginEvent value:nil];
            
            [_intent addObserver:_observer];
            
            [_intent begin];
        });
        
        it(@"Should send DXServiceIntentConstants.finishEvent notification for finish method call", ^{
            [[[_observer should] receive] absorbEventWithName:DXServiceIntentConstants.finishEvent value:nil];
            
            [_intent addObserver:_observer];
            
            [_intent finish];
        });
        
        it(@"Should send DXServiceIntentConstants.finishEvent notification for finish method call", ^{
            NSString *results = @"results";
            
            [[[_observer should] receive] absorbEventWithName:DXServiceIntentConstants.finishEvent value:results];
            [_intent addObserver:_observer];
            
            [_intent finishWithResult:results];
        });
        
        it(@"Should send DXServiceIntentConstants.commitResultsEvent with results notification for commitWithResults: method call", ^{
            NSString *results = @"results";
            
            [[[_observer should] receive] absorbEventWithName:DXServiceIntentConstants.commitResultsEvent value:results];
            
            [_intent addObserver:_observer];
            
            [_intent commitResults:results];
        });
    });
});

SPEC_END


