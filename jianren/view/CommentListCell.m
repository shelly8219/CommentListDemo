//
//  CommentListCell.m
//  jianren
//
//  Created by xxx on 2018/7/3.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import "CommentListCell.h"
#import "Masonry.h"
#import "ReplayCell.h"
@implementation CommentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_headButton];
        [_headButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(12);
            make.width.height.mas_equalTo(40);
        }];
        _headButton.layer.cornerRadius = 20;
        _headButton.clipsToBounds = YES;
        _headButton.backgroundColor = [UIColor redColor];
        
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nameButton];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_nameButton setTitle:@"你的名字" forState:UIControlStateNormal];
        [_nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headButton.mas_right).offset(10);
            make.top.mas_equalTo(_headButton);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-65);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        [self addSubview:_timeLabel];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.text = @"时间";
        _timeLabel.textColor = [UIColor grayColor];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.mas_equalTo(_nameButton);
            make.top.mas_equalTo(_nameButton.mas_bottom);
        }];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeButton];
        _likeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //按钮图片文字换左右顺序
        CGFloat imageWith = _likeButton.imageView.bounds.size.width;
        CGFloat labelWidth = _likeButton.titleLabel.bounds.size.width;
        _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth-5, 0, -labelWidth+5);
        _likeButton.titleEdgeInsets = UIEdgeInsetsMake(1, -imageWith+3, -1, imageWith-3);
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.width.mas_equalTo(53);
            make.height.mas_equalTo(45);
        }];
        
        _commentLabel = [[UILabel alloc]init];
        [self addSubview:_commentLabel];
        _commentLabel.font = [UIFont systemFontOfSize:15];
        _commentLabel.numberOfLines = 0;
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameButton);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(_headButton.mas_bottom).offset(20);
        }];
        
        _bgView = [[UIView alloc]init];
        [self addSubview: _bgView];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
        _lineLabel = [[UILabel alloc]init];
        [self addSubview:_lineLabel];
        _lineLabel.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(_bgView.mas_bottom).offset(20);
        }];
        
        _replayTable = [[UITableView alloc]init];
        _replayTable.scrollEnabled = NO;
        _replayTable.backgroundColor = [UIColor clearColor];
        _replayTable.separatorColor=[UIColor clearColor];
        _replayTable.dataSource = self;
        _replayTable.delegate = self;
        [_replayTable registerClass:[ReplayCell class] forCellReuseIdentifier:@"ReplayCell"];
        [_bgView addSubview:_replayTable];
        
        commentArr = [NSMutableArray array];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_moreButton setTitle:@"查看更多回复..." forState:UIControlStateNormal];
        [_bgView addSubview:_moreButton];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_replayTable);
            make.height.mas_equalTo(25);
            make.bottom.mas_equalTo(0);
        }];
       
    }
    return self;
}

-(void)fillCellWithModel:(CommentModel *)model{
    ///评论的内容
    NSString *commentStr =model.content;
    [_nameButton setTitle:model.aName forState:UIControlStateNormal];
    _timeLabel.text = model.time;
    [_likeButton setTitle:model.likeNum forState:UIControlStateNormal];
    
    ///回复的数组 add到数组里
    commentArr = [NSMutableArray array];
    for (NSDictionary *dic in model.replyArray) {
        CommentModel *model = [[CommentModel alloc]initWithDictionary:dic];
        [commentArr addObject:model];
    }
    
     commentNum = commentArr.count;
    ///table高度
    CGFloat strHeight;
    
    if (commentNum > 0) {
        _bgView.hidden = NO;
        strHeight = 25 + 5*commentNum;
    }else{
        _bgView.hidden = YES;
        strHeight = 0;
    }
    NSLog(@"%@===%f",model.aName,strHeight);
    
    for (CommentModel *model in commentArr) {
        NSString *str = [NSString stringWithFormat:@"%@ 回复 %@：%@",model.bName,model.aName,model.content];
        strHeight = strHeight +  [self contentHeight:str withWidth:[UIScreen mainScreen].bounds.size.width-20-78 withFont:13];
    }
    _commentLabel.text = commentStr;
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_commentLabel.mas_bottom).offset(commentNum>0?20:0);
        make.left.right.mas_equalTo(_commentLabel);
        make.height.mas_equalTo(strHeight);
    }];
 
    [_replayTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(_bgView.mas_bottom).offset(-25);
    }];
    
    ///点赞状态
    BOOL isLike = model.likeSts.boolValue;
    if (isLike == YES){
        [_likeButton setImage:[UIImage imageNamed:@"Likeclick"] forState:UIControlStateNormal];
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
    [_likeButton setTitle:model.likeNum forState:UIControlStateNormal];
    
    [_moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_nameButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_likeButton addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(CGFloat)contentHeight:(NSString *)content withWidth:(float)width withFont:(float)f
{
    
    CGRect rect=[content boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:f]} context:nil];
    return rect.size.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return commentNum;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplayCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReplayCell"];
    CommentModel *model = commentArr[indexPath.row];
    cell.replayLabel.text= [NSString stringWithFormat:@"%@ 回复 %@：%@",model.bName,model.aName,model.content];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"回复回复");
    [_tView becomeFirstResponder];
    ///跳转 --回复 xxx：
}
-(void)moreButtonClick:(UIButton *)sender{
    NSLog(@"跳转更多回复");
}
-(void)headButtonClick:(UIButton *)sender{
    NSLog(@"跳转个人主页");
}
-(void)likeButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.isSelected == YES){
        [_likeButton setImage:[UIImage imageNamed:@"Likeclick"] forState:UIControlStateNormal];
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
