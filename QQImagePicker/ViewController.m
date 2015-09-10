//
//  ViewController.m
//  QQImagePicker
//
//  Created by mark on 15/9/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MMenuView *mm = [[MMenuView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 350, CGRectGetWidth(self.view.bounds), 350)];
    [self.view addSubview:mm];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
