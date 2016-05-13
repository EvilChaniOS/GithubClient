//
//  ArchiveHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ArchiveHelper.h"
#import "JZUser.h"
#import "JZMyRepository.h"

#define kJZUserArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JZUser"]

#define kJZMyRepositoriesArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JZMyRepository"]

@implementation ArchiveHelper

+ (BOOL)archiveJZUser:(JZUser *)user {
    BOOL success = [NSKeyedArchiver archiveRootObject:user toFile:kJZUserArchivePath];
    NSLog(@"is success %d, ArchivePath - %@",success,kJZUserArchivePath);
    return success;
}

+ (JZUser *)unarchiveJZUser {
    JZUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kJZUserArchivePath];
    return user;
}

+ (BOOL)archiveMyRepositories:(NSMutableArray *)repositories {
    BOOL success = [NSKeyedArchiver archiveRootObject:repositories toFile:kJZMyRepositoriesArchivePath];
    NSLog(@"is success %d, ArchivePath - %@",success,kJZMyRepositoriesArchivePath);
    return success;
}

+ (NSMutableArray *)unarchiveJZMyRepositories {
    NSMutableArray *repositories = [NSKeyedUnarchiver unarchiveObjectWithFile:kJZMyRepositoriesArchivePath];
    return repositories;
}

@end
