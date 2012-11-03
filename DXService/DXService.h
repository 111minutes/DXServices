//
//  DXService.h
//  DXService
//
//  Created by zen on 10/28/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXService : NSObject

+ (instancetype)shared;

- (id)buildEmitterForIntentClass:(Class)IntentClass constructor:(id(^)(id intent))constructor;

@end
