//
//  ViewModel.m
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ViewModel.h"
#import "MVVMCellModel.h"
@implementation ViewModel

/**
 *  Block
 */
-(void)getlistArrWithSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure{
    [[APIClient sharedManager] netWorkGetHomePageListWithPageSize:5 pageNum:self.page success:^(Response *respone) {
        NSLog(@".......respone.description : %@",respone.description);
        if (respone.status == kEnumServerStateSuccess) {
            NSLog(@"请求成功!");
            NSMutableArray *tmpArr=[NSMutableArray array];
            for (NSDictionary *subDic in (NSArray *)[respone.data valueForKey:@"results"]) {
                 MVVMCellModel *model = [MVVMCellModel modelWithDict:subDic];
                [tmpArr addObject:model];
            }
            success(tmpArr);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   RAC
 */
- (RACSignal *)getListArr
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[APIClient sharedManager] netWorkGetHomePageListWithPageSize:5 pageNum:self.page success:^(Response *respone) {
            NSLog(@".......respone.description : %@",respone.description);
            if (respone.status == kEnumServerStateSuccess) {
                NSLog(@"请求成功!");
                NSMutableArray *tmpArr=[NSMutableArray array];
                for (NSDictionary *subDic in (NSArray *)[respone.data valueForKey:@"results"]) {
                    MVVMCellModel *model = [MVVMCellModel modelWithDict:subDic];
                    [tmpArr addObject:model];
                }
                [subscriber sendNext:tmpArr];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}


@end
