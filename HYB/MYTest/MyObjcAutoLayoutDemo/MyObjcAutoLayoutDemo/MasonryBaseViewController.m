//
//  MasonryBaseViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/10.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "MasonryBaseViewController.h"
#import "Masonry.h"

@interface MasonryBaseViewController ()

@end

@implementation MasonryBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Masonry基础使用";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self masonryBaseUse];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)masonryBaseUse {
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.layer.borderColor = [UIColor blackColor].CGColor;
    greenView.layer.borderWidth = 2;
    [self.view addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = [UIColor redColor];
    redView.layer.borderColor = [UIColor blackColor].CGColor;
    redView.layer.borderWidth = 2;
    [self.view addSubview:redView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.layer.borderColor = [UIColor blackColor].CGColor;
    blueView.layer.borderWidth = 2;
    [self.view addSubview:blueView];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(redView.mas_left).offset(-20);
        make.height.mas_equalTo(@[redView,blueView]);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.mas_equalTo(greenView);
        make.right.mas_equalTo(-10);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(greenView.mas_bottom).offset(10);
        make.left.mas_equalTo(greenView);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}


@end
