//
//  CenterBtn.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/5.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "CenterBtn.h"

@implementation CenterBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.imageView.frame;
    CGFloat imgViewWH = self.width*0.5;
    imageRect.size = CGSizeMake(imgViewWH, imgViewWH);
    imageRect.origin.x = (self.width - imgViewWH) * 0.5;
    imageRect.origin.y = (self.width - imgViewWH) * 0.2;
    
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.size = CGSizeMake(self.width, self.height-imageRect.size.height -15);
    titleRect.origin.x = 0;
    titleRect.origin.y = imageRect.size.height+imageRect.origin.y;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
