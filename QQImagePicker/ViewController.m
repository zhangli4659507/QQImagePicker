//
//  ViewController.m
//  QQImagePicker
//
//  Created by mark on 15/9/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MMenuVc.h"
@interface ViewController ()
@property (nonatomic, weak) MMenuVc *menuVc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 40);
    btn.userInteractionEnabled = YES;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"选择图片" forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)actionBtn {

    MMenuVc *mvc = [[MMenuVc alloc] init];
    mvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:mvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
