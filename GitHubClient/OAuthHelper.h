//
//  OAuthHelper.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthHelper : NSObject

+ (void)logonAuthentication;

+ (BOOL)handleOpenURLWithURL:(NSURL *)url;

@end
