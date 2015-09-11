//
//  MShowBigImaVc.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowBigImaVc.h"
#import "MImaCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface MShowBigImaVc ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrSelected;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MShowBigImaVc

- (id)initWithArrData:(NSArray *)arrData selectedIma:(NSMutableArray *)arrSelected {

    if (self = [super init]) {
        self.arrData = arrData;
        self.arrSelected = arrSelected;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
    flowOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowOut.minimumInteritemSpacing = 0;
    flowOut.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowOut];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:MImaCellClassName bundle:nil] forCellWithReuseIdentifier:MImaCellClassName];
    
    if (self.navigationController.viewControllers.count == 1) {
          UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightBar)];
        self.navigationItem.leftBarButtonItem = rightBar;
    }
    
    // Do any additional setup after loading the view.
}

- (void)actionRightBar {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MImaCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:MImaCellClassName forIndexPath:indexPath];
    cell.btnCheckMark.hidden = YES;
    cell.imavHead.contentMode = UIViewContentModeScaleAspectFit;
    ALAsset *set = self.arrData[indexPath.row];
    cell.imavHead.image = [UIImage imageWithCGImage:[[set defaultRepresentation] fullScreenImage]];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.view.bounds.size;
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
