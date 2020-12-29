//
//  ITDatePicketView.h
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITDatePicketView : UIView

/// 选中日期  默认今天
@property (nonatomic, strong) NSDate *selectDate;
/// 左侧按钮标题 默认 取消
@property (nonatomic, strong) NSString *leftBtnTitle;
/// 右侧按钮标题 默认 确定
@property (nonatomic, strong) NSString *rightBtnTitle;
/// 中间显示的 title 默认为空
@property (nonatomic, strong) NSString *title;
/// 左侧按钮点击事件
@property (nonatomic, copy) void(^leftBtnClickBlock)(NSDate *date);
/// 右侧按钮点击事件
@property (nonatomic, copy) void(^rightBtnClickBlock)(NSDate *date);

+(ITDatePicketView *)showDatePickerView;

@end

NS_ASSUME_NONNULL_END
