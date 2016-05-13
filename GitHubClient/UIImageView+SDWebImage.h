//
//  UIImageView+SDWebImage.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDWebImage)

- (void)setImageViewWithUrl:(NSString *)url;
- (void)setRoundImageViewWithUrl:(NSString *)url;

@end
