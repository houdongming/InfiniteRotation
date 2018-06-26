//
//  ViewController.m
//  InfiniteRotation
//
//  Created by Office on 2018/4/3.
//  Copyright © 2018年 侯东明. All rights reserved.
//

#import "ViewController.h"
#import "SUTableView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SUTableView *SUTableView;
@property(nonatomic)NSInteger seconds;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"无限轮循";
    self.navigationController.navigationBar.translucent =NO;
    // Do any additional setup after loading the view, typically from a nib.
    _SUTableView = [[SUTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _SUTableView.delegate = self;
    _SUTableView.dataSource = self;
    _SUTableView.showsVerticalScrollIndicator = NO;
    _SUTableView.rowHeight = 150;
   // _SUTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.SUTableView];

    [self.SUTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _seconds =0;
    [self startTimer];
}
//轮播
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    
    if ([keyPath isEqualToString:@"contentOffset"])
        
    {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
        _seconds =offset.y/150;
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self.SUTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =[NSString stringWithFormat:@"你看到的是%ld个选项", indexPath.row+1];
    // cell.titleLabel.text =[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}
- (void)next{
    _seconds++;
    [self.SUTableView setContentOffset:CGPointMake(0, _seconds *150) animated:YES];
    
}
#pragma mark - 定时器处理
- (void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
