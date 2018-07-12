//
//  CommentView.m
//  jianren
//
//  Created by xxx on 2018/7/4.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import "CommentView.h"
#import "Masonry.h"

@implementation CommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if ( self) {
        self.backgroundColor = [UIColor whiteColor];
        _inputView = [[UITextView alloc]init];
        [self addSubview:_inputView];
        _inputView.layer.cornerRadius = 4.0;
        _inputView.clipsToBounds = YES;
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(5);
            make.bottom.right.mas_equalTo(-5);
        }];
    }
    return  self;
}
@end
