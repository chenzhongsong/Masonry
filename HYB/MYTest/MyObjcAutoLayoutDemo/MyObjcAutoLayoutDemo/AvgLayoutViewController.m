//
//  AvgLayoutViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/10.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "AvgLayoutViewController.h"

@interface AvgLayoutViewController ()

@end

@implementation AvgLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)masBaseUse:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"MasonryBaseViewController") new] animated:YES];
}

- (IBAction)masBaseLayout:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"MasAnimateLayoutViewController") new] animated:YES];
}

- (IBAction)masRemakeLayout:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"MasRemakeViewController") new] animated:YES];
}

- (IBAction)masEntiretyAnimateLayout:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"TotalUpdateController") new] animated:YES];
}

- (IBAction)masCompositeLayout:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"CompositeController") new] animated:YES];
}

- (IBAction)masMutipliedByLayout:(id)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"AspectFitController") new] animated:YES];
}

@end
