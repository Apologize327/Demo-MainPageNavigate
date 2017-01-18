//
//  UIImage+SHResizeImage.h
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//
//  等比例缩放图片

#import <UIKit/UIKit.h>

@interface UIImage (SHResizeImage)

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

@end
