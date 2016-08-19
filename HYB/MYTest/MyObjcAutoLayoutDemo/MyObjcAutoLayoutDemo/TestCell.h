//
//  TestCell.h
//  MyObjcAutoLayoutDemo
//
//  Created by chenzs on 16/8/11.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

typedef void(^testBlock)(NSIndexPath *indexPath);

@interface TestCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) TestModel *model;
@property (nonatomic, copy) testBlock block;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)configCellWithModel:(TestModel *)model;
+ (CGFloat)heightForCellWithModel:(TestModel *)model;

@end
