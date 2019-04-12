//
//  ZMWaveLoadingView.h
//  XGChat
//
//  Created by beepay on 2019/4/12.
//  Copyright © 2019 XG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMWaveLoadingView : UIView

+ (instancetype)loadingView;

- (void)startLoading;

- (void)stopLoading;


@end

NS_ASSUME_NONNULL_END
