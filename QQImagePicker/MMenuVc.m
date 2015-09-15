//
//  MMenuVc.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MMenuVc.h"
#import "MHeadImaView.h"
#import "MImaLibTool.h"
#import "MShowAllGroup.h"
#import "MShowBigImaVc.h"
@interface MMenuVc ()<UITableViewDataSource,UITableViewDelegate,MHeadImaViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitles;
@property (nonatomic, copy) menuSelectBlock menuBlock;
@property (nonatomic, strong) NSArray *arrGroup;
@property (nonatomic, strong) NSMutableArray *arrSelected;

@end

@implementation MMenuVc

#pragma mark - vcLifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    control.frame = self.view.bounds;
    [control addTarget:self action:@selector(actionControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 350, CGRectGetWidth(self.view.bounds), 350)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    _arrTitles = @[@"相机",@"相册",@"取消"];
    
    
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        
        if (arrObj && arrObj.count > 0) {
            self.arrGroup = arrObj;
            [self setupTableHeaderView];
        }
    }];
    
    self.arrSelected = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    if (self.arrGroup && self.arrGroup.count > 0) {
        
        [self setupTableHeaderView];
    }
}

#pragma mark - public
- (void)setMenuSelectBlock:(menuSelectBlock)block {

    self.menuBlock = block;
}

#pragma mark - privareFunc
- (void)setupTableHeaderView {
    
 
      NSArray *arrIma = [[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:[self.arrGroup firstObject]];
      if (arrIma.count > 0) {
          MHeadImaView *headView = [[MHeadImaView alloc] initWithFrame:CGRectMake(0, 9, CGRectGetWidth(self.view.bounds), 200)];
          [headView reloadDataWithArr:[arrIma subarrayWithRange:NSMakeRange(0, MIN(arrIma.count, 30))] arrSelected:self.arrSelected];
          headView.delegate = self;
          self.tableView.tableHeaderView = headView;
      }
  
    
    

}

- (void)actionControl {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MHeadImaViewDelegate

- (void)selectIndex:(NSUInteger)index headImaSelectType:(headImaSelectType)type {
 NSArray *arrIma = [[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:[self.arrGroup firstObject]];
    if (type == headImaCheckMark) {
       
        [self.arrSelected addObject:arrIma[index]];
    } else if(type == headImaCheckCancel) {
        NSArray *arrCheckmark = [[MImaLibTool shareMImaLibTool] checkMarkSameSetWithArr:self.arrSelected set:arrIma[index]];
        if (arrCheckmark.count > 0) {
            [self.arrSelected removeObject:[arrCheckmark firstObject]];
        }
        
    } else {
        MShowBigImaVc *bvc = [[MShowBigImaVc alloc] initWithArrData:arrIma selectedIma:self.arrSelected];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bvc];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
     
}

#pragma mark -  tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UIImagePickerController *imaPic = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            imaPic.delegate = self;
            [self presentViewController:imaPic animated:nil completion:nil];
        }
        
    } else if ( indexPath.row == 1 && self.arrGroup.count > 0) {
    MShowAllGroup *svc = [[MShowAllGroup alloc] initWithArrGroup:self.arrGroup arrSelected:self.arrSelected];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
        [self presentViewController:nav animated:YES completion:nil];
        
    } else {
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.arrTitles[indexPath.row];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    cell.separatorInset = UIEdgeInsetsZero;
    
    
    return cell;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *ima = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
