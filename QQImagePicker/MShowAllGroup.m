//
//  MShowAllGroup.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowAllGroup.h"
#import "MGroupCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MImaLibTool.h"
#import "MShowGroupAllSet.h"
@interface MShowAllGroup ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrSeleted;
@property (nonatomic, strong) NSArray *arrGroup;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MShowAllGroup

- (id)initWithArrGroup:(NSArray *)arrGroup arrSelected:(NSArray *)arr {

    if (self = [super init]) {
        
        self.arrSeleted = arr;
        self.arrGroup = arrGroup;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:MGroupCellClassName bundle:nil] forCellReuseIdentifier:MGroupCellClassName];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    // Do any additional setup after loading the view.
}


- (void)actionRightBar {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:MGroupCellClassName];
    ALAssetsGroup *froup = self.arrGroup[indexPath.row];
    cell.lblInfo.text = [NSString stringWithFormat:@"%@(%ld)",[froup valueForProperty:ALAssetsGroupPropertyName],[froup numberOfAssets]];
    cell.imavHead.image = [UIImage imageWithCGImage:froup.posterImage];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MShowGroupAllSet *mvc = [[MShowGroupAllSet alloc] initWithGroup:self.arrGroup[indexPath.row] selectedArr:self.arrSeleted];
    [self.navigationController pushViewController:mvc animated:YES];
    
    
    
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
