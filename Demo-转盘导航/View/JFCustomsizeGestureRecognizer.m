//
//  JFCustomsizeGestureRecognizer.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/6.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "JFCustomsizeGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation JFCustomsizeGestureRecognizer

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) { //手势的默认状态
        self.state = UIGestureRecognizerStateBegan;
    } else {
        self.state = UIGestureRecognizerStateChanged;
    }
    
    UITouch *touch = [touches anyObject];
    //获取手指触摸的view
    UIView *touchView = self.view;
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(touchView.bounds), CGRectGetMidY(touchView.bounds));
    CGPoint currentPoint = [touch locationInView:touchView];
    CGPoint previousPoint = [touch previousLocationInView:touchView];
    
    //计算角度
    /**
     有两个点 point(x1,y1), 和 point(x2,y2)，那么这两个点形成的斜率的角度计算方法分别是：
     float angle = atan2( y2-y1, x2-x1 );
     因为每次转60度，所以用减法
     */
    CGFloat rotationAngle = atan2(currentPoint.y-centerPoint.y, currentPoint.x-centerPoint.x) - atan2(previousPoint.y-centerPoint.y, previousPoint.x-centerPoint.x);
    self.rotationAngle = rotationAngle;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateEnded;
    } else {
        self.state = UIGestureRecognizerStateFailed;
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.state = UIGestureRecognizerStateFailed;
}

@end
