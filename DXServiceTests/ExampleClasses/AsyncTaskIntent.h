//
// Created by zen on 11/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXServiceIntent.h"

typedef id(^AsyncTaskBlock)();

@interface AsyncTaskIntent : DXServiceIntent
@property(nonatomic, copy) AsyncTaskBlock block;
@end