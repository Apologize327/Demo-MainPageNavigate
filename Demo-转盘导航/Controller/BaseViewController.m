//
//  BaseViewController.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/5.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailViewController.h"
#import "JFCustomsizeGestureRecognizer.h"
#import "JFRotateView.h"
#import "CenterBtn.h"

#define kPadding    30
#define kCenterBtnWH    80

@interface BaseViewController ()

/** 旋转的弧度 */
@property(nonatomic,assign) CGFloat rotationAngleInRadians;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpBackground];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setUpBackground{
    UIImageView *backImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base_background"]];
    backImgView.frame = self.view.bounds;
    [self.view addSubview:backImgView];
    
    CGFloat centerBaseWH = kScreenWidth - 2*kPadding;
    JFRotateView *rotatiview = [[JFRotateView alloc]initWithFrame:CGRectMake(0, kScreenHeight*0.2, centerBaseWH, centerBaseWH) sideBtnWH:60];
    rotatiview.centerX = backImgView.centerX;
    [self.view addSubview:rotatiview];
    
    //中心按钮要加在这儿，否则旋转时也跟着转
    CenterBtn *centerBtn = [CenterBtn buttonWithType:UIButtonTypeCustom];
    centerBtn.backgroundColor = [UIColor whiteColor];
    centerBtn.layer.frame = CGRectMake(0, 0, kCenterBtnWH, kCenterBtnWH);
    centerBtn.layer.cornerRadius = kCenterBtnWH/2;
    centerBtn.layer.masksToBounds = YES;
    centerBtn.centerX = rotatiview.centerX;
    centerBtn.centerY = rotatiview.centerY;
    [centerBtn setImage:[UIImage imageNamed:@"home_center_img"] forState:UIControlStateNormal];
    [centerBtn setImage:[UIImage imageNamed:@"home_center_img"] forState:UIControlStateHighlighted];
    [centerBtn setTitle:@"拍照搜题" forState:UIControlStateNormal];
    [centerBtn setTitleColor:[UIColor colorWithRed:102.0/ 255.0 green:190/ 255.0 blue:48/ 255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:centerBtn];
    
    __weak typeof(self) weakSelf = self;
    rotatiview.clickSideBtnBlock = ^(NSString *sideBtnStr){
        DetailViewController *vc = [[DetailViewController alloc]init];
        vc.pageTitle = sideBtnStr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
                                
@end
