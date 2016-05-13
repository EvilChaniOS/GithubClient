//
//  JZMyRepositoriesCell.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZMyRepositoryCell.h"
#import "UIImageView+SDWebImage.h"

static NSString * const kOwnerKey = @"owner";
static NSString * const kAvatarUrlKey = @"avatar_url";
static NSString * const kNameKey = @"name";
static NSString * const kStargazersCountKey = @"stargazers_count";
static NSString * const kForksCountKey = @"forks_count";
static NSString * const kContentKey = @"content";

@interface JZMyRepositoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *stargazersButton;

@property (weak, nonatomic) IBOutlet UIButton *forksButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation JZMyRepositoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)myRepositoryCellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"JZMyRepositoryCell";
    JZMyRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JZMyRepositoryCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)bindDataWithModelDictionary:(NSDictionary *)dict {
    [_avatarImageView setRoundImageViewWithUrl:dict[kOwnerKey][kAvatarUrlKey]];
    _titleLabel.text = dict[kNameKey];
    [_stargazersButton setTitle:[NSString stringWithFormat:@"%ld",[dict[kStargazersCountKey] integerValue]] forState:UIControlStateNormal];
    [_forksButton setTitle:[NSString stringWithFormat:@"%ld",[dict[kForksCountKey] integerValue]] forState:UIControlStateNormal];
    
    _contentLabel.text = dict[kContentKey];
}
@end
