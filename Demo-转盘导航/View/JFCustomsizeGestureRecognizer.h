//
//  JFCustomsizeGestureRecognizer.h
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/6.
//  Copyright © 2017年 jf. All rights reserved.
//
//  自定义手势，用来记录旋转角度

#import <UIKit/UIKit.h>

@interface JFCustomsizeGestureRecognizer : UIGestureRecognizer
/** 记录最后一次手势改变时的旋转角度 */
@property(nonatomic,assign) CGFloat rotationAngle;

@end
