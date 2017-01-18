//
//  JFSideBtn.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "JFSideBtn.h"

@implementation JFSideBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.imageView.frame;
    //宽高写死，防止旋转时宽高发生变化
    imageRect.size = CGSizeMake(48, 48);
    imageRect.origin.x = self.bounds.size.width*0.1;
    imageRect.origin.y = 0;
    self.imageView.layer.cornerRadius = 48/2;
    self.imageView.layer.masksToBounds = YES;
    
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.size = CGSizeMake(self.width, self.height-imageRect.size.height);
    titleRect.origin.x = 0;
    titleRect.origin.y = imageRect.size.height+imageRect.origin.y;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
    
}

@end
