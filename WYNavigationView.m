//
//  WYNavigationView.m
//  My
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WYNavigationView.h"
#import "Config.h"

@implementation WYNavigationView
{
    UIButton *oldButton;
    NSArray *btnAry;
}

- (void)dealloc{
    _leftBtn = nil;
    _titlelab = nil;
    _rightBtn = nil;
    _activity = nil;
    _lineView = nil;
    _line = nil;
    _elseBtn = nil;
    _elsArray = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)atitle leftbtnimg:(NSString *)aimg leftTitle:(NSString *)aleftTitle rightbtnimg:(NSString *)aRightimg rightTitle:(NSString *)arightTitle elsAryText:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        //IOS8系统以上的模糊效果
        if (IOS8) {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            _effectview.frame = self.bounds;
            [self addSubview:_effectview];
        }
        else{
            self.backgroundColor = HEXCOLOR(0x39B0DD);
        }
        
        
        _elsArray = [[NSMutableArray alloc] initWithCapacity:0];
        btnAry = [[NSArray alloc] initWithArray:array];
        
        _dr1 = [[UIView alloc] initWithFrame:self.bounds];
        _dr1.backgroundColor = HEXCOLOR(0x39B0DD);
        [self addSubview:_dr1];
        
        if (array.count>0 && array!=nil) {
            NSInteger count = array.count;
            for (int i = 0; i<count; i++) {
                _elseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0+IPHONE_WIDTH/count*i, (self.bounds.size.height-36)+1, IPHONE_WIDTH/count, 36-2)];
                [_elseBtn setTitle:array[i] forState:UIControlStateNormal];
                [_elseBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
                [_elseBtn setTitleColor:HEXCOLOR(0x39B0DD) forState:UIControlStateSelected];
                _elseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                _elseBtn.tag = 776611+i;
                //                _elseBtn.backgroundColor = OrangeColor;
                [_elseBtn addTarget:_delegate action:@selector(elseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                if (i==0) {
                    _elseBtn.selected = YES;
                    //                    _elseBtn.userInteractionEnabled = NO;
                    oldButton = _elseBtn;
                }
                [_dr1 addSubview:_elseBtn];
                [_elsArray addObject:_elseBtn];
            }
            for (int j = 0; j<count-1; j++) {
                UIView *vertical_line = [[UIView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH/count+IPHONE_WIDTH/count*j, self.bounds.size.height-36+36/2-16/2, 0.5, 16)];
                vertical_line.backgroundColor = HEXCOLORAL(0x000000, 0.2);
                [_dr1 addSubview:vertical_line];
            }
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH/count/2-64/2, self.bounds.size.height-2, 64, 2)];
            _lineView.backgroundColor = HEXCOLOR(0x39B0DD);
            [_dr1 addSubview:_lineView];
        }
        
        //底线
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-0.5, IPHONE_WIDTH, 0.5)];
        _line.backgroundColor = HEXCOLORAL(0x000000, 0.1);
        [self addSubview:_line];
        
        //设置阴影的偏移量
        [self.layer setShadowOffset:CGSizeMake(0, 1)];
        //设置阴影的不透明度(默认是是全透明，所以这一句必须要设置，不然看不到)
        [self.layer setShadowOpacity:0.3];
        //设置阴影模糊度blur
        [self.layer setShadowRadius:2];
        //设置阴影的颜色
        [self.layer setShadowColor:HEXCOLORAL(0x000000, 0.3).CGColor];
        
        //导航左按钮
        if ([aleftTitle length]!=0 || aimg.length!=0) {
            _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(24, 20+2, 50, 40)];
            _leftBtn.tag = 667700;
            if ([aimg length]!=0) {
                [_leftBtn setImage:[UIImage imageNamed:aimg] forState:UIControlStateNormal];
                _leftBtn.frame = CGRectMake(0, 20+2, 65, 40);
                [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 9)];
            }
            if (aleftTitle.length!=0) {
                [_leftBtn setTitle:aleftTitle forState:0];
                
            }
            //            _leftBtn.backgroundColor = OrangeColor;
            [_leftBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
            [_leftBtn setTitleColor:HEXCOLORAL(0xFFFFFF, 0.5) forState:UIControlStateHighlighted];
            _leftBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_dr1 addSubview:_leftBtn];
        }
        
        //设置标题
        if ([atitle length]!=0) {
            _titlelab = [[UILabel alloc] initWithFrame:CGRectMake(70, 20+7, IPHONE_WIDTH-140, 30)];
            _titlelab.tag = 667711;
            _titlelab.font = [UIFont boldSystemFontOfSize:18.0f];
            _titlelab.text = atitle;
            _titlelab.backgroundColor = NoColor;
            _titlelab.textColor = HEXCOLOR(0xFFFFFF);
            _titlelab.textAlignment = NSTextAlignmentCenter;
            [_dr1 addSubview:_titlelab];
            //            _titlelab.backgroundColor = CyankColor;
        }
        //需要计算titleL文字占的宽度
        CGSize ss;
        if ([atitle respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            CGRect rect = [atitle boundingRectWithSize:(CGSize){IPHONE_WIDTH-140, 30}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}
                                               context:nil];
            ss = rect.size;
            
        }
        _titlelab.frame = CGRectMake(70+(IPHONE_WIDTH-140-ss.width)/2, 20+7, ss.width, 30);
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_titlelab.frame)-25,20+44/2-20/2, 20, 20)];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_dr1 addSubview:_activity];
        
        //导航右按钮
        if (aRightimg.length!=0 || arightTitle.length!=0) {
            _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(IPHONE_WIDTH-65, 20+2, 60, 40)];
            _rightBtn.tag = 667722;
            if (aRightimg.length!=0) {
                [_rightBtn setImage:[UIImage imageNamed:aRightimg] forState:UIControlStateNormal];
                //                [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
            }
            if ([arightTitle length]!=0) {
                [_rightBtn setTitle:arightTitle forState:0];
                
            }
            _rightBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            [_rightBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
            [_rightBtn setTitleColor:HEXCOLORAL(0xFFFFFF, 0.5) forState:UIControlStateHighlighted];
            [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //            _rightBtn.backgroundColor = OrangeColor;
            [_dr1 addSubview:_rightBtn];
        }
        
    }
    
    return self;
}

- (void)changeTitleFrame:(NSString *)title{
    CGRect rect = [title boundingRectWithSize:(CGSize){IPHONE_WIDTH-140, 30}
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}
                                      context:nil];
    CGSize ss = rect.size;
    _titlelab.frame = CGRectMake(70+(IPHONE_WIDTH-140-ss.width)/2, 20+7, ss.width, 30);
    _activity.frame = CGRectMake(CGRectGetMinX(_titlelab.frame)-25,20+44/2-20/2, 20, 20);
}

- (void)elseBtnAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(elseBtnAction:)]) {
        [self.delegate elseBtnAction:button];
    }
    oldButton.selected = NO;
    oldButton = button;
    oldButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        @WeakObj(self);
        selfWeak.lineView.frame = CGRectMake(button.frame.origin.x+button.frame.size.width/2-64/2, self.bounds.size.height-2, 64, 2);
    }];
    //    [self moveTo:0];
}

- (void)moveTo:(NSInteger)movelenth{
    //    oldButton.selected = NO;
    //    oldButton.userInteractionEnabled = YES;
    //    oldButton = button;
    //    oldButton.selected = YES;
    //    oldButton.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        @WeakObj(self);
        selfWeak.lineView.frame = CGRectMake((IPHONE_WIDTH/btnAry.count-64)/2+movelenth, self.bounds.size.height-2, 64, 2);
    }];
}

- (void)leftBtnClick:(id)sender
{
    [self.delegate navLeftBtnAction:sender];
}

-(void)rightBtnClick:(id)sender
{
    [self.delegate navRightBtnAction:sender];
}


@end
