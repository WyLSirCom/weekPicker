//
//  ITDatePicketView.m
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import "ITDatePicketView.h"
#import "ITPickerHeaderView.h"
#import "NSDate+IT.h"

@interface ITDatePicketView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *componentView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) ITPickerHeaderView *headerView;
@property (nonatomic, strong) NSArray *dayArr;
@property (nonatomic, strong) NSArray *hourArr;
@property (nonatomic, strong) NSArray *minuteArr;

@end

@implementation ITDatePicketView

+(ITDatePicketView *)showDatePickerView {
    ITDatePicketView *view = [[ITDatePicketView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:38/255.0f green:34/255.0f blue:23/255.0f alpha:0.3];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dayArr];
        [self hourArr];
        [self minuteArr];
        [self setupViews];
        [self initDefaultValue];
        [self initTapGes];
    }
    return self;
}

-(void)layoutSubviews {
    self.componentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 244);
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    self.pickerView.frame = CGRectMake(0, 44, self.frame.size.width, 200);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect Fr = self.componentView.frame;
        Fr.origin.y = self.frame.size.height - 244;
        self.componentView.frame = Fr;
    }];
}

-(void)initTapGes {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

-(void)initDefaultValue {
    self.selectDate = [NSDate date];
    self.leftBtnTitle = @"取消";
    self.rightBtnTitle = @"确定";
    self.title = @"";
}

-(NSDate *)currentDate {
    NSString *year_week = [self.dayArr objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    NSString *hour = [self.hourArr objectAtIndex:[self.pickerView selectedRowInComponent:1]];
    NSString *minute = [self.minuteArr objectAtIndex:[self.pickerView selectedRowInComponent:2]];
    NSString *year = [year_week componentsSeparatedByString:@"_"].firstObject;
    NSString *dateStr = [NSString stringWithFormat:@"%@%@%@",year,hour,minute];
    NSDate *result = [NSDate convertStrToDate:dateStr];
    return result;
}
#pragma mark - action
-(void)tapAction {
    [self removeFromSuperview];
}
#pragma mark - setter
-(void)setSelectDate:(NSDate *)selectDate {
    NSString *date = [selectDate convertDateToStr];
    __block NSUInteger dateIndex = 0;
    [self.dayArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:date]) {
            dateIndex = idx;
            *stop = YES;
        }
    }];
    
    // 可以直接作为数组索引
    NSInteger hour = [selectDate ex_hour];
    // 可以直接作为数组索引
    NSInteger minute = [selectDate ex_minute];
    
    [self.pickerView selectRow:dateIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:(hour > 23 ? 0 : hour) inComponent:1 animated:YES];
    [self.pickerView selectRow:(minute > 59 ? 0 : minute) inComponent:2 animated:YES];
    
}
-(void)setLeftBtnTitle:(NSString *)leftBtnTitle {
    _leftBtnTitle = leftBtnTitle;
    self.headerView.leftBtnTitle = leftBtnTitle;
}
-(void)setRightBtnTitle:(NSString *)rightBtnTitle {
    _rightBtnTitle = rightBtnTitle;
    self.headerView.rightBtnTitle = rightBtnTitle;
}
-(void)setTitle:(NSString *)title {
    _title = title;
    self.headerView.title = title;
}
#pragma mark - UIPickerViewDataSource
// 1.设置 pickerView 的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// 2.设置 pickerView 每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dayArr.count;
    } else if (component == 1) {
        return self.hourArr.count;
    } else if (component == 2) {
        return self.minuteArr.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
// 3. 设置 pickerView 的显示内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    // 1.自定义 row 的内容视图
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
//        label.font = self.pickerStyle.pickerTextFont;
//        label.textColor = self.pickerStyle.pickerTextColor;
        // 字体自适应属性
        label.adjustsFontSizeToFitWidth = YES;
        // 自适应最小字体缩放比例
        label.minimumScaleFactor = 0.5f;
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleString = @"";
    if (component == 0) {
        NSString *year_week = self.dayArr[row];
        NSArray *year_week_arr = [year_week componentsSeparatedByString:@"_"];
        NSString *year = year_week_arr.firstObject;
        NSString *week = year_week_arr.lastObject;
        NSString *day = [year substringFromIndex:5];
        titleString = [NSString stringWithFormat:@"%@ %@",day,week];
    } else if (component == 1) {
        titleString = self.hourArr[row];
    } else if (component == 2) {
        titleString = self.minuteArr[row];
    }
    return titleString;
}

// 4.滚动 pickerView 执行的回调方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

// 设置行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0;
}

#pragma mark - UI
-(void)setupViews {
    [self addSubview:self.componentView];
    [self.componentView addSubview:self.headerView];
    [self.componentView addSubview:self.pickerView];
}

-(UIView *)componentView {
    if (!_componentView) {
        _componentView = [[UIView alloc] init];
        _componentView.backgroundColor = [UIColor whiteColor];
    }
    return _componentView;
}

-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

-(ITPickerHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ITPickerHeaderView alloc] init];
        __weak typeof(self) weakself = self;
        _headerView.leftBtnClickBlock = ^{
            if (weakself.leftBtnClickBlock) {
                weakself.leftBtnClickBlock([weakself currentDate]);
            }
            [weakself tapAction];
        };
        _headerView.rightBtnClickBlock = ^{
            if (weakself.rightBtnClickBlock) {
                weakself.rightBtnClickBlock([weakself currentDate]);
            }
            [weakself tapAction];
        };
    }
    return _headerView;
}

-(NSArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSDate getDayArr];
    }
    return _dayArr;
}

-(NSArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSDate getHourArr];
    }
    return _hourArr;
}

-(NSArray *)minuteArr {
    if (!_minuteArr) {
        _minuteArr = [NSDate getMinuteArr];
    }
    return _minuteArr;
}
@end
