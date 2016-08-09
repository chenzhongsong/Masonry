//
//  CodeAutolayoutViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/9.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "CodeAutolayoutViewController.h"
#import "Masonry.h"

@interface CodeAutolayoutViewController ()

@end

@implementation CodeAutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = UIColor.redColor;
    
    
    [self configuration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configuration {
    
    __weak __typeof(self) weakSelf = self;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    
    //
    UILabel *tipLable = [[UILabel alloc] init];
    tipLable.numberOfLines = 0;
    tipLable.textAlignment = NSTextAlignmentLeft;
    tipLable.backgroundColor = [UIColor redColor];
    tipLable.textColor = [UIColor whiteColor];
    [scrollView addSubview:tipLable];
    tipLable.text = @"这个标签是使用Masonry完成的纯代码自动布局。这个标签的约束添加方式为：使左、上与父视图的左、上分别相等，使右边与self.view的右边的相距-10，就可以确定其宽。这里不能使用使右等于scrollview的右，因为scrollview是可以滚动的，其右是不确定的。";
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(weakSelf.view).offset(-10);
    }];
    
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.numberOfLines = 0;
    codeLabel.textAlignment = NSTextAlignmentLeft;
    codeLabel.textColor = [UIColor whiteColor];
    codeLabel.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:codeLabel];
    codeLabel.text = @"本标签的约束添加方式为：使左、右与上面的标签的左、右分别对齐，由此就可确定左、右和宽，再使顶部top等于上面的标签的bottom再加上40个像素。\n欢迎扫一扫我的微信公众号二维码，关注公众号，或者直接搜索iOSDevShares。若想加QQ群，请加：324400294";
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(tipLable);
        make.top.mas_equalTo(tipLable.mas_bottom).offset(40);
    }];
    
    UIImageView *codeImgView = [[UIImageView alloc] init];
    codeImgView.image = [UIImage imageNamed:@"微信公众号.jpg"];
    [scrollView addSubview:codeImgView];
    [codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(codeLabel.mas_bottom).offset(20);
        make.width.height.mas_equalTo(250);
    }];
    
    
    UILabel *avgLabel1 = [[UILabel alloc] init];
    avgLabel1.backgroundColor = [UIColor redColor];
    avgLabel1.textColor = [UIColor whiteColor];
    avgLabel1.textAlignment = NSTextAlignmentCenter;
    avgLabel1.numberOfLines = 0;
    [scrollView addSubview:avgLabel1];
    avgLabel1.text = @"本控件的约束添加方式为：使left与父视图的left相距10像素，使top=上面的图片的bottom再加40像素，使right=右边这个标签的left再减去20个像素（间隔），使height=80。";
    
    UILabel *avgLabel2 = [[UILabel alloc] init];
    avgLabel2.backgroundColor = [UIColor redColor];
    avgLabel2.textColor = [UIColor whiteColor];
    avgLabel2.textAlignment = NSTextAlignmentCenter;
    avgLabel2.numberOfLines = 0;
    [scrollView addSubview:avgLabel2];
    avgLabel2.text = @"本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。";
    
    
    [avgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(codeImgView.mas_bottom).offset(40);
        make.right.mas_equalTo(avgLabel2.mas_left).offset(-20);
    }];
    [avgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.width.mas_equalTo(avgLabel1);
    }];
    
    // 使用edges使点满整个self.view
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        
        // 如果这两个标签的内容都是不确定的，也就是不确定哪个的内容更多，那么可以这么设置。
        // 这样就可以保证使用内容最多的标签作为scrollview的contentSize参考。
        // 用于确定scrollview的contentSize.height
        make.bottom.mas_greaterThanOrEqualTo(avgLabel1.mas_bottom).offset(40);
        make.bottom.mas_greaterThanOrEqualTo(avgLabel2.mas_bottom).offset(40);
    }];
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
