//
//  ReplayCell.m
//  jianren
//
//  Created by xxx on 2018/7/3.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import "ReplayCell.h"
#import "Masonry.h"
@implementation ReplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _replayLabel = [[UILabel alloc]init];
        _replayLabel.numberOfLines = 0;
        _replayLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_replayLabel];
        [_replayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
