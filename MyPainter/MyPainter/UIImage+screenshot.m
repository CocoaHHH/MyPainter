//
//  UIImage+screenshot.m
//  MyPainter
//
//  Created by 徐宏 on 2017/4/5.
//  Copyright © 2017年 hankekke. All rights reserved.
//

#import "UIImage+screenshot.h"

@implementation UIImage (screenshot)

+ (UIImage *)screenShotWithView:(UIView *)view {
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    //截图
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
