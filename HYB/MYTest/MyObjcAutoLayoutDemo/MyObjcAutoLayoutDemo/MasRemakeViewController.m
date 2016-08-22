//
//  MasRemakeViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/10.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "MasRemakeViewController.h"
#import "Masonry.h"

@interface MasRemakeViewController ()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) BOOL isExpanded;
@end

@implementation MasRemakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Masonry remake更新约束";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self remakeAnimatedLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)remakeAnimatedLayout {
    self.growingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.growingButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    self.growingButton.backgroundColor = [UIColor redColor];
    [self.growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    self.isExpanded = NO;
    
    //不加这个在8上没效果 即- (void)updateViewConstraints 不执行 。 在9上没问题
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        
        make.bottom.mas_equalTo(-350);
        
    }];
}

- (void)onGrowButtonTaped:(UIButton *)btn {
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingButton setTitle:@"点我收起" forState:UIControlStateNormal];
    }
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//override
- (void)updateViewConstraints {
    // 这里使用update也是一样的。
    // remake会将之前的全部移除，然后重新添加
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        if (self.isExpanded) {
            make.bottom.mas_equalTo(-10);
        } else {
            make.bottom.mas_equalTo(-350);
        }
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
