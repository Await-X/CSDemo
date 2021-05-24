//
//  MyPagingStoreHeaderView.m
//  YGVideo
//
//  Created by apple on 2020/10/30.
//  Copyright © 2020 YG. All rights reserved.
//

#import "MyPagingStoreHeaderView.h"

@interface MyPagingStoreHeaderView ()
///
@property (nonatomic, assign) CGRect imageViewFrame;
///
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MyPagingStoreHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        //_imageView.image = [UIImage imageNamed:@"lufei.jpg"];
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES; // 上面有按钮
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _nickLabel = [[UILabel alloc] init];
        self.nickLabel.font = [UIFont systemFontOfSize:20];
        //self.nickLabel.text = @"Monkey·D·路飞";
        self.nickLabel.textColor = [UIColor redColor];
        [self addSubview:self.nickLabel];
        
        _topImageView = [[UIImageView alloc] init];
        self.topImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
        [self addSubview:self.topImageView];
        
        _btn = [[UIButton alloc] init];
        self.btn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.btn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
        [self.btn addTarget:self action:@selector(onBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.btn];
        
        _scrollView = [[UIScrollView alloc] init];
        self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.scrollView];
         
    }
    return self;
}

- (void)onBtnClick
{
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // 每次调整 高度都要处理这里
    self.imageViewFrame = self.bounds;
    self.nickLabel.frame = CGRectMake(10, self.bounds.size.height - 30, 200, 20);
    self.topImageView.frame = CGRectMake(15, 10, self.bounds.size.width - 30, 120);
    self.btn.frame = CGRectMake(15, 10, self.bounds.size.width - 30, 120);
    self.scrollView.frame = CGRectMake(15, 140, self.bounds.size.width - 30, 80);
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}

@end
