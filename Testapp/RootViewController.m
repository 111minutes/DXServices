//
//  RootViewController.m
//  DXService
//
//  Created by zen on 10/30/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "RootViewController.h"
#import "PhotoPickerService.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    DXServiceIntentEmitter *emitter = [[PhotoPickerService shared] pickPhoto];
    
    [emitter perform];

}

@end
