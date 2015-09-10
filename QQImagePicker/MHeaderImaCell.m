//
//  MHeaderImaCell.m
//  QQImagePicker
//
//  Created by mark on 15/9/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MHeaderImaCell.h"

@implementation MHeaderImaCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.btnCheckMark = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnCheckMark.frame = CGRectMake(CGRectGetWidth(self.frame)-MHeaderImaCellBtn_width, MHeaderImaCellBtn_x_space, MHeaderImaCellBtn_width, MHeaderImaCellBtn_width);
        [self.btnCheckMark setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.btnCheckMark];
        
        [self.btnCheckMark setImage:[UIImage imageNamed:@"ico_check_red"] forState:UIControlStateSelected];
        [self.btnCheckMark setImage:[UIImage imageNamed:@"ico_check_nomal"] forState:UIControlStateNormal];
    }
    return self;
}

@end
