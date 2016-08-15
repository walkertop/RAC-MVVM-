//
//  RequestViewModel.m
//  RAC+MVVM网络请求
//
//  Created by 郭彬 on 16/8/9.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "RequestViewModel.h"
#import "AFNetworking.h"

@implementation RequestViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self getData];
    }
    return self;
}

- (void)getData {
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"----发送成功----");
            //可以在这类处理数据（其实也可以在返回值中利用RACTuple来处理数据）
            NSArray *dictArray = responseObject[@"books"];
            [subscriber sendNext:dictArray];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"----发送失败-----");
        }];
            
//        [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * _Nonnull responseObject) {
//            
//            NSLog(@"----发送成功----");
//            //可以在这类处理数据（其实也可以在返回值中利用RACTuple来处理数据）
//            NSArray *dictArray = responseObject[@"books"];
//            [subscriber sendNext:dictArray];
//
//            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//                NSLog(@"----发送失败-----");
//            }];
            return nil;
        }];
        return signal;
    }];
}

@end
