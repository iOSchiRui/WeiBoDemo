//
//  WBModel.m
//  WeiBoDemo
//
//  Created by Seven on 2018/1/24.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import "WBModel.h"

@implementation WBModel

@end

@implementation WBApiModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"statuses" : [WBStatusModel class]};
}
@end

@implementation WBStatusModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"statusId" : @"id",
             @"wbStatusTitle" : @"title"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"title" : [WBStatusTitle class]};
}
@end

@implementation WBStatusTitle

@end
