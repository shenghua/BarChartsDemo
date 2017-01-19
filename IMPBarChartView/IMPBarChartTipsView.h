//
//  IMPBarChartTipsView.h
//  ImportChartsDemo
//
//  Created by 王胜华 on 03/01/2017.
//  Copyright © 2017 Lun.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMPBarChartTipsView : UIView

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *circleImageView1;
@property (nonatomic, strong) UIImageView *circleImageView2;

@property (nonatomic, strong) UIImageView *lineImageView1;

/**
 * 显示选中圆圈
 */
- (void)showCircleView1:(CGPoint)point;

/**
 * 显示选中圆圈
 */
- (void)showCircleView2:(CGPoint)point;

/**
 * 隐藏选中圆圈
 */
- (void)hideCircleView1;

/**
 * 隐藏选中圆圈
 */
- (void)hideCircleView2;

/**
 * 未选中
 */
- (void)nothingSelected;

/**
 * 单指选中，显示相关提示
 */
- (void)showSingleTouchTips:(NSString *)tips lines:(int)numberOfLines;

/**
 * 两个手指选中，显示相关提示
 */
- (void)showMultiTouchTips:(NSString *)tips lines:(int)numberOfLines;

/**
 * 单指离开屏幕，显示normal竖线，提示小消失
 */
- (void)showNormalLine;
@end
