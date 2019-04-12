//
//  ZMRefreshHeaderControl.m
//  XGChat
//
//  Created by beepay on 2019/4/12.
//  Copyright © 2019 XG. All rights reserved.
//

#import "ZMRefreshHeaderControl.h"

@implementation ZMRefreshHeaderControl

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, -50, ScreenWidth, 50)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *superView = (UIScrollView *)[self superview];
        if(superView.isDragging && self.refreshingType == RefreshHeaderStateIdle && superView.contentOffset.y < -80) {
            self.refreshingType = RefreshHeaderStatePulling;
        }
        if(!superView.isDragging && self.refreshingType == RefreshHeaderStatePulling && superView.contentOffset.y >= -50) {
            [self startRefresh];
            if(self.onRefresh){
                self.onRefresh();
            }
        }
    }else if([keyPath isEqualToString:@"contentSize"]){
        
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)startRefresh {
    if(self.refreshingType != RefreshHeaderStateRefreshing) {
        self.refreshingType = RefreshHeaderStateRefreshing;
        UIScrollView *superView = (UIScrollView *)[self superview];
        UIEdgeInsets edgeInsets = superView.contentInset;
        edgeInsets.top += 50;
        [UIView animateWithDuration:0.2 animations:^{
            superView.contentInset = edgeInsets;
        }];
        [self startAnim];
        if(self.onRefresh){
            self.onRefresh();
        }
    }
}

- (void)endRefresh {
    if(self.refreshingType != RefreshHeaderStateIdle) {
        self.refreshingType = RefreshHeaderStateIdle;
        
        UIScrollView *superView = (UIScrollView *)[self superview];
        UIEdgeInsets edgeInsets = superView.contentInset;
        edgeInsets.top -= 50;
        [UIView animateWithDuration:0.2 animations:^{
            superView.contentInset = edgeInsets;
        }];
        [self stopAnim];
    }
}


@end
