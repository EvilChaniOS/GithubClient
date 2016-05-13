//
//  JZMyRepositories.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface JZMyRepository : NSObject<NSCoding>

@property (nonatomic, strong) NSDictionary *owner;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger stargazers_count;

@property (nonatomic, assign) NSInteger forks_count;

@property (nonatomic, copy) NSString *html_url;

@property (nonatomic, copy) NSString *content;

@end
