//
//  WBStatusLayout.h
//  WeiBoDemo
//
//  Created by Seven on 2018/1/25.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBModel.h"

//宽高
#define KWBCellTopMargin 8 //顶部留白
#define KWBCellTitleHeight 36 //标题栏高度

#define kWBCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色

#define kWBCellPadding 12       // cell 内边距

/**
 布局
 */
@interface WBStatusLayout : NSObject
- (instancetype)initWithStatus:(WBStatusModel *)status;
- (void)layout;

@property (nonatomic, strong) WBStatusModel *status;

//顶部留白
@property (nonatomic, assign) CGFloat marginTop;

//标题栏
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, strong) YYTextLayout *titleTextLayout;

//下方留白
@property (nonatomic, assign) CGFloat marginBottom;

//总高度
@property (nonatomic, assign) CGFloat height;
@end

