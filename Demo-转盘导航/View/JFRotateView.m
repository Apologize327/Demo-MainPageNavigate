//
//  JFRotateView.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/11.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "JFRotateView.h"
#import "CenterBtn.h"
#import "JFCustomsizeGestureRecognizer.h"
#import "JFSideBtn.h"

@interface JFRotateView()<UIGestureRecognizerDelegate>{
    UIImageView *_centerBaseView;
}

@property(nonatomic,strong) NSArray *imgArr;

@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSMutableArray *sideBtnArr;
/** 旋转的弧度 */
@property(nonatomic,assign) CGFloat rotationAngleInRadians;

@end

@implementation JFRotateView

-(instancetype)initWithFrame:(CGRect)frame sideBtnWH:(CGFloat)sideBtnWH{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.sideBtnArr = [NSMutableArray array];
        
        self.sideBtnWH = sideBtnWH;
        
        [self setUpBackground];
        [self setSideView];
        JFCustomsizeGestureRecognizer *tap = [[JFCustomsizeGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheCenterView:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)setUpBackground{
    UIImageView *centerBaseView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_center_bg"]];
    centerBaseView.frame = self.bounds;
    [self addSubview:centerBaseView];
    _centerBaseView = centerBaseView;

}

-(void)setSideView{
    NSInteger itemCount = self.imgArr.count;
    //两个button之间与圆心夹角
    CGFloat corner = 2*M_PI/itemCount;
    //转轴圆半径,减去30是用来微调的
    CGFloat circleRadius = (self.width - self.sideBtnWH)/2 - 30;
    //圆心x,y坐标
    CGFloat circleX = _centerBaseView.centerX;
    CGFloat circleY = _centerBaseView.centerY;
    /**
     *  所以，按钮的中心坐标可以这样计算
     *  x = circleX + circleRadius * sin(i*corner);
     *  y = circleY - circleRadius * cos(i*corner);
     */
    for (NSInteger i=0; i<itemCount; i++) {
        JFSideBtn *sideBtn = [JFSideBtn buttonWithType:UIButtonTypeCustom];
        sideBtn.frame = CGRectMake(0, 0, self.sideBtnWH, self.sideBtnWH);
        CGFloat btnCenterX = circleX + circleRadius * sin(i*corner);
        CGFloat btnCenterY = circleY - circleRadius * cos(i*corner);
        CGPoint point = CGPointMake(btnCenterX, btnCenterY);
        sideBtn.center = point;
        [sideBtn setImage:[UIImage imageNamed:[self.imgArr objectAtIndex:i]] forState:UIControlStateNormal];
        [sideBtn setImage:[UIImage imageNamed:[self.imgArr objectAtIndex:i]] forState:UIControlStateHighlighted];
        [self addSubview:sideBtn];
        sideBtn.tag = i;
        [sideBtn addTarget:self action:@selector(goToDetailPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.sideBtnArr addObject:sideBtn];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, sideBtn.height*0.8, sideBtn.width, 20)];
        titleLab.text = [self.titleArr objectAtIndex:i];
        titleLab.font = [UIFont systemFontOfSize:12.0];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        [sideBtn addSubview:titleLab];
    }
}

-(void)goToDetailPage:(JFSideBtn *)sideBtn{
    if (self.clickSideBtnBlock) {
        self.clickSideBtnBlock([self.titleArr objectAtIndex:sideBtn.tag]);
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[JFSideBtn class]]) {
        return NO;
    }
    return YES;
}

-(void)tapTheCenterView:(JFCustomsizeGestureRecognizer *)tap{
    switch (tap.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:{
            self.rotationAngleInRadians += tap.rotationAngle;
            
            //旋转动画
            [UIView animateWithDuration:0.25f animations:^{
                self.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians+tap.rotationAngle);
                for (JFSideBtn *btn in self.sideBtnArr) {
                    btn.transform = CGAffineTransformMakeRotation(-(self.rotationAngleInRadians+tap.rotationAngle));
                }
            }];
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            int num = self.rotationAngleInRadians/(M_PI/3);
            int last = ((NSInteger)(self.rotationAngleInRadians*(180/M_PI)))%(60);
            if (abs(last) >= 30) {
                [UIView animateWithDuration:0.25f animations:^{
                    self.transform = CGAffineTransformMakeRotation(M_PI/3*last>0?(num+1):(num-1));
                    for (JFSideBtn *btn in self.sideBtnArr) {
                        btn.transform = CGAffineTransformMakeRotation(-(M_PI/3*last>0?(num+1):(num-1)));
                    }
                }];
                
                //偏转角度保存。
                self.rotationAngleInRadians = M_PI/3*(last>0?(num+1):(num-1));
            } else {
                [UIView animateWithDuration:.25 animations:^{
                    self.transform = CGAffineTransformMakeRotation(M_PI/3*num);
                    for (JFSideBtn *btn in self.sideBtnArr) {
                        btn.transform = CGAffineTransformMakeRotation(-(M_PI/3*num));
                    }
                }];
                self.rotationAngleInRadians = M_PI/3*num;
            }
            break;
        }
            
            
        default:
            break;
    }
}

#pragma mark - setter/getter
-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSArray arrayWithObjects:@"index_yingyong",@"index_shiti",@"index_discussion",@"index_shijuan",@"index_xunlian",@"index_pvideo", nil];
    }
    return _imgArr;
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray arrayWithObjects:@"应用汇",@"查试题",@"爱问答",@"看试卷",@"做训练",@"微视频", nil];
    }
    return _titleArr;
}

@end
