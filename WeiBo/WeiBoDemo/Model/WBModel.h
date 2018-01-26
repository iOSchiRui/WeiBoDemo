//
//  WBModel.h
//  WeiBoDemo
//
//  Created by Seven on 2018/1/24.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBModel : NSObject

@end

@class WBStatusModel;
@interface WBApiModel :NSObject
@property (nonatomic,strong) NSArray *ad;
@property (nonatomic,assign) BOOL hasvisible;
@property (nonatomic,copy)   NSString *gsid;
@property (nonatomic,assign) NSInteger interval;
@property (nonatomic,strong) NSArray *advertises;
@property (nonatomic,assign) NSInteger previous_cursor;
@property (nonatomic,assign) NSInteger total_number;
@property (nonatomic,assign) NSInteger has_unread;
@property (nonatomic,assign) NSInteger max_id;
@property (nonatomic,strong) NSArray <WBStatusModel *>*statuses;
@property (nonatomic,strong) NSArray *trends;
@property (nonatomic,assign) NSInteger next_cursor;
@property (nonatomic,assign) NSInteger since_id;
@end

@class WBStatusTitle;
@interface WBStatusModel:NSObject
@property (nonatomic,assign) BOOL favorited;
@property (nonatomic,assign) NSInteger mblogtype;
@property (nonatomic,assign) NSInteger attitudes_status;
@property (nonatomic,copy)   NSString *created_at;
@property (nonatomic,copy)   NSString *statusId;
@property (nonatomic,copy)   NSString *mblogid;
@property (nonatomic,copy)   NSString *pic_bg;
@property (nonatomic,copy)   NSString *text;
@property (nonatomic,copy)   NSString *idstr;
@property (nonatomic,assign) NSInteger source_type;
@property (nonatomic,strong) id retweeted_status;
@property (nonatomic,strong) id user;
@property (nonatomic,strong) WBStatusTitle *wbStatusTitle;
@end

@interface WBStatusTitle:NSObject
@property (nonatomic,copy)    NSString *icon_url;
@property (nonatomic,copy)    NSString *text;
@property (nonatomic,assign)  NSInteger base_color;
@end
