//
//  CalculateHeightCell.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "CalculateHeightCell.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@implementation CalculateHeightCell

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
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 0;
        self.mainLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.mainLabel];
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(15);
            make.height.mas_lessThanOrEqualTo(80);
        }];
        // 应该始终要加上这一句
        // 不然在6/6plus上就不准确了
        self.mainLabel.preferredMaxLayoutWidth = w - 30;
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.numberOfLines = 0;
        self.descLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.descLabel];
        [self.descLabel sizeToFit];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.mainLabel.mas_bottom).mas_offset(15);
        }];
        // 应该始终要加上这一句
        // 不然在6/6plus上就不准确了
        self.descLabel.preferredMaxLayoutWidth = w - 30;
        self.descLabel.userInteractionEnabled = YES;//打开  老忘记
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.descLabel addGestureRecognizer:tap];
        
        self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.lastButton setTitle:@"这是最后一个Cell" forState:UIControlStateNormal];
        self.lastButton.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.lastButton];
        [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(self.descLabel.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(40);
        }];
        // 必须加上这句
        self.hyb_lastViewInCell = self.lastButton;
        //self.hyb_lastViewsInCell = @[self.lastButton];
        self.hyb_bottomOffsetToCell = 15;
    }
    
    return self;
}

- (void)configCellWithModel:(CalculateCellModel *)model {
    self.model = model;
    self.mainLabel.text = model.mainStr;
    self.descLabel.text = model.descStr;
    
    if (model.isExpanded) {
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.mainLabel.mas_bottom).mas_offset(15);
        }];
    } else {
        [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(60);//不能是 mas_equalTo
        }];
    }
    
}

- (void)tap:(UIGestureRecognizer *)tap {
    if (self.expandBlock) {
        self.expandBlock(!self.model.isExpanded);
    }
}

@end
