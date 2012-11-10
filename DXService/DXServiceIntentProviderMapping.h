//
//  DXServiceIntentProviderMapping.h
//  DXService
//
//  Created by zen on 11/10/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DXFoundation/DXSingleton.h>
#import "DXServiceProvider.h"

@interface DXServiceIntentProviderMapping : NSObject <DXSingleton>

- (void)addMappingFromIntentClass:(Class)intentClass toProviderClass:(Class)providerClass;
- (Class)serviceProviderClassForIntentClass:(Class)intentClass;

@end
