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
            make.width.height.mas_equalTo(20);
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
        
        [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(8);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-8);
        }];
        
    }
    return self;
}

- (void)configCellWithModel:(TestModel *)model{
    
}

+(CGFloat)heightForCellWithModel:(TestModel *)model{
    
}

@end
