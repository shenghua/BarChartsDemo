//
//  ViewController.m
//  ImportChartsDemo
//
//  Created by Lun.X on 2016/12/7.
//  Copyright © 2016年 Lun.X. All rights reserved.
//

#import "ViewController.h"
#import "ImportChartsDemo-Bridging-Header.h"
#import "IMPBarChartView.h"

@interface ViewController () <IMPBarChartViewDelegate>

//@property (nonatomic, strong) BarChartView *chartView;

@property (nonatomic, strong) IMPBarChartView *barChartView;

@property (nonatomic, strong) UIButton *v3_button;

@property (nonatomic, strong) UIButton *v5_button;

@property (nonatomic, strong) UIButton *ta_button;

@property (nonatomic, assign) BOOL showV3;

@property (nonatomic, assign) BOOL showV5;

@property (nonatomic, assign) BOOL showTa;

//@property (nonatomic, strong) UIImageView *cicleImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.showV3 = YES;
    self.showV5 = NO;
    self.showTa = YES;
    
    self.barChartView = [[IMPBarChartView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 320)];
    self.barChartView.delegate = self;
    [self.view addSubview:_barChartView];
    
    [self createTestButton];
    [self updateChartData];
}


- (void)createTestButton
{
    self.v3_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 45, 25, 15)];
    //    [self.v3_button setBackgroundColor:[UIColor colorWithRed:36/255.0 green:159/255.0 blue:251/255.0 alpha:1.0]];
    [self.v3_button setTag:100];
    [self.v3_button addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v3_button];
    
    self.v5_button = [[UIButton alloc] initWithFrame:CGRectMake(40, 45, 25, 15)];
    //    [self.v5_button setBackgroundColor:[UIColor colorWithRed:205/255.0 green:113/255.0 blue:227/255.0 alpha:1.0]];
    [self.v5_button setTag:101];
    [self.v5_button addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v5_button];
    
    self.ta_button = [[UIButton alloc] initWithFrame:CGRectMake(70, 45, 25, 15)];
    //    [self.ta_button setBackgroundColor:[UIColor colorWithRed:32/255.0 green:227/255.0 blue:172/255.0 alpha:1.0]];
    [self.ta_button setTag:102];
    [self.ta_button addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ta_button];
    
    [self changeTestButtonBackgroundColor];
    
}


- (void)testButtonClicked:(id)sender
{
    NSInteger tagId = [sender tag];
    if (tagId  == 100){
        self.showV3 = self.showV3?NO:YES;
    }else if (tagId == 101){
        self.showV5 = self.showV5?NO:YES;
    }else if (tagId == 102){
        self.showTa = self.showTa?NO:YES;
    }
    
    [self changeTestButtonBackgroundColor];
    
    [self updateChartData];
}

- (void)changeTestButtonBackgroundColor
{
    if (self.showV3){
        [self.v3_button setBackgroundColor:[UIColor colorWithRed:36/255.0 green:159/255.0 blue:251/255.0 alpha:1.0]];
    }else if (!self.showV3){
        [self.v3_button setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    }
    
    if (self.showV5){
        [self.v5_button setBackgroundColor:[UIColor colorWithRed:205/255.0 green:113/255.0 blue:227/255.0 alpha:1.0]];
    }else if (!self.showV5){
        [self.v5_button setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    }
    
    if (self.showTa){
        [self.ta_button setBackgroundColor:[UIColor colorWithRed:32/255.0 green:227/255.0 blue:172/255.0 alpha:1.0]];
    }else if (!self.showTa){
        [self.ta_button setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    }
}

- (void)updateChartData
{

//    NSDictionary *resultBean = [NSDictionary dictionary];
    
//    [self handleChartViewWithData:resultBean];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:1 yValues:@[@(0.1), @(0.2), @(0.3)]]];
    
    for (int i = 2; i < 30; i++)
    {
        
//        double mult = (30 + 1);
//        double val1 = 0,val2 = 0,val3 = 0;
//        NSArray *values = [NSArray array];
//        
//        if (self.showV3)    val1 = (double) ((mult) + mult / 3);
//        if (self.showV5){
//            if (i%3==0)
//                val2 = (double) ((mult) + mult / 3);
//        }
//        
//        if (self.showTa)    val3 = (double) ((mult) + mult / 3);
//        
//        
//        if (val1 == 0 &&  val2 == 0 && val3 == 0){
//            
//        }else {
//            values = @[@(val1), @(val2),@(val3)];//
//        }
//        
//        if (i == 10)
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(0.00), @(0.00), @(0.00)]]];
//        else
//            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:values]];
    }
    
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:30 yValues:@[@(0.500), @(0.25), @(0.5)]]];
    
    self.barChartView.defaultHighlightIndex = 1;
    self.barChartView.chartViewDataSource = yVals;
    self.barChartView.barColors = @[[UIColor redColor], [UIColor greenColor], [UIColor orangeColor]];
    [self.barChartView refreshBarChartView];
}


//- (void)handleChartViewWithData:(NSDictionary *)dic
//{
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    
//    NSArray *dailyActivate = [dic objectForKey:@""];
//    for (int i = 1; i < 30; i++)
//    {
//        
//        double mult = (30 + 1);
//        double val1 = 0,val2 = 0,val3 = 0;
//        NSArray *values = [NSArray array];
//        
//        if (self.showV3)    val1 = (double) ((mult) + mult / 3);
//        if (self.showV5){
//            if (i%3==0)
//                val2 = (double) ((mult) + mult / 3);
//        }
//        
//        if (self.showTa)    val3 = (double) ((mult) + mult / 3);
//        
//        
//        if (val1 == 0 &&  val2 == 0 && val3 == 0){
//            
//        }else {
//            values = @[@(val1), @(val2),@(val3)];//
//        }
//        
//        if (i == 10)
//            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(0.00), @(0.00), @(0.00)]]];
//        else
//            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:values]];
//    }
//
////    [yVals addObject:[[BarChartDataEntry alloc] initWithX:1 yValues:@[@8, @12, @16]]];
////    [yVals addObject:[[BarChartDataEntry alloc] initWithX:2 yValues:@[@20, @50, @80]]];
//    
//    BarChartDataSet *set1 = nil;
//    if (_chartView.data.dataSetCount > 0)
//    {
//        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
//        set1.values = yVals;
//        [_chartView.data notifyDataChanged];
//        [_chartView notifyDataSetChanged];
//    }
//    else
//    {
//        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
//        set1.colors = @[ChartColorTemplates.material[0], ChartColorTemplates.material[1],ChartColorTemplates.material[2]];//,
//        //        set1.stackLabels = @[@"Births", @"Divorces", @"Marriages"];
//        set1.barBorderWidth = 0.5;
//        set1.barBorderColor = [UIColor whiteColor];
//        
//        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//        [dataSets addObject:set1];
//        
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        formatter.maximumFractionDigits = 1;
//        formatter.negativeSuffix = @" $";
//        formatter.positiveSuffix = @" $";
//        
//        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
//        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
//        [data setValueTextColor:UIColor.whiteColor];
//        [data setDrawValues:NO];
//        
//        _chartView.fitBars = YES;
//        _chartView.data = data;
//    }
//}
//
//#pragma mark - ChartViewDelegate
//- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
//{
////    CGPoint point = [_chartView getMarkerPositionWithHighlight:highlight];
//    
//    [self.cicleImageView removeFromSuperview];
//    self.cicleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleNormal"]];
//    self.cicleImageView.frame = CGRectMake(highlight.xPx - 55 / 2 + self.chartView.frame.origin.x, highlight.yPx - 55 / 2 + self.chartView.frame.origin.y, 55, 55);
////    [self.cicleImageView sizeToFit];
//    
//    [self.view addSubview:self.cicleImageView];
//    NSLog(@"chartValueSelected, stack-index %ld", (long)highlight.stackIndex);
//    NSLog(@"xPx: %.2f; yPx: %.2f", highlight.xPx, highlight.yPx);
//}
//
//- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry1:(ChartDataEntry * __nonnull)entry1 highlight1:(ChartHighlight * __nonnull)highlight1 entry2:(ChartDataEntry * _Nonnull)entry2 highlight2:(ChartHighlight * _Nonnull)highlight2
//{
////    CGPoint point = [_chartView getMarkerPositionWithHighlight:highlight1];
//    
//    [self.cicleImageView removeFromSuperview];
//    self.cicleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleNormal"]];
//    self.cicleImageView.frame = CGRectMake(highlight1.xPx - 55 / 2 + self.chartView.frame.origin.x, highlight1.yPx - 55 / 2 + self.chartView.frame.origin.y, 55, 55);
//    //    [self.cicleImageView sizeToFit];
//    
//    [self.view addSubview:self.cicleImageView];
////    NSLog(@"chartValueSelected, stack-index %ld", (long)highlight.stackIndex);
////    NSLog(@"xPx: %.2f; yPx: %.2f", highlight.xPx, highlight.yPx);
//}
//
//- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
//{
//    [self.cicleImageView removeFromSuperview];
//    NSLog(@"chartValueNothingSelected");
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <IMPBarChartViewDelegate>
- (void)highlightIndex:(int)index
{
    NSString *tips = @"2016/11/21 \n每日激活总数：80 \n瑞钱包：20 瑞钱包-V5：40 TA卡：2000000000001 \nasdfasdf";
    [self.barChartView showSingleTouchTips:tips lines:4];
}

- (void)highlightIndex1:(int)index1 index2:(int)index2
{
    NSString *tips = @"2016/11/21 - 2016/11/22 \n每日激活总数：80 \n瑞钱包：20 瑞钱包-V5：40 TA卡：2023232323 \nwfsdfs";
    [self.barChartView showMultiTouchTips:tips lines:4];
}

- (void)touchEnd:(int)index
{
    
}

@end
