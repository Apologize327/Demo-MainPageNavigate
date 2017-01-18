//
//  UIImage+SHResizeImage.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "UIImage+SHResizeImage.h"

@implementation UIImage (SHResizeImage)

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
//    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
//    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
//    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;
    
    CGSize newSize = CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
