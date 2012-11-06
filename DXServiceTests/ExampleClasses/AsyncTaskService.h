//
// Created by zen on 11/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DXService.h"

@class DXServiceIntentProxy;


@interface AsyncTaskService : DXService

- (DXServiceIntentProxy *)createAsyncTaskWithBlock:(id(^)())block;

@end