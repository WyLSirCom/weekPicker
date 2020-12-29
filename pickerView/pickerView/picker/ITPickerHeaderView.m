//
//  ITPickerHeaderView.m
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import "ITPickerHeaderView.h"

@interface ITPickerHeaderView()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ITPickerHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)layoutSubviews {
    [self.leftBtn sizeToFit];
    CGRect leftFrame = self.leftBtn.frame;
    leftFrame.origin.x = 20;
    leftFrame.origin.y = (self.bounds.size.height - leftFrame.size.height) / 2;
    self.leftBtn.frame = leftFrame;
    
    [self.rightBtn sizeToFit];
    CGRect rightFrame = self.rightBtn.frame;
    rightFrame.origin.x = self.bounds.size.width - 20 - rightFrame.size.width;
    rightFrame.origin.y = (self.bounds.size.height - rightFrame.size.height) / 2;
    self.rightBtn.frame = rightFrame;
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}
#pragma mark - setter
-(void)setLeftBtnTitle:(NSString *)leftBtnTitle {
    _leftBtnTitle = leftBtnTitle;
    [self.leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
}
-(void)setRightBtnTitle:(NSString *)rightBtnTitle {
    _rightBtnTitle = rightBtnTitle;
    [self.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
}
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
#pragma mark - action
-(void)leftBtnAction {
    if (self.leftBtnClickBlock) {
        self.leftBtnClickBlock();
    }
}
-(void)rightBtnAction {
    if (self.rightBtnClickBlock) {
        self.rightBtnClickBlock();
    }
}
#pragma mark - UI
-(void)setupViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.lineView];
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"开始时间";
    }
    return _titleLabel;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}
@end
