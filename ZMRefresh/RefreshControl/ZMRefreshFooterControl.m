//
//  ZMRefreshFooterControl.m
//  XGChat
//
//  Created by beepay on 2019/4/12.
//  Copyright © 2019 XG. All rights reserved.
//

#import "ZMRefreshFooterControl.h"

@implementation ZMRefreshFooterControl

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 50)];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *superView = (UIScrollView *)[self superview];
        CGFloat off_y = 0;
        if(CGRectGetHeight(superView.frame) - superView.contentSize.height > 0){
            off_y = superView.contentOffset.y;
        }
        else{
            off_y = superView.contentOffset.y + CGRectGetHeight(superView.frame) - superView.contentSize.height ;
        }
        if(superView.isDragging && self.refreshingType == RefreshHeaderStateIdle && off_y > 80) {
            self.refreshingType = RefreshHeaderStatePulling;
        }
        if(!superView.isDragging && self.refreshingType == RefreshHeaderStatePulling && off_y >= 50) {
            [self startRefresh];
            if(self.onRefresh){
               self.onRefresh();
            }
        }
    } else if([keyPath isEqualToString:@"contentSize"]){
        UIScrollView *superView = (UIScrollView *)[self superview];
        self.frame = CGRectMake(0,superView.contentSize.height , CGRectGetWidth(self.frame) , CGRectGetHeight(self.frame));
    }else{
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

- (void)startRefresh {
    if(self.refreshingType != RefreshHeaderStateRefreshing) {
        self.refreshingType = RefreshHeaderStateRefreshing;
        UIScrollView *superView = (UIScrollView *)[self superview];
        UIEdgeInsets edgeInsets = superView.contentInset;
        edgeInsets.bottom += 50;
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
        edgeInsets.bottom -= 50;
        [UIView animateWithDuration:0.2 animations:^{
            superView.contentInset = edgeInsets;
        }];
        [self stopAnim];
    }
}

@end
