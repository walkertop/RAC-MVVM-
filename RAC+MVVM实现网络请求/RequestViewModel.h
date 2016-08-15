//
//  RequestViewModel.h
//  RAC+MVVM网络请求
//
//  Created by 郭彬 on 16/8/9.
//  Copyright © 2016年 walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RequestViewModel : NSObject

@property (nonatomic,strong) RACCommand *requestCommand;

@end
