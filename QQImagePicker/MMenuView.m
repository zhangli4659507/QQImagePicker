//
//  MMenuView.m
//  QQImagePicker
//
//  Created by mark on 15/9/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MMenuView.h"
#import "MHeadImaView.h"
@interface MMenuView () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitles;
@end
@implementation MMenuView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.rowHeight = 50;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        _arrTitles = @[@"相机",@"相册",@"取消"];
        
        [self setupTableHeaderView];
    }
    return self;
}


- (void)setupTableHeaderView {
    
 
    MHeadImaView *headView = [[MHeadImaView alloc] initWithFrame:CGRectMake(0, 9, CGRectGetWidth(self.frame), 200)];
    self.tableView.tableHeaderView = headView;
    
    
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
