//
//  ZMRefreshControl.h
//  XGChat
//
//  Created by beepay on 2019/4/11.
//  Copyright © 2019 XG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMWaveLoadingView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSUInteger,RefreshingType) {
    RefreshHeaderStateIdle,
    RefreshHeaderStatePulling,
    RefreshHeaderStateRefreshing,
    RefreshHeaderStateAll
};

typedef void (^OnRefresh)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ZMRefreshControl : UIControl

@property (nonatomic, strong) UIScrollView      *superView;
//@property (nonatomic, strong) UIImageView       *indicatorView;
@property (nonatomic, strong) OnRefresh         onRefresh;
@property (nonatomic, assign) RefreshingType    refreshingType;
@property (nonatomic, strong)ZMWaveLoadingView *indicatorView;

- (void)setOnRefresh:(OnRefresh)onRefresh;
- (void)startRefresh;
- (void)endRefresh;
- (void)loadAll;


-(void)startAnim;
-(void)stopAnim;

@end

NS_ASSUME_NONNULL_END
