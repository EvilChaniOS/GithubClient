//
//  ArchiveHelper.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JZUser;

@interface ArchiveHelper : NSObject

+ (BOOL)archiveJZUser:(JZUser *)data;
+ (JZUser *)unarchiveJZUser;

+ (BOOL)archiveMyRepositories:(NSMutableArray *)repositories;
+ (NSMutableArray *)unarchiveJZMyRepositories;

@end
