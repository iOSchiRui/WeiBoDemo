//
//  WBStatusCell.m
//  WeiBoDemo
//
//  Created by Seven on 2018/1/25.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import "WBStatusCell.h"

@implementation WBStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _statusView = [WBStatusView new];
        [self.contentView addSubview:_statusView];
    }
    return self;
}

- (void)setLayout:(WBStatusLayout *)layout{
    self.height = layout.height;
    self.contentView.height = layout.height;
    _statusView.layout = layout;
}

@end

@implementation WBStatusView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.width = 1;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _statusTitleView = [WBStatusTitleView new];
        _statusTitleView.hidden = YES;
        _statusTitleView.height = 1;
        _statusTitleView.width = kScreenWidth;
        [self addSubview:_statusTitleView];
    }
    return self;
}

- (void)setLayout:(WBStatusLayout *)layout {
    _layout = layout;
    
    self.height = layout.height;
    _statusTitleView.top = layout.marginTop;
    _statusTitleView.height = layout.height - layout.marginTop - layout.marginBottom;
    
//    CGFloat top = 0;
    if (layout.titleHeight > 0) {
        _statusTitleView.hidden = NO;
        _statusTitleView.height = layout.titleHeight;
        _statusTitleView.titleLabel.textLayout = layout.titleTextLayout;
    }else{
        _statusTitleView.hidden = YES;
    }
}

@end

@implementation WBStatusTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = KWBCellTitleHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [YYLabel new];
        _titleLabel.size = CGSizeMake(kScreenWidth - 100, self.height);
        _titleLabel.left = kWBCellPadding;
        _titleLabel.displaysAsynchronously = YES;
        _titleLabel.ignoreCommonProperties = YES;
        _titleLabel.fadeOnHighlight = NO;
        _titleLabel.fadeOnAsynchronouslyDisplay = NO;
        [self addSubview:_titleLabel];
    }
    return self;
}
@end
