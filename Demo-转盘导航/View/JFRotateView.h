//
//  JFRotateView.h
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//
//  中间的转盘view

#import <UIKit/UIKit.h>

@interface JFRotateView : UIView

/** 边缘按钮宽高 */
@property(nonatomic,assign) CGFloat sideBtnWH;

/** 点击边缘按钮方法 */
@property(nonatomic,copy) void(^clickSideBtnBlock)(NSString *);


-(instancetype)initWithFrame:(CGRect)frame sideBtnWH:(CGFloat) sideBtnWH;

@end
