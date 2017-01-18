//
//  DetailViewController.m
//  Demo-转盘导航
//
//  Created by Suning on 2017/1/5.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "DetailViewController.h"
#import "SHPullRefreshView.h"

static const CGFloat MJDuration = 3.0;

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    [self setNavigation];
    [self setUpBackground];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setNavigation{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(popPrevivousPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)setUpBackground{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.mj_header = [SHPullRefreshView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

-(void)loadNewData{
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
    
    for (NSInteger i=16; i<30; i++) {
        [self.dataArr insertObject:[NSString stringWithFormat:@"%ld",(long)i] atIndex:0];
    }
    
    __weak UITableView *tableView = _tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

-(void)popPrevivousPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setPageTitle:(NSString *)pageTitle{
    self.title = pageTitle;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (NSInteger i=0; i<15; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return _dataArr;
}

@end
