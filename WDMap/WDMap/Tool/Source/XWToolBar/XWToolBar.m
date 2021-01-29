//
//  WDToolBar.m
//  NetClass
//
//  Created by wbb on 2020/3/10.
//  Copyright © 2020 WD. All rights reserved.
//

#import "WDToolBar.h"
#import "NSString+WDExtension.h"

@interface WDToolBar ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *placeholderLab;

@property (nonatomic,copy) NSString *textStr;
@end

@implementation WDToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self addTarget:self action:@selector(ednEditing)];
    }
    return self;
}
- (void)ednEditing {
    [self endEditing:YES];
}
- (void)initUI {
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = main_background_color;
    [self addSubview:backView];
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(50);
    }];
    
    UIButton *btn = [UIButton buttonWithTitle:@"发送" titleColor:hexColor(555555) font:[UIFont systemFontOfSize:15] imageName:@"class_send_image" target:self action:@selector(sendClick)];
    kAppViewCorner(btn, 5);
    btn.backgroundColor = hexColor(DDDDDD);
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.right.equalTo(self.mas_safeAreaLayoutGuideRight).offset(-10);
        } else {
            // Fallback on earlier versions
            make.right.mas_offset(-10);
        }
        make.bottom.mas_offset(-10);
        make.height.mas_offset(31);
        make.width.mas_offset(79);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    kAppViewCorner(textView, 5);
    textView.font = [UIFont systemFontOfSize:15];
    [backView addSubview:textView];
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.mas_safeAreaLayoutGuideLeft).offset(10);
        } else {
            // Fallback on earlier versions
            make.left.mas_offset(10);
        }
        make.bottom.mas_offset(-10);
        make.right.equalTo(btn.mas_left).offset(-10);
        make.top.mas_offset(10);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"请在此输入文字";
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = main_light_text_color;
    [textView addSubview:lab];
    self.placeholderLab = lab;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(textView.mas_centerY);
    }];
}
- (void)sendClick {
    [self endEditing:YES];
    
    if (self.sendMessageBlock) {
        self.sendMessageBlock(self.textStr);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.text = @"";
    self.placeholderLab.hidden = NO;

}
- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLab.hidden = YES;
    self.textStr = textView.text;
    float height = [NSString WD_autoHeightWithString:textView.text Width:textView.width Font:[UIFont systemFontOfSize:15]];
    if (height>31&&height<80) {
        NSLog(@"%F",height);
        if (self.viewHeightBlock) {
            self.viewHeightBlock(height + 20);
        }
    }
    
}
@end
