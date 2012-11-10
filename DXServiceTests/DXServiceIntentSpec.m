//
//  DXServiceIntent.m
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntent.h"
#import "DXServiceIntentProxy.h"
#import "Kiwi.h"

SPEC_BEGIN(DXServiceIntentSpec)

        describe(@"Performing", ^{
            it(@"should perform on provider which was sended to init", ^{
                id provider = [KWMock mockForProtocol:@protocol(DXServiceProvider)];

                DXServiceIntent *intent = [[DXServiceIntent alloc] initWithServiceProvider:provider];

                [[[provider should] receive] performIntent:intent];

                [intent perform];
            });

            it(@"Should cancel intent", ^{
                id provider = [KWMock mockForProtocol:@protocol(DXServiceProvider)];

                DXServiceIntent *intent = [[DXServiceIntent alloc] initWithServiceProvider:provider];

                [[[provider should] receive] cancelIntent:intent];

                [intent cancel];
            });
        });

        describe(@"Notifications", ^{
            __block DXServiceIntent *_intent;
            __block DXServiceIntentProxy *_proxy;

            beforeEach(^{
                _intent = [[DXServiceIntent alloc] initWithServiceProvider:nil];
                _proxy = [DXServiceIntentProxy mock];
            });

            describe(@"Proxy managing", ^{
                it(@"should have no proxy after creating", ^{
                    [[_intent.allProxies should] beEmpty];
                });

                it(@"should add new observer to emitters list", ^{
                    [_intent addProxy:_proxy];

                    [[_intent.allProxies should] contain:_proxy];
                });

                it(@"should remove observer from emitters list", ^{

                    [_intent addProxy:_proxy];
                    [_intent removeProxy:_proxy];

                    [[_intent.allProxies shouldNot] contain:_proxy];
                });

                it(@"should cancel self if no more observers left", ^{
                    [_intent addProxy:_proxy];

                    [[[_intent should] receive] cancel];

                    [_intent removeProxy:_proxy];
                });
            });

            describe(@"Sending", ^{
                it(@"Should send notifications to observers", ^{
                    [_intent addProxy:_proxy];

                    NSString *eventName = @"EventName";
                    NSString *eventValue = @"EventValue";

                    [[[_proxy should] receive] absorbEventWithName:eventName value:eventValue];

                    [_intent emitEventWithName:eventName value:eventValue];
                });

                it(@"should sends event for multiple observers", ^{
                    [_intent addProxy:_proxy];

                    DXServiceIntentProxy *observer2 = [DXServiceIntentProxy mock];

                    [_intent addProxy:observer2];

                    NSString *eventName = @"EventName";
                    NSString *eventValue = @"EventValue";

                    [[[_proxy should] receive] absorbEventWithName:eventName value:eventValue];
                    [[[observer2 should] receive] absorbEventWithName:eventName value:eventValue];

                    [_intent emitEventWithName:eventName value:eventValue];
                });

                it(@"Should send DXServiceIntentConstants.finishEvent notification for finish method call", ^{
                    [[[_proxy should] receive] absorbEventWithName:DXServiceIntentConstants.finishEvent value:nil];

                    [_intent addProxy:_proxy];

                    [_intent finish];
                });

                it(@"Should send DXServiceIntentConstants.finishEvent notification with results for finishWithResults method call", ^{
                    NSString *results = @"results";

                    [[[_proxy should] receive] absorbEventWithName:DXServiceIntentConstants.finishEvent value:results];
                    [_intent addProxy:_proxy];

                    [_intent finishWithResult:results];
                });
                
                it(@"Should send DXServiceIntentConstants.finishWithErrorEvent notification with results for finishWithError method call", ^{
                    NSString *results = @"results";
                    
                    [[[_proxy should] receive] absorbEventWithName:DXServiceIntentConstants.finishWithErrorEvent value:results];
                    [_intent addProxy:_proxy];
                    
                    [_intent finishWithError:(NSError*)results];
                });

                it(@"Should send DXServiceIntentConstants.commitResultsEvent with results notification for commitWithResults: method call", ^{
                    NSString *results = @"results";

                    [[[_proxy should] receive] absorbEventWithName:DXServiceIntentConstants.commitResultsEvent value:results];

                    [_intent addProxy:_proxy];

                    [_intent commitResults:results];
                });
            });
        });

        SPEC_END


