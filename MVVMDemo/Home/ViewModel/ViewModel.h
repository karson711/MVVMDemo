//
//  ViewModel.h
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface ViewModel : NSObject

@property int page;

@property SendValueType sendType;

/**
 *  block传值
 */
-(void)getlistArrWithSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure;

/**
 *  RAC传值
 */
- (RACSignal *)getListArr;

@end
