//
//  UserDefaultHelper.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultHelper : NSObject

+ (void)setToekn:(NSString *)token ;
+ (NSString *)getToken;
@end
