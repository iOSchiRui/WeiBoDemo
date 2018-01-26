//
//  WBStatusLayout.m
//  WeiBoDemo
//
//  Created by Seven on 2018/1/25.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import "WBStatusLayout.h"

/**
 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
 */
@interface WBTextImageViewAttachment : YYTextAttachment
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;
@end

@implementation WBTextImageViewAttachment {
    UIImageView *_imageView;
}
- (void)setContent:(id)content {
    _imageView = content;
}
- (id)content {
    /// UIImageView 只能在主线程访问
    if (pthread_main_np() == 0) return nil;
    if (_imageView) return _imageView;
    
    /// 第一次获取时 (应该是在文本渲染完成，需要添加附件视图时)，初始化图片视图，并下载图片
    /// 这里改成 YYAnimatedImageView 就能支持 GIF/APNG/WebP 动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}
@end

@implementation WBStatusLayout
- (instancetype)initWithStatus:(WBStatusModel *)status {
    if (!status || !status.user) {
        return nil;
    }
    self = [super init];
    _status = status;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)_layout {
    _marginTop = KWBCellTopMargin;
    _titleHeight = 0;
    _marginBottom = KWBCellTopMargin;
    
    [self _layoutTitle];
    
    _height = 0;
    _height += _marginTop;
    _height += _titleHeight;
    _height += _marginBottom;
}

- (void)_layoutTitle {
    _titleHeight = 0;
    _titleTextLayout = nil;
    
    WBStatusTitle *title = _status.wbStatusTitle;
    NSLog(@"%@",title.text);
    if (title.text.length == 0) {
        return;
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:title.text];
//    if (title.icon_url) {
//        NSAttributedString *icon = [self _attachmentWithFontSize:14 imageURL:title.icon_url shrink:NO];
//        if (icon) {
//            [text insertAttributedString:icon atIndex:0];
//        }
//    }
    text.color = kWBCellToolbarTitleColor;
    text.font = [UIFont systemFontOfSize:14];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 100, KWBCellTitleHeight)];
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _titleHeight = KWBCellTitleHeight;
}

- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize imageURL:(NSString *)imageURL shrink:(BOOL)shrink {
    /*
     微博 URL 嵌入的图片，比临近的字体要小一圈。。
     这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
     */
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    CGSize size = CGSizeMake(fontSize, fontSize);
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        size = CGSizeMake(fontSize - fontSize * scale * 2, fontSize - fontSize * scale * 2);
        size = CGSizePixelRound(size);
    }
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    WBTextImageViewAttachment *attachment = [WBTextImageViewAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.size = size;
//    attachment.imageURL = [WBStatusHelper defaultURLForImageURL:imageURL];
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}
@end
