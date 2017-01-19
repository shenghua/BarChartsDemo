//
//  IMPBarChartTipsView.m
//  ImportChartsDemo
//
//  Created by 王胜华 on 03/01/2017.
//  Copyright © 2017 Lun.X. All rights reserved.
//

#import "IMPBarChartTipsView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IMPBarChartTipsView()

@property (nonatomic, strong) UIImageView *lineImageView2;

@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation IMPBarChartTipsView

#pragma mark - View lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initViewsWithFrame:frame];
    }
    
    return self;
}

- (void)initViewsWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    self.lineView=[[UIView alloc] initWithFrame:CGRectMake(13, 0, CGRectGetWidth(frame)-26, 1)];
    self.lineView.backgroundColor = UIColorFromRGB(0xe16c47);
    [self addSubview:self.lineView];
    
    self.lineImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barChartArrowlineHighlight"]];
    _lineImageView1.contentMode = UIViewContentModeScaleAspectFit;
    CGRect lineImageFrame = _lineImageView1.frame;
    lineImageFrame.origin = CGPointMake(0, CGRectGetMaxY(_lineView.frame) - 1);
    lineImageFrame.size.height = 274;
    _lineImageView1.frame = lineImageFrame;

    self.lineImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barChartArrowlineHighlight"]];
    _lineImageView2.frame = _lineImageView1.frame;
    [self addSubview:self.lineImageView1];
    [self addSubview:self.lineImageView2];
    
    self.tipsView = [[UIView alloc] init];
    _tipsView.backgroundColor = UIColorFromRGB(0xe16c47);
    _tipsView.layer.cornerRadius = 6;
    [self addSubview:_tipsView];
    
    _lineImageView1.hidden = YES;
    _lineImageView2.hidden = YES;
    _tipsView.hidden = YES;
    
    self.circleImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barChartCircleHighlight"]];
    _circleImageView1.contentMode = UIViewContentModeScaleAspectFit;
    self.circleImageView1.tag = -1;
    self.circleImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barChartCircleHighlight"]];
    _circleImageView2.contentMode = UIViewContentModeScaleAspectFit;
    self.circleImageView2.tag = -2;
    _circleImageView1.hidden = YES;
    _circleImageView2.hidden = YES;
    [self addSubview:_circleImageView1];
    [self addSubview:_circleImageView2];
}

#pragma mark - Circle image handle
- (void)hideCircleView1
{
   // [UIView animateWithDuration:0.2 animations:^{
        self.circleImageView1.hidden = YES;
        self.circleImageView1.tag = -1;
        
        self.lineImageView1.hidden = YES;
    //}];
}

- (void)hideCircleView2
{
    //[UIView animateWithDuration:0.2 animations:^{
        self.circleImageView2.hidden = YES;
        self.circleImageView2.tag = -2;
        
        self.lineImageView2.hidden = YES;
    //}];
}

- (void)showCircleView1:(CGPoint)point
{
    self.circleImageView1.image = [UIImage imageNamed:@"barChartCircleHighlight"];
    
    CGRect frame = self.circleImageView1.frame;
    frame.origin = point;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.circleImageView1.frame = frame;
        self.circleImageView1.hidden = NO;
    }];
}

- (void)showCircleView2:(CGPoint)point
{
    self.circleImageView2.image = [UIImage imageNamed:@"barChartCircleHighlight"];
    
    CGRect frame = self.circleImageView2.frame;
    frame.origin = point;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.circleImageView2.frame = frame;
        self.circleImageView2.hidden = NO;
    }];
}

#pragma mark - Tips handle
- (void)showSingleTouchTips:(NSString *)tips lines:(int)numberOfLines
{
    self.lineView.backgroundColor = UIColorFromRGB(0xe16c47);
    
    self.lineImageView1.image = [UIImage imageNamed:@"barChartArrowlineHighlight"];

    [UIView animateWithDuration:0.2 animations:^{
        _lineImageView1.center = CGPointMake(_circleImageView1.center.x, _lineImageView1.center.y);
        _lineImageView1.hidden = NO;
    }];
    
    [self handleTipsLabelWithText:tips lines:numberOfLines];
    
    [UIView animateWithDuration:0.4 animations:^{
        _tipsView.frame = CGRectMake(0, 0, CGRectGetWidth(_tipsLabel.frame) + 10, CGRectGetHeight(_tipsLabel.frame) + 10);
        _tipsView.center = CGPointMake(_circleImageView1.center.x, _lineView.center.y + CGRectGetHeight(_tipsView.frame) / 2 + 15);
        
        [self handleTipsViewFrame];
        
        _tipsView.hidden = NO;
    }];
    
    _tipsLabel.center = CGPointMake(CGRectGetWidth(_tipsView.frame) / 2, CGRectGetHeight(_tipsView.frame) / 2);
}

- (void)showMultiTouchTips:(NSString *)tips lines:(int)numberOfLines
{
    self.lineView.backgroundColor = UIColorFromRGB(0xe16c47);
    
    self.lineImageView1.image = [UIImage imageNamed:@"barChartArrowlineHighlight"];

    self.lineImageView2.image = [UIImage imageNamed:@"barChartArrowlineHighlight"];

    [UIView animateWithDuration:0.2 animations:^{
        _lineImageView1.center = CGPointMake(_circleImageView1.center.x, _lineImageView1.center.y);
        _lineImageView1.hidden = NO;
        
        _lineImageView2.center = CGPointMake(_circleImageView2.center.x, _lineImageView2.center.y);
        _lineImageView2.hidden = NO;
    }];
    
    [self handleTipsLabelWithText:tips lines:numberOfLines];
    
    [UIView animateWithDuration:0.4 animations:^{
        _tipsView.frame = CGRectMake(0, 0, CGRectGetWidth(_tipsLabel.frame) + 10, CGRectGetHeight(_tipsLabel.frame) + 10);
        _tipsView.center = CGPointMake((_circleImageView1.center.x < _circleImageView2.center.x ? _circleImageView1.center.x : _circleImageView2.center.x) + (fabs(_circleImageView1.center.x - _circleImageView2.center.x)) / 2.0, _lineView.center.y + CGRectGetHeight(_tipsView.frame) / 2 + 15);
        
        [self handleTipsViewFrame];
        
        _tipsView.hidden = NO;
    }];
    
    _tipsLabel.center = CGPointMake(CGRectGetWidth(_tipsView.frame) / 2, CGRectGetHeight(_tipsView.frame) / 2);
}

- (void)handleTipsLabelWithText:(NSString *)text lines:(int)numberOfLines
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    [_tipsLabel removeFromSuperview];
    self.tipsLabel = [[UILabel alloc] init];
    _tipsLabel.attributedText = attributedString;
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.font = [UIFont systemFontOfSize:10.0];
    _tipsLabel.numberOfLines = numberOfLines;
    _tipsLabel.textColor = [UIColor whiteColor];
    [_tipsLabel sizeToFit];
    
    [_tipsView addSubview:_tipsLabel];
}

- (void)handleTipsViewFrame
{
    CGRect frame = _tipsView.frame;
    if ((frame.origin.x + frame.size.width) > self.frame.size.width)
        frame.origin.x = self.frame.size.width - frame.size.width;
    
    if (frame.origin.x < 0)
        frame.origin.x = 0;
    
    _tipsView.frame = frame;
}

#pragma mark -Touch end
- (void)nothingSelected
{
    [self hideCircleView1];
    [self hideCircleView2];
    
    _tipsView.hidden = YES;
    _lineImageView1.hidden = YES;
    _lineImageView2.hidden = YES;
}

- (void)showNormalLine
{
    [UIView animateWithDuration:0.2 animations:^{
        _tipsView.hidden = YES;
        
        self.lineImageView1.image = [UIImage imageNamed:@"barChartArrowlineNormal"];
        self.lineImageView2.image = [UIImage imageNamed:@"barChartArrowlineNormal"];
        
        self.circleImageView1.image = [UIImage imageNamed:@"barChartCircleNormal"];
        
        self.lineView.backgroundColor = UIColorFromRGB(0xececec);
        
        // 两手指同时离开的情况
        if (self.lineImageView1.hidden == self.lineImageView2.hidden) {
            [self hideCircleView2];
        }
    }];
}
@end
