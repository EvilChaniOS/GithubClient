//
//  JZMyRepoHeader.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/9.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZMyRepoHeader.h"

@implementation JZMyRepoHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)myRepoHeader {
    JZMyRepoHeader *myRepoHeader = [[[NSBundle mainBundle] loadNibNamed:@"JZMyRepoHeader" owner:nil options:nil] lastObject];
    return myRepoHeader;
}

@end
