//
//  TestCell.m
//  MyObjcAutoLayoutDemo
//
//  Created by chenzs on 16/8/11.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "TestCell.h"
#import "Masonry.h"

@implementation TestCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.backgroundColor = [UIColor blueColor];
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 10;
        [self.contentView addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(8);
            make.width.height.mas_equalTo(40);
        }];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont systemFontOfSize:16];
        self.titleLab.numberOfLines = 0;
        [self.contentView addSubview:self.titleLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgView.mas_right).mas_offset(8);
            make.top.mas_equalTo(self.imgView);
            make.right.mas_equalTo(self.contentView).mas_equalTo(-8);
        }];
        
        self.subTitleLab = [[UILabel alloc] init];
        self.subTitleLab.font = [UIFont systemFontOfSize:14];
        self.subTitleLab.numberOfLines = 0;
        [self.contentView addSubview:self.subTitleLab];
        self.subTitleLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.subTitleLab addGestureRecognizer:tap];
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        self.subTitleLab.preferredMaxLayoutWidth = w - 8 - 40 - 8 - 8;//这个很重要，不加，展开后的subTitleLab高度不对
        [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(8);
            //make.bottom.mas_equalTo(self.contentView).mas_offset(-8);
        }];
        
//        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = [UIColor blackColor];
//        [self.contentView addSubview:lineView];
//        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.titleLab);
//            make.right.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(self.subTitleLab.mas_bottom).mas_offset(8);
//            make.height.mas_equalTo(0.5);
//        }];
    }
    return self;
}

- (void)tap:(UIGestureRecognizer *)tap {
    
    self.model.isExpanded = !self.model.isExpanded;
    
    if (self.block) {
        self.block(self.indexPath);
    }
    
    [self configCellWithModel:self.model];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

- (void)configCellWithModel:(TestModel *)model{
    
    self.model = model;
    self.titleLab.text = model.titleStr;
    self.subTitleLab.text = model.subTitleStr;
    
    if (self.model.isExpanded) {
        [self.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(8);
            //make.bottom.mas_equalTo(self.contentView).mas_offset(-8); //加了这  不对
        }];
    } else {
        [self.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(8);
            //make.bottom.mas_equalTo(self.contentView).mas_offset(-8);//加了这  约束有冲突
            make.height.mas_equalTo(40);
        }];
    }
    //subTitleLab 不能加对底部的约束
}

+ (CGFloat)heightForCellWithModel:(TestModel *)model{
    
    TestCell *cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell configCellWithModel:model];
    
    [cell layoutIfNeeded];
    
    CGRect frame =  cell.subTitleLab.frame;
    return frame.origin.y + frame.size.height + 8;
}

@end
