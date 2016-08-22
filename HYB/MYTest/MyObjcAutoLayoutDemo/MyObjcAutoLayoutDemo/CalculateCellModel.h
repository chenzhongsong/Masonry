//
//  CalculateCellModel.h
//  MyObjcAutoLayoutDemo
//
//  Created by eliteall on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateCellModel : NSObject

@property (nonatomic, copy) NSString *mainStr;
@property (nonatomic, copy) NSString *descStr;
@property (nonatomic, assign) BOOL isExpanded;

//重要
@property (nonatomic, assign) int uid;

@end
