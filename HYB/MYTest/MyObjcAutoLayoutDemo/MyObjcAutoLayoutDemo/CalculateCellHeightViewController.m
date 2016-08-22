//
//  CalculateCellHeightViewController.m
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "CalculateCellHeightViewController.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "CalculateCellModel.h"
#import "CalculateHeightCell.h"

@interface CalculateCellHeightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CalculateCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"Auto Calculate Cell Height";
    
    [self configurationView];
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

- (void)configurationView {
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //必须先添加到view上在进行约束  否则会crash
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        
        int titleTotalLenght = (int)[[self titleAll] length];
        int descTotalLenght = (int)[[self descAll] length];
        
        for (int i=0; i<40; i++) {
            int titleLenght = rand() % titleTotalLenght + 15;
            if (titleLenght > titleTotalLenght - 1) {
                titleLenght = titleTotalLenght;
            }
            
            CalculateCellModel *model = [CalculateCellModel new];
            
            NSString *titleStr = [[self titleAll] substringToIndex:titleLenght];
            model.mainStr = titleStr;
            
            
            int descLenght = rand() % descTotalLenght + 20;
            if (descLenght >= descTotalLenght) {
                descLenght = descTotalLenght;
            }
            
            NSString *descStr = [[self descAll] substringToIndex:descLenght];
            model.descStr = descStr;
            
            model.uid = i  + 1;
            
            model.isExpanded = YES;
            
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (NSString *)titleAll {
    return @"欢迎使用HYBMasonryAutoCellHeight扩展，由作者huangyibiao提供，如有任何疑问，请给作者发email：huangyibiao520@163.com，谢谢您的支持！！！";
}

- (NSString *)descAll {
    return @"HYBMasonryAutoCellHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.hybblog.com/masonryjie-shao/，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CalculateCellIdentifier";
    CalculateHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CalculateHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CalculateCellModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    
    cell.expandBlock = ^(BOOL isExpand) {
        model.isExpanded = isExpand;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CalculateCellModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *stateStr;
    if (model.isExpanded) {
        stateStr = @"expand";
    } else {
        stateStr = @"noExpand";
    }
    
    return [CalculateHeightCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CalculateHeightCell *cell = (CalculateHeightCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey:[NSString stringWithFormat:@"%d",model.uid],
                 kHYBCacheStateKey:stateStr,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kHYBRecalculateForStateKey:@(NO)}; // 标识不用重新更新
    }];
}

@end
