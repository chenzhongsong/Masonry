//
//  AspectFitController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/11.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "AspectFitController.h"
#import "Masonry.h"

@interface AspectFitController ()

@end

@implementation AspectFitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Masonry MutipliedBy";//multipliedBy
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self masMutipliedByLayout];
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

- (void)masMutipliedByLayout {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    
    UIView *topInnerView = [UIView new];
    topInnerView.backgroundColor = [UIColor greenColor];
    [topView addSubview:topInnerView];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bottomView];
    
    UIView *bottomInnerView  =[[UIView alloc] init];
    bottomInnerView.backgroundColor = [UIColor blackColor];
    [bottomView addSubview:bottomInnerView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(bottomView.mas_height);
    }];
    
    [topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(topView);
        make.center.mas_equalTo(topView);
        //width = height * 3
        make.width.mas_equalTo(topInnerView.mas_height).multipliedBy(3);
         // 设置优先级
        make.height.width.mas_equalTo(topView).priorityLow();
        make.height.width.mas_lessThanOrEqualTo(topView);
    }];
     
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.center.mas_equalTo(bottomView);
        // 注意，这个multipliedBy的使用只能是设置同一个控件的，比如这里的bottomInnerView，
        make.height.mas_equalTo(bottomInnerView.mas_width).multipliedBy(3);
        
        make.height.width.mas_equalTo(bottomView).priorityLow();
        make.height.width.mas_lessThanOrEqualTo(bottomView);
    }];
    
}

@end
