//
//  GitHubConfigure.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#ifndef GitHubConfigure_h
#define GitHubConfigure_h

static NSString * const kClientID = @"521785a778bfceda1141";
static NSString * const kRedirectURI = @"CJZGithub://chenjiongzhou";
static NSString * const kScope = @"user,public_repo";
static NSString * const kClientSecret = @"31c841850d70626334571dabc4c31d9c8523d58b";

static NSString * const kAuthorizeURL = @"https://github.com/login/oauth/authorize";
static NSString * const kAccessTokenURL = @"https://github.com/login/oauth/access_token";
static NSString * const kAccessUserInfoURL = @"https://api.github.com/user";
static NSString * const kTrendingURL = @"http://trending.codehub-app.com/trending";
static NSString * const kMyRepositoriesURL = @"https://api.github.com/users/EvilChaniOS/repos";
#endif /* GitHubConfigure_h */
