//
//  ITPickerHeaderView.h
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITPickerHeaderView : UIView

/// 左侧按钮标题 默认 取消
@property (nonatomic, strong) NSString *leftBtnTitle;
/// 右侧按钮标题 默认 确定
@property (nonatomic, strong) NSString *rightBtnTitle;
/// 中间显示的 title 默认为空
@property (nonatomic, strong) NSString *title;

/// 左侧按钮点击事件
@property (nonatomic, copy) void(^leftBtnClickBlock)(void);
/// 右侧按钮点击事件
@property (nonatomic, copy) void(^rightBtnClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
