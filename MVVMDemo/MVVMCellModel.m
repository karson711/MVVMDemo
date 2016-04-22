//
//  MVVMCellModel.m
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "MVVMCellModel.h"

@implementation MVVMCellModel

+(MVVMCellModel *)modelWithDict:(NSDictionary *)dict
{
    MVVMCellModel *model = [MVVMCellModel mj_objectWithKeyValues:dict];
    return model;
}

/**
 createdAt = "2016-04-19 11:00:07";
 newsCreateTime = "2016-04-19";
 newsId = 7f5c4ae2981bd7b379336a5a4b0b13ef;
 newsImage = "http://cc.cocimg.com/api/uploads/160419/7647b0efaed7a55f0e9e0858251d9834.jpg";
 newsLink = "http://www.cocoachina.com/cms/wap.php?action=article&id=15959";
 newsNum = 0;
 newsSource = MacRumors;
 newsTitle = "\U82f9\U679c\U5f00\U53d1\U8005\U7f51\U7ad9\U6539\U7248\Uff1a\U8bb2\U8ff0App Store\U6210\U529f\U80cc\U540e\U7684\U6545\U4e8b";
 newsType = apple;
 newsTypeName = "\U82f9\U679c\U76f8\U5173";
 objectId = acbb3a48f1;
 updatedAt = "2016-04-19 11:00:07";
 */

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"createdAt":@"createdAt",
             @"newsCreateTime":@"newsCreateTime",
             @"newsId":@"newsId",
             @"newsImage":@"newsImage",
             @"newsLink":@"newsLink",
             @"newsNum":@"newsNum",
             @"newsSource":@"newsSource",
             @"newsTitle":@"newsTitle",
             @"newsType":@"newsType",
             @"newsTypeName":@"newsTypeName",
             @"objectId":@"objectId",
             @"updatedAt":@"updatedAt"
             };
}



@end
