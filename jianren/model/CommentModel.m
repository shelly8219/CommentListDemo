//
//  CommentModel.m
//  jianren
//
//  Created by xxx on 2018/7/12.
//  Copyright © 2018年 xxx. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
- (id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        NSString *content =[NSString  stringWithFormat:@"%@",dic];
        if (content!=nil&&![content isEqualToString:@""])
        {
            [self setValuesForKeysWithDictionary:dic];
        }
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    }
}
@end
