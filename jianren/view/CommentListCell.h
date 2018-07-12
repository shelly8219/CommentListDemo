//
//  CommentListCell.h
//  jianren
//
//  Created by xxx on 2018/7/3.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CommentListCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger commentNum;
    NSMutableArray *commentArr;
}
@property(nonatomic,strong)UITextView *tView;
@property(nonatomic,strong)UIButton *headButton,*nameButton,*likeButton,*moreButton;
@property(nonatomic,strong)UILabel *timeLabel,*commentLabel,*lineLabel;
@property(nonatomic,strong)UITableView *replayTable;
@property(nonatomic,strong)UIView *bgView;
-(void)fillCellWithModel:(CommentModel *)model;
@end
