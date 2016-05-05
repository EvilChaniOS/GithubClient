//
//  ArchiveHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ArchiveHelper.h"
#import "JZUser.h"

#define kArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ArticleFile"]

@implementation ArchiveHelper

+ (void)archiveJZUserWithData:(JZUser *)user {
    BOOL success = [NSKeyedArchiver archiveRootObject:user toFile:kArchivePath];
    NSLog(@"is success %d, ArchivePath - %@",success,kArchivePath);
}

+ (JZUser *)unarchiveJZUser {
    JZUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kArchivePath];
    return user;
}

@end
