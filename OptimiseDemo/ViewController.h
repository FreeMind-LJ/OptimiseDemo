//
//  ViewController.h
//  OptimiseDemo
//
//  Created by lujb on 15/9/7.
//  Copyright (c) 2015年 lujb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *imageList;


@end

