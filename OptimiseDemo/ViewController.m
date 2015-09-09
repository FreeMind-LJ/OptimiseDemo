//
//  ViewController.m
//  OptimiseDemo
//
//  Created by lujb on 15/9/7.
//  Copyright (c) 2015年 lujb. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //加载plist文件的数据和图片
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"DemoInfo" withExtension:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    NSMutableArray *tmpImageArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[dictionary count]; i++) {
        int index = i%8;
        NSString *key = [[NSString alloc] initWithFormat:@"%i", index+1];
        NSDictionary *tmpDic = [dictionary objectForKey:key];
        [tmpDataArray addObject:tmpDic];
        
        NSString *imageUrl = [[NSString alloc] initWithFormat:@"%i.png", index+1];
        UIImage *image = [UIImage imageNamed:imageUrl];
        [tmpImageArray addObject:image];
    }
    self.dataList = [tmpDataArray copy];
    self.imageList = [tmpImageArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CustomCellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.dataList objectAtIndex:row];
    
    cell.name.text = [rowData objectForKey:@"name"];
    cell.name.backgroundColor = [UIColor clearColor];
    
    cell.sign.text = [rowData objectForKey:@"dec"];
    cell.place.text = [rowData objectForKey:@"loc"];
    cell.imageView1.image = [_imageList objectAtIndex:row];
    cell.imageView2.image = [_imageList objectAtIndex:row];
    
    cell.sign.layer.shadowOffset = CGSizeMake(0, 2);
    cell.sign.layer.shadowOpacity = 0.5;

    
    cell.imageView1.layer.cornerRadius = cell.imageView1.frame.size.width/2.0;
    cell.imageView1.layer.masksToBounds = YES;
    
    cell.imageView2.layer.cornerRadius = cell.imageView2.frame.size.width/2.0;
    cell.imageView2.layer.masksToBounds = YES;

//阴影性能优化
//    cell.sign.layer.shadowPath = [UIBezierPath  bezierPathWithRect:cell.sign.bounds].CGPath;
//
//使用光栅化进行优化
//    cell.layer.shouldRasterize = YES;
//    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

@end
