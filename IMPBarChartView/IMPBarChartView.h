//
//  IMPLineChart.h
//  IMPLineChart
//
//  Created by user on 2016/12/19.
//  Copyright © 2016年 imobpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportChartsDemo-Bridging-Header.h"

@protocol IMPBarChartViewDelegate

/**
 * 单个点选中
 */
- (void)highlightIndex:(int)index;

/**
 * 两个点选中
 */
- (void)highlightIndex1:(int)index1 index2:(int)index2;

/**
 * 两个点同时离开
 */
- (void)touchEnd:(int)index;

@end

@interface IMPBarChartView : UIView

// 柱状图
@property (nonatomic, strong)  BarChartView *barChartView;

//显示单位的标签
@property (nonatomic, strong)  UILabel *infoLabel;

//柱状图数据源
@property (nonatomic, strong) NSMutableArray *chartViewDataSource;

//柱状图颜色数组
@property (nonatomic, strong) NSArray *barColors;

// 默认选中
@property (nonatomic, assign) int defaultHighlightIndex;

// 代理
@property (nonatomic, assign) id<IMPBarChartViewDelegate> delegate;

// 刷新柱状图数据
- (void)refreshBarChartView;

// 显示Tips - 单个选中
- (void)showSingleTouchTips:(NSString *)tips lines:(int)numberOfLines;

// 显示Tips - 两个个选中
- (void)showMultiTouchTips:(NSString *)tips lines:(int)numberOfLines;
@end
