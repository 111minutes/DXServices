//
//  DXServiceIntentProxySpec.m
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import "Kiwi.h"
#import "DXServiceIntentProxy.h"

SPEC_BEGIN(DXServiceIntentProxySpec)

        describe(@"Performing", ^{
            it(@"Should make intent perform", ^{
                id intent = [DXServiceIntent nullMock];

                DXServiceIntentProxy *proxy = [DXServiceIntentProxy proxyWithIntent:intent];

                [[[intent should] receive] perform];

                [proxy perform];
            });

            it(@"Should allow to cancel intent", ^{
                id intent = [DXServiceIntent nullMock];

                DXServiceIntentProxy *proxy = [DXServiceIntentProxy proxyWithIntent:intent];

                [[[intent should] receive] cancel];

                [proxy cancel];
            });
        });

        describe(@"Subscribing to intent", ^{
            it(@"Should subscribe to intent at creation", ^{
                id intent = [DXServiceIntent mock];
                
                [[[intent should] receive] addProxy:[KWAny any]];
                
                [DXServiceIntentProxy proxyWithIntent:intent];
            });
        });

        describe(@"Notifications", ^{
            __block DXServiceIntentProxy *_proxy;
            beforeEach(^{
                id intent = [DXServiceIntent nullMock];
                _proxy = [DXServiceIntentProxy proxyWithIntent:intent];
            });
            
            it(@"Should notify all listeners about event", ^{
                __block NSString *receivedData1;
                __block NSString *receivedData2;
                NSString *testData = @"test";

                [_proxy on:@"EventName" notify:^(id data){
                    receivedData1 = data;
                }];

                [_proxy on:@"EventName" notify:^(id data){
                    receivedData2 = data;
                }];

                [_proxy absorbEventWithName:@"EventName" value:testData];

                [[receivedData1 should] equal:testData];
                [[receivedData2 should] equal:testData];
            });

            it(@"Should have shortcut for success finish event", ^{
                __block NSString *receivedData;
                NSString *testData = @"test";
                [_proxy onSuccess:^(id data){
                    receivedData = data;
                }];

                [_proxy absorbEventWithName:DXServiceIntentConstants.finishEvent value:testData];

                [[receivedData should] equal:testData];
            });

            it(@"Should have shortcut for finish with error event", ^{
                __block NSString *receivedData;
                NSString *testData = @"test";

                [_proxy onError:^(id data){
                    receivedData = data;
                }];

                [_proxy absorbEventWithName:DXServiceIntentConstants.finishWithErrorEvent value:testData];

                [[receivedData should] equal:testData];
            });

            it(@"Should have shortcut for commit result event", ^{
                __block NSString *receivedData;
                NSString *testData = @"test";

                [_proxy onCommitResult:^(id data){
                    receivedData = data;
                }];

                [_proxy absorbEventWithName:DXServiceIntentConstants.commitResultsEvent value:testData];

                [[receivedData should] equal:testData];
            });
        });

        SPEC_END


