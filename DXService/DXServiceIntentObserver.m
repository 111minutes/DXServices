//
//  DXServiceIntentEmitter.m
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntentObserver.h"
#import "DXServiceIntent.h"

@interface DXServiceIntentObserver ()

@property (nonatomic, weak) DXServiceIntent *intent;

@end

@implementation DXServiceIntentObserver

+ (DXServiceIntentObserver*)observerWithIntent:(DXServiceIntent*)intent
{
    return [[self alloc] initWithIntent:intent];
}

- (id)initWithIntent:(DXServiceIntent*)anIntent
{
    self = [super init];
    if (self) {
        self.intent = anIntent;
    }
    return self;
}

- (void)perform
{
    [self.intent perform];
}

- (void)absorbEventWithName:(NSString*)eventName value:(id)eventValue
{
    
}

@end
