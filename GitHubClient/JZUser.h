//
//  JZUser.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZUser : NSObject<NSCoding>

@property (nonatomic, copy) NSString *login;

@property (nonatomic, copy) NSString *avatar_url;

@end

