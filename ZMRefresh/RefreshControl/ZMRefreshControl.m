//
//  ZMRefreshControl.m
//  XGChat
//
//  Created by beepay on 2019/4/11.
//  Copyright © 2019 XG. All rights reserved.
//

#import "ZMRefreshControl.h"

@interface ZMRefreshControl ()


@end

@implementation ZMRefreshControl


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _refreshingType = RefreshHeaderStateIdle;
        _indicatorView = [ZMWaveLoadingView loadingView];
        [self addSubview:_indicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _indicatorView.bounds = CGRectMake(0, 0, 25, 25);
    _indicatorView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    if (!_superView) {
        _superView = (UIScrollView *)[self superview];
        [_superView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [_superView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)startRefresh{}
- (void)endRefresh{}

- (void)setOnRefresh:(OnRefresh)onRefresh {
    _onRefresh = onRefresh;
}

//kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)loadAll {
    _refreshingType = RefreshHeaderStateAll;
    [self setHidden:YES];
}


//animation
- (void)startAnim {
    [_indicatorView startLoading];
}

- (void)stopAnim {
    [_indicatorView stopLoading];
}

- (void)dealloc {
    [_superView removeObserver:self forKeyPath:@"contentOffset"];
    [_superView removeObserver:self forKeyPath:@"contentSize"];
}

@end
