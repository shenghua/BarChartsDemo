//
//  IMPLineChart.m
//  IMPLineChart
//
//  Created by user on 2016/12/19.
//  Copyright © 2016年 imobpay. All rights reserved.
//

#import "IMPBarChartView.h"
#import "IMPBarChartTipsView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IMPBarChartView () <ChartViewDelegate>

@property (nonatomic, strong) IMPBarChartTipsView *tipsView;

@property (nonatomic, assign) BOOL isDefaultHighlight;

@end

@implementation IMPBarChartView

@synthesize barChartView, tipsView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    [self initBarChartView];
    
    self.tipsView = [[IMPBarChartTipsView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, CGRectGetWidth(self.bounds), 10)];
    [self addSubview:self.tipsView];
    
    self.isDefaultHighlight = NO;
    
    self.barColors = @[[UIColor redColor], [UIColor greenColor], [UIColor orangeColor]];;
}

- (void)initBarChartView
{
    self.barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame) - 226, CGRectGetWidth(self.frame) - 5 * 2, 226)];
    barChartView.multipleTouchEnabled=YES;
    barChartView.delegate = self;
    barChartView.chartDescription.enabled = NO;
    barChartView.maxVisibleCount = 40;
    barChartView.doubleTapToZoomEnabled = NO;
    barChartView.drawGridBackgroundEnabled = YES;
    barChartView.drawBarShadowEnabled = NO;
    barChartView.drawValueAboveBarEnabled = YES;
    barChartView.highlightFullBarEnabled = YES;
    barChartView.gridBackgroundColor = [UIColor clearColor];
    [self addSubview:barChartView];
    
    [barChartView animateWithYAxisDuration:1.0];
    
    
    ChartYAxis *leftAxis = barChartView.leftAxis;
    //    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    barChartView.rightAxis.enabled = NO;
    barChartView.leftAxis.enabled = YES;
    
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.avoidFirstLastClippingEnabled = YES;
}

- (void)refreshBarChartView
{
    BarChartDataSet *set1 = nil;
    if (barChartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)barChartView.data.dataSets[0];
        set1.values = self.chartViewDataSource;
        [barChartView.data notifyDataChanged];
        [barChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:self.chartViewDataSource label:@""];
        set1.colors = _barColors;//@[ChartColorTemplates.material[0], ChartColorTemplates.material[1],ChartColorTemplates.material[2]];
        set1.highlightColor = [UIColor clearColor];
        set1.barBorderWidth = 0.5;
        set1.barBorderColor = [UIColor whiteColor];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.maximumFractionDigits = 1;
        formatter.negativeSuffix = @" $";
        formatter.positiveSuffix = @" $";
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
        [data setValueTextColor:UIColor.whiteColor];
        [data setDrawValues:NO];
        
        barChartView.fitBars = YES;
        barChartView.data = data;
    }
    
    [self showDefaultHighlight];
}

- (void)showDefaultHighlight
{
    if (self.defaultHighlightIndex > 0) {
        self.isDefaultHighlight = YES;
        
        barChartView.isDefaultHighlight = self.isDefaultHighlight;
        [barChartView highlightValueWithX:_defaultHighlightIndex y:0 dataSetIndex:0 callDelegate:YES];
    } else {
        self.isDefaultHighlight = NO;
        barChartView.isDefaultHighlight = self.isDefaultHighlight;
    }
}

//- (void)handDefaultImage
//{
//    if (self.isDefaultHighlight) {
//        tipsView.circleImageView1.image = [UIImage imageNamed:@"circleNormal"];
//        tipsView.lineImageView1.image = [UIImage imageNamed:@"arrowlineNormal"];
//    } else {
//        tipsView.circleImageView1.image = [UIImage imageNamed:@"circleHighlight"];
//        tipsView.lineImageView1.image = [UIImage imageNamed:@"arrowlineHighlight"];
//    }
//}

#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    [tipsView hideCircleView1];
    [tipsView hideCircleView2];
    
    if (!isnan(highlight.xPx) && !isnan(highlight.yPx)) {
        [self showCircleView1WithX:highlight.xPx Y:highlight.yPx tag:highlight.x];
    } else if (!isnan(highlight.drawX) && !isnan(highlight.drawY)) {
        [self showCircleView1WithX:highlight.drawX Y:highlight.drawY tag:highlight.x];
    }
    
    [self.delegate highlightIndex:highlight.x];
}

- (void)chartDefaultValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    [self chartValueSelected:chartView entry:entry highlight:highlight];
    
    [self.tipsView showNormalLine];
}

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry1:(ChartDataEntry * __nonnull)entry1 highlight1:(ChartHighlight * __nonnull)highlight1 entry2:(ChartDataEntry * _Nonnull)entry2 highlight2:(ChartHighlight * _Nonnull)highlight2
{
    if (tipsView.circleImageView1.tag != highlight1.x) {
        [tipsView hideCircleView1];
        [self showCircleView1WithX:highlight1.xPx Y:highlight1.yPx tag:highlight1.x];
    }
    
    if (tipsView.circleImageView2.tag != highlight2.x) {
        [tipsView hideCircleView2];
        [self showCircleView2WithX:highlight2.xPx Y:highlight2.yPx tag:highlight2.x];
    }
    
    if (highlight1.x != highlight2.x)
        [self.delegate highlightIndex1:highlight1.x index2:highlight2.x];
    else {
        [tipsView hideCircleView2];
        [self.delegate highlightIndex:highlight1.x];
    }
}

- (void)showCircleView1WithX:(float)x Y:(float)y tag:(int)tag
{
    [tipsView showCircleView1:CGPointMake(
                                          x - CGRectGetWidth(tipsView.circleImageView1.frame) / 2 + self.barChartView.frame.origin.x,
                                          y - CGRectGetHeight(tipsView.circleImageView1.frame) / 2 + self.barChartView.frame.origin.y)];
    tipsView.circleImageView1.tag = tag;
}

- (void)showCircleView2WithX:(float)x Y:(float)y tag:(int)tag
{
    [tipsView showCircleView2:CGPointMake(
                                          x - CGRectGetWidth(tipsView.circleImageView2.frame) / 2 + self.barChartView.frame.origin.x,
                                          y - CGRectGetHeight(tipsView.circleImageView2.frame) / 2 + self.barChartView.frame.origin.y)];
    tipsView.circleImageView2.tag = tag;
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    [barChartView setNeedsDisplay];
    
    [tipsView showNormalLine];
    
    [self.delegate touchEnd:tipsView.circleImageView1.tag];
}

#pragma mark - Show Tips
// 显示Tips - 单个选中
- (void)showSingleTouchTips:(NSString *)tips lines:(int)numberOfLines
{
    [tipsView showSingleTouchTips:tips lines:numberOfLines];
}

- (void)showMultiTouchTips:(NSString *)tips lines:(int)numberOfLines
{
    [tipsView showMultiTouchTips:tips lines:numberOfLines];
}
@end
