//
//  MVVMCellModel.h
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface MVVMCellModel : NSObject

@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,strong) NSString *newsCreateTime;
@property (nonatomic,strong) NSString *newsId;
@property (nonatomic,strong) NSString *newsImage;
@property (nonatomic,strong) NSString *newsLink;
@property (nonatomic,strong) NSString *newsNum;
@property (nonatomic,strong) NSString *newsSource;
@property (nonatomic,strong) NSString *newsTitle;
@property (nonatomic,strong) NSString *newsType;
@property (nonatomic,strong) NSString *newsTypeName;
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *updatedAt;

+(MVVMCellModel *)modelWithDict:(NSDictionary *)dict;

@end
