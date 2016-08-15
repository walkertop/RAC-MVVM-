//
//  ViewController.m
//  RAC+MVVM网络请求
//
//  Created by 郭彬 on 16/8/9.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ReactiveCocoa.h"
#import "RequestViewModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) RequestViewModel *requestVM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 60;
    
    [self getDataFromRequestVM];
}

- (void)getDataFromRequestVM {
    
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        self.dataArray = x;
        [self.tableView reloadData];
    }];
}

#pragma mark - dataSource

// tableView 的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// tableView 的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// cell的数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"image"];
    
    return cell;
}

#pragma mark - lazy

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (RequestViewModel *)requestVM {
    if (!_requestVM) {
        _requestVM = [[RequestViewModel alloc]init];
    }
    return _requestVM;
}

@end
