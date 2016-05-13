//
//  JZRepoSummaryCell.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/9.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZRepoSummaryCell.h"

@implementation JZRepoSummaryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)repoSummaryCellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"JZRepoSummaryCell";
    JZRepoSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JZRepoSummaryCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
