//
//  CommentModel.h
//  jianren
//
//  Created by xxx on 2018/7/12.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
- (id)initWithDictionary:(NSDictionary *)dic;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@property(nonatomic,copy)NSString     *uid;/*user id*/
@property(nonatomic,copy)NSString     *aName;/*user name*/
@property(nonatomic,copy)NSString     *bName;/*user name*/
@property(nonatomic,copy)NSString     *content;/*评论内容*/
@property(nonatomic,copy)NSString     *time;/*评论时间*/
@property(nonatomic,copy)NSString     *commentId;/*评论id*/
@property(nonatomic,copy)NSString     *likeNum;/*评论id*/
@property(nonatomic,copy)NSString     *likeSts;/*评论id*/
@property(nonatomic,strong)NSArray    *replyArray;/*回复数组*/
@end
