//
//  CommentListViewController.m
//  jianren
//
//  Created by xxx on 2018/7/3.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import "CommentListViewController.h"
#import "Masonry.h"
#import "CommentListCell.h"
#import "CommentView.h"
#import "CommentModel.h"

@interface CommentListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSMutableArray *commentArr;
}
@property(nonatomic,strong)CommentView *cmtView;
@property(nonatomic,strong)UITableView *listTable;
@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    commentArr = [NSMutableArray array];
    ///假数据
    for (int i=0; i<10; i++) {
        NSDictionary *dic ;
        if (i < 2) {
            dic = @{@"aName":[NSString stringWithFormat:@"aName-%d",i],
                    @"uid":[NSString stringWithFormat:@"%d",i],
                    @"content":@"哈哈哈红红火火恍恍惚惚红红火火哈哈啊哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈",
                    @"likeSts":@"1",
                    @"likeNum":[NSString stringWithFormat:@"%d",i+i*100],
                    @"time":[NSString stringWithFormat:@"7-%d",i],
                    @"replyArray":@[@{@"bName":[NSString stringWithFormat:@"bName-%d",i],@"aName":[NSString stringWithFormat:@"aName-%d",i],@"content":@"你说啥？"},@{@"bName":[NSString stringWithFormat:@"aName-%d",i],@"aName":[NSString stringWithFormat:@"bName-%d",i],@"content":@"啥也没说～～～～"}]
                    };
        }else if(i<4)
        {
            dic = @{@"aName":[NSString stringWithFormat:@"aName-%d",i],
                    @"uid":[NSString stringWithFormat:@"%d",i],
                    @"content":@"哈啊哈哈哈哈哈哈哈哈哈哈哈哈",
                    @"likeSts":@"1",
                    @"likeNum":[NSString stringWithFormat:@"%d",i+i*100],
                    @"time":[NSString stringWithFormat:@"7-%d",i],
                    @"replyArray":@[@{@"bName":[NSString stringWithFormat:@"bName-%d",i],@"aName":[NSString stringWithFormat:@"aName-%d",i],@"content":@"🙄️😄1⃣️2⃣️3⃣️"}]
                    };
        }else{
            dic = @{@"aName":[NSString stringWithFormat:@"aName-%d",i],
                    @"uid":[NSString stringWithFormat:@"%d",i],
                    @"content":@"沙发，留名",
                    @"likeSts":@"0",
                    @"likeNum":[NSString stringWithFormat:@"%d",i+i*100],
                    @"time":[NSString stringWithFormat:@"7-%d",i],
                    @"replyArray":@[]
                    };
        }
        [commentArr addObject:dic];
    }
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    self.navigationItem.title = @"全部评论";
    [self.view addSubview:[self listTable]];
    [self.view addSubview:[self cmtView]];
}
///评论回复输入区域
-(CommentView *)cmtView
{
    if (!_cmtView){
        _cmtView = [[CommentView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        _cmtView.inputView.delegate = self;
    }
    return _cmtView;
}
-(UITableView *)listTable
{
    if (!_listTable) {
        _listTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
        _listTable.delegate=self;
        _listTable.dataSource=self;
        _listTable.estimatedRowHeight = 44;
        _listTable.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        _listTable.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        _listTable.separatorColor=[UIColor clearColor];
        [_listTable registerClass:[CommentListCell class] forCellReuseIdentifier:@"CommentListCell"];
        _listTable.showsVerticalScrollIndicator=NO;
        
    }
    return _listTable;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return commentArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentListCell" forIndexPath:indexPath];
    CommentModel *model = [[CommentModel alloc]initWithDictionary:commentArr[indexPath.row]];
    [cell fillCellWithModel:model];
    cell.tView = _cmtView.inputView;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"回复评论");
    [_cmtView.inputView becomeFirstResponder];
    ///回复 xxx： 从数组中取名字
    CommentModel *model = [[CommentModel alloc]initWithDictionary:commentArr[indexPath.row]];
    _cmtView.inputView.text = [NSString stringWithFormat:@"回复 %@：",model.aName];
}
#pragma mark  ---return键---
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        NSLog(@"%@", _cmtView.inputView.text);
        //在这里做你响应return键的代码
        [_cmtView.inputView resignFirstResponder];
        _cmtView.inputView.text = @"";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
