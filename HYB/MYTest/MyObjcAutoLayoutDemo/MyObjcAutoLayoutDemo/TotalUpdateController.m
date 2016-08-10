//
//  TotalUpdateController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/10.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "TotalUpdateController.h"
#import "Masonry.h"

@interface TotalUpdateController ()
@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, assign) BOOL isExpanded;
@end

@implementation TotalUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Masonry 整体动画更新";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self totalUpdateAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)totalUpdateAnimate {
    
    self.purpleView = [[UIView alloc] init];
    self.purpleView.backgroundColor = [UIColor purpleColor];
    self.purpleView.layer.borderColor = [UIColor blackColor].CGColor;
    self.purpleView.layer.borderWidth = 3;
    [self.view addSubview:self.purpleView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.purpleView addGestureRecognizer:tap];
    
    self.orangeView = [[UIView alloc] init];
    self.orangeView.backgroundColor = [UIColor orangeColor];
    self.orangeView.layer.borderColor = [UIColor blackColor].CGColor;
    self.orangeView.layer.borderWidth = 3;
    [self.view addSubview:self.orangeView];
    
    // 这里，我们不使用updateViewConstraints方法，但是我们一样可以做到。
    // 不过苹果推荐在updateViewConstraints方法中更新或者添加约束的
    [self updateWithExpand:NO animated:NO];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击purple部分放大，orange部分最大值250，最小值90";
    [self.purpleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
}

- (void)onTap {
    [self updateWithExpand:!self.isExpanded animated:YES];
}

- (void)updateWithExpand:(BOOL)isExpanded animated:(BOOL)animated {
    
    self.isExpanded = isExpanded;
    
    [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (isExpanded) {
            make.bottom.mas_equalTo(-20);
        } else {
            make.bottom.mas_equalTo(-300);
        }
    }];
    
    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self.purpleView);
        
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!isExpanded) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
        
        // 最大值为250
        make.width.height.lessThanOrEqualTo(@250);
        
        // 最小值为90
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

@end













