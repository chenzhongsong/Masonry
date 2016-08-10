//
//  MasAnimateLayoutViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/10.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "MasAnimateLayoutViewController.h"
#import "Masonry.h"

@interface MasAnimateLayoutViewController ()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGFloat scacle;
@end

@implementation MasAnimateLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Masonry动画更新约束";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self masonryAnimateUpdateLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)masonryAnimateUpdateLayout {
    
    //http://www.huangyibiao.com/masonry-animated-update/
    
    __weak __typeof(self) weakSelf = self;
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.growingButton addTarget:self action:@selector(growingButtonBnt:) forControlEvents:UIControlEventTouchUpInside];
    self.growingButton.layer.borderColor = [UIColor greenColor].CGColor;
    self.growingButton.layer.borderWidth = 3;
    [self.growingButton setTitle:@"点我放大" forState:UIControlStateNormal];
    [self.growingButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.growingButton];
    self.scacle = 1.0;
    
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100*weakSelf.scacle).priorityLow();
        // 最大放大到整个view
        make.width.height.mas_lessThanOrEqualTo(weakSelf.view);
    }];
}

- (void)growingButtonBnt:(UIButton *)btn {
    
    self.scacle += 0.5;
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)updateViewConstraints {
    __weak __typeof(self) weakSelf = self;
    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.width.height.mas_equalTo(100*weakSelf.scacle).priorityLow();
        make.width.height.mas_lessThanOrEqualTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
