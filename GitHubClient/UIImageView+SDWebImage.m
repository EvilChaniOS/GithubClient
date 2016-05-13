//
//  UIImageView+SDWebImage.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWebImage)

- (void)setImageViewWithUrl:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
}

- (UIImageView *)roundImageView:(UIImageView *)avatarImageView {
    UIGraphicsBeginImageContextWithOptions(avatarImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:avatarImageView.bounds cornerRadius:avatarImageView.frame.size.height / 2] addClip];
    UIImage *image = [UIImage new];
    [image drawInRect:avatarImageView.bounds];
    avatarImageView.image = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return avatarImageView;
}

- (void)setRoundImageViewWithUrl:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.height / 2] addClip];[image drawInRect:self.bounds];
        self.image = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    }];
}
@end
