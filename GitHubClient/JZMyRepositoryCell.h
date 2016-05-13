//
//  JZMyRepositoriesCell.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMyRepositoryCell : UITableViewCell
// 通过字典代替模型来进行View跟Model的解偶
- (void)bindDataWithModelDictionary:(NSDictionary *)dict;

+ (instancetype)myRepositoryCellWithTableView:(UITableView *)tableView;

@end
