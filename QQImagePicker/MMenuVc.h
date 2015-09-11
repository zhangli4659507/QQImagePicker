//
//  MMenuVc.h
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    selectSend = 1,
    selectCancel = 2,
    selectCamera = 3,
    selectPhotoLib = 4
}menuSelectedType;

typedef void (^menuSelectBlock)(id obj,menuSelectedType type);

@interface MMenuVc : UIViewController
- (void)setMenuSelectBlock:(menuSelectBlock)block;
@end
