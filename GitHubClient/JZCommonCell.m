//
//  JZCommonCell.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/9.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZCommonCell.h"

static NSString * const kIconKey = @"icon";
static NSString * const kTitleKey = @"title";
static NSString * const kSubTitleKey = @"sbutitle";

@interface JZCommonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation JZCommonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)commonCellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"JZCommonCell";
    JZCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JZCommonCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)bindDataWithModelDictionary:(NSDictionary *)dict {
//    _iconImageView.
    _titleLabel.text = dict[kTitleKey];
    _subTitleLabel.text = dict[kSubTitleKey];
}
@end
