//
//  DXServiceIntentProviderMapping.m
//  DXService
//
//  Created by zen on 11/10/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXServiceIntentProviderMapping.h"

@interface DXServiceIntentProviderMapping ()

@property (nonatomic, strong) NSMutableDictionary *mapping;

@end

@implementation DXServiceIntentProviderMapping

- (id)init
{
    self = [super init];
    if (self) {
        self.mapping = [NSMutableDictionary new];
    }
    return self;
}

- (void)addMappingFromIntentClass:(Class)intentClass toProviderClass:(Class)providerClass
{
    [self.mapping setObject:providerClass forKey:NSStringFromClass(intentClass)];
}

- (Class)serviceProviderClassForIntentClass:(Class)intentClass
{
    return [self.mapping objectForKey:NSStringFromClass(intentClass)];
}

- (void)clearMapping
{
    [self.mapping removeAllObjects];
}

@end
