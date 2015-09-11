//
//  MShowGroupAllSet.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowGroupAllSet.h"
#import "MImaLibTool.h"
#import "MImaCell.h"
#import "MShowBigImaVc.h"
@interface MShowGroupAllSet ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrSelected;
@end

@implementation MShowGroupAllSet

- (id)initWithGroup:(ALAssetsGroup *)group selectedArr:(NSMutableArray *)arrSelected {

    if (self = [super init]) {
        self.title = [group valueForProperty:ALAssetsGroupPropertyName];
        self.arrData = [[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:group];
        self.arrSelected = arrSelected;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
    flowOut.sectionInset = UIEdgeInsetsZero;
    flowOut.minimumInteritemSpacing = 5;
    flowOut.minimumLineSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowOut];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:MImaCellClassName bundle:nil] forCellWithReuseIdentifier:MImaCellClassName];
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    // Do any additional setup after loading the view.
}


- (void)actionRightBar {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MImaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MImaCellClassName forIndexPath:indexPath];
    ALAsset *set = self.arrData[indexPath.row];
    cell.imavHead.image = [UIImage imageWithCGImage:set.thumbnail];
    cell.btnCheckMark.selected = [[MImaLibTool shareMImaLibTool] imaInArrImasWithArr:self.arrSelected set:set];
    [cell setBtnSelectedHandle:^(BOOL state) {
        
        if (state) {
            [self.arrSelected addObject:set];
        } else {
            NSPredicate *pre = [NSPredicate predicateWithFormat:@" SELF.defaultRepresentation.UTI == %@",set.defaultRepresentation.UTI];
            NSArray *arr = [self.arrSelected filteredArrayUsingPredicate:pre];
            if (arr.count > 0) {
                [self.arrSelected removeObject:[arr firstObject]];
            }
        }
        
    }];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MShowBigImaVc *bvc = [[MShowBigImaVc alloc] initWithArrData:self.arrData selectedIma:self.arrSelected];
    
    [self.navigationController pushViewController:bvc animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    float wid = CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake((wid-3*5)/4, (wid-3*5)/4);
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
