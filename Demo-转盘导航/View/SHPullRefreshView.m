//
//  SHPullRefreshView.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "SHPullRefreshView.h"
#import "UIImage+SHResizeImage.h"

#define imageScale  0.6

@implementation SHPullRefreshView

- (void)prepare
{
    [super prepare];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading000%zd", i]];
        image = [UIImage scaleImage:image toScale:imageScale];
        [idleImages addObject:image];
    }
    for (NSUInteger i = 10; i<=47; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading00%zd", i]];
        image = [UIImage scaleImage:image toScale:imageScale];
        [idleImages addObject:image];
    }
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 48; i<=77; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading00%zd", i]];
        image = [UIImage scaleImage:image toScale:imageScale];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
