//
//  ViewController.m
//  MVVMDemo
//
//  Created by kunge on 16/4/20.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "MVVMCell.h"
#import "MVVMCellModel.h"
#import <MJRefresh/MJRefresh.h>
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)ViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITableView *mvvmTable;

@property(nonatomic,strong)NSMutableArray *listArr;

@end
//https://github.com/karson711/MVVMDemo.git

@implementation ViewController

#pragma mark  - 懒加载
-(ViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModel alloc] init];
        _viewModel.page = 0;
        _viewModel.sendType = BlockType;
    }
    return _viewModel;
}

-(NSMutableArray *)listArr{
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Block" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    // 上拉加载
    self.mvvmTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    //下拉刷新
    self.mvvmTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
}

-(void)rightBarAction{
    if (self.viewModel.sendType == BlockType) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"RAC" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
        self.viewModel.sendType = RACType;
    }else if (self.viewModel.sendType == RACType){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Block" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
        self.viewModel.sendType = BlockType;
    }
}

#pragma mark - 数据加载
-(void)refreshData{
    self.viewModel.page = 0;
    if (self.viewModel.sendType == BlockType) {
        [self.viewModel getlistArrWithSuccess:^(NSArray *arr) {
            [self.listArr removeAllObjects];
            [self.listArr addObjectsFromArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mvvmTable reloadData];
                [self.mvvmTable.mj_header endRefreshing];
            });
        } Failure:^(NSError *error) {
            NSLog(@"请求失败 error:%@",error.description);
            [self.mvvmTable.mj_header endRefreshing];
        }];
    }else if (self.viewModel.sendType == RACType){
        RACSignal *listSingal = nil;
        listSingal = [self.viewModel getListArr];
        if (listSingal) {
            [listSingal  subscribeNext:^(id x) {
                [self.listArr removeAllObjects];
                [self.listArr addObjectsFromArray:x];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mvvmTable reloadData];
                    [self.mvvmTable.mj_header endRefreshing];
                });
            } error:^(NSError *error) {
                NSLog(@"请求失败 error:%@",error.description);
                [self.mvvmTable.mj_header endRefreshing];
            }];
        }
    }
}

-(void)loadMoreData{
    self.viewModel.page++;
    if (self.viewModel.sendType == BlockType) {
        [self.viewModel getlistArrWithSuccess:^(NSArray *arr) {
            if (arr.count > 0) {
                [self.listArr addObjectsFromArray:arr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mvvmTable reloadData];
                    [self.mvvmTable.mj_footer endRefreshing];
                });
            }else{
                NSLog(@"已无更多加载数据");
                [self.mvvmTable.mj_footer endRefreshing];
            }
        } Failure:^(NSError *error) {
            NSLog(@"请求失败 error:%@",error.description);
            [self.mvvmTable.mj_footer endRefreshing];
        }];
    }else if (self.viewModel.sendType == RACType){
        [[self.viewModel getListArr]  subscribeNext:^(id x) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:x];
            if (tempArr.count > 0) {
                [self.listArr addObjectsFromArray:x];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mvvmTable reloadData];
                    [self.mvvmTable.mj_footer endRefreshing];
                });
            }else{
                NSLog(@"已无更多加载数据");
                [self.mvvmTable.mj_footer endRefreshing];
            }
        } error:^(NSError *error) {
            NSLog(@"请求失败 error:%@",error.description);
            [self.mvvmTable.mj_header endRefreshing];
        }];
    }
}

#pragma mark - MVVMTableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MVVMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mvvmCell"];
    if (self.listArr.count > 0) {
        MVVMCellModel *cellModel = (MVVMCellModel *)self.listArr[indexPath.row];
        cell.cellModel = cellModel;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MVVMCellModel *model = (MVVMCellModel *)self.listArr[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.title = model.newsTitle;
    detail.urlStr = model.newsLink;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
