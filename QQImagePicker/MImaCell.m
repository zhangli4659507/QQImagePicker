//
//  MImaCell.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MImaCell.h"

@implementation MImaCell
{

    MBoolBlock _boolBlock;
}
- (void)awakeFromNib {
    // Initialization code
    [self.btnCheckMark setImage:[UIImage imageNamed:@"ico_check_red"] forState:UIControlStateSelected];
}

- (void)setBtnSelectedHandle:(MBoolBlock)block {

    _boolBlock = block;
}

- (IBAction)actionBtn:(id)sender {
    
    self.btnCheckMark.selected = !self.btnCheckMark.selected;
    (!_boolBlock) ?: _boolBlock(self.btnCheckMark.selected);
}

@end
