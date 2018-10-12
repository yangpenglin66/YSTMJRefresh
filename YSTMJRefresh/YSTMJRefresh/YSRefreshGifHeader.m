//
//  YSRefreshGifHeader.m
//  MJRefresh
//
//  Created by 杨书通 on 2018/9/28.
//  Copyright © 2018年 杨书通. All rights reserved.
//

#import "YSRefreshGifHeader.h"

@interface YSRefreshGifHeader()
/** 刷新中图片数据 */
@property (nonatomic, strong) NSMutableArray *refreshImages;
/** 图片下面的文字 */
@property (nonatomic, weak) UILabel *stateLab;
@end

@implementation YSRefreshGifHeader

- (NSMutableArray *)refreshImages{
    if (!_refreshImages) {
        _refreshImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"rs_refresh_%d",i]];
            [_refreshImages addObject:image];
        }
    }
    return _refreshImages;
}


- (void)prepare{
    [super prepare];
    self.mj_h = 80;
    [self setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [self setImages:self.refreshImages forState:MJRefreshStateIdle];
    [self setImages:self.refreshImages forState:MJRefreshStatePulling];
    self.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    self.stateLabel.hidden = YES;
    UILabel *stateLab = [[UILabel alloc] init];
    stateLab.textAlignment = NSTextAlignmentCenter;
    stateLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:stateLab];
    self.stateLab = stateLab;
}

- (void)placeSubviews{
    [super placeSubviews];
    self.gifView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 60) * 0.5, 0, 60, 60);
    self.stateLab.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 20);
}

- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.stateLab.text = @"下拉刷新";
            NSLog(@"普通闲置状态");
            break;
        case MJRefreshStatePulling:
            self.stateLab.text = @"松开就刷新";
            NSLog(@"松开就可以进行刷新的状态");
            break;
        case MJRefreshStateRefreshing:
            self.stateLab.text = @"刷新中";
            NSLog(@"正在刷新中的状态");
            break;
        case MJRefreshStateWillRefresh:
            self.stateLab.text = @"将要刷新";
            NSLog(@"即将刷新的状态");
            break;
        case MJRefreshStateNoMoreData:
            self.stateLab.text = @"刷新完成";
            NSLog(@"所有数据加载完毕，没有更多的数据了");
            break;

        default:
            break;
    }
}

@end
