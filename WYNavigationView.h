//
//  WYNavigationView.h
//  My
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WYNavigationViewDelegate <NSObject>
@optional
- (void)navLeftBtnAction:(id)sender;//导航左按钮
- (void)navRightBtnAction:(id)sender;//导航右按钮
- (void)elseBtnAction:(UIButton *)button;
@end

@interface WYNavigationView : UIView
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UILabel *titlelab;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *elseBtn;
@property(nonatomic,strong)UIVisualEffectView *effectview;
@property(nonatomic,strong)UIActivityIndicatorView * activity;//活动指示轮
@property(nonatomic,strong)NSMutableArray *elsArray;//存放elseBtn数组
@property(nonatomic,strong)UIView *lineView;//绿色线

@property(nonatomic,strong)UIView *line;//灰色底线
@property(nonatomic,strong)UIView *dr1;

@property (nonatomic, weak) id <WYNavigationViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)atitle leftbtnimg:(NSString *)aimg leftTitle:(NSString *)aleftTitle rightbtnimg:(NSString *)aRightimg rightTitle:(NSString *)arightTitle elsAryText:(NSArray *)array;
- (void)elseBtnAction:(UIButton *)button;
- (void)moveTo:(NSInteger)movelenth;

- (void)changeTitleFrame:(NSString *)title;


@end
