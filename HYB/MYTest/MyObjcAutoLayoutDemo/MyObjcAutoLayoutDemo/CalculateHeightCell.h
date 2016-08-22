//
//  CalculateHeightCell.h
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateCellModel.h"

typedef void(^ExpandBlcok)(BOOL isExpanded);

@interface CalculateHeightCell : UITableViewCell

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, copy) ExpandBlcok expandBlock;

@property (nonatomic, strong) CalculateCellModel *model;

- (void)configCellWithModel:(CalculateCellModel *)model;

@end
