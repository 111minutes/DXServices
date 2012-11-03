//
//  DXServiceIntentEmitter.h
//  DXService
//
//  Created by zen on 10/29/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXServiceIntent.h"

@interface DXServiceIntentObserver : NSObject

+ (DXServiceIntentObserver*)observerWithIntent:(DXServiceIntent*)intent;
- (id)initWithIntent:(DXServiceIntent*)intent;
- (void)perform;
- (void)absorbEventWithName:(NSString*)eventName value:(id)eventValue;

@end
