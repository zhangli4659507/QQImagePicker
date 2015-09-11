//
//  MImaCell.h
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

static NSString *MImaCellClassName = @"MImaCell";

@interface MImaCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckMark;
- (void)setBtnSelectedHandle:(MBoolBlock)block;
@end
