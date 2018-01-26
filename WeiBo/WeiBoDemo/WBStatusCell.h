//
//  WBStatusCell.h
//  WeiBoDemo
//
//  Created by Seven on 2018/1/25.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import "CRTableViewCell.h"
#import "WBStatusLayout.h"

@interface WBStatusTitleView : UIView
@property (nonatomic, strong) YYLabel *titleLabel;
@end

@interface WBStatusView : UIView
@property (nonatomic, strong) WBStatusTitleView *statusTitleView;

@property (nonatomic, strong) WBStatusLayout *layout;
@end

@interface WBStatusCell : CRTableViewCell
@property (nonatomic, strong) WBStatusView *statusView;
- (void)setLayout:(WBStatusLayout *)layout;
@end

