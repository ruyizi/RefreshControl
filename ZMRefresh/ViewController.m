//
//  ViewController.m
//  ZMRefresh
//
//  Created by beepay on 2019/4/12.
//  Copyright © 2019 XG. All rights reserved.
//

#import "ViewController.h"
#import "ZMRefreshHeaderControl.h"
#import "ZMRefreshFooterControl.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)ZMRefreshHeaderControl *headerRefresh;

@property (nonatomic, strong)ZMRefreshFooterControl *footerRefresh;

@property (nonatomic, strong)NSMutableArray *dataArrays;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArrays = [NSMutableArray array];
    for (int i= 0; i<10; i++) {
        NSObject *obj = [NSObject new];
        [self.dataArrays addObject:obj];
    }
    

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self)wself = self;
    self.headerRefresh = [ZMRefreshHeaderControl new];
    [self.headerRefresh setOnRefresh:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wself.headerRefresh endRefresh];
        });
    }];
    [self.tableView addSubview:self.headerRefresh];
    
    self.footerRefresh = [ZMRefreshFooterControl new];
    [self.footerRefresh setOnRefresh:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i= 0; i<10; i++) {
                NSObject *obj = [NSObject new];
                [wself.dataArrays addObject:obj];
            }
            [wself.tableView reloadData];
            [wself.footerRefresh endRefresh];
        });
    }];
    [self.tableView addSubview:self.footerRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrays.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}



@end
