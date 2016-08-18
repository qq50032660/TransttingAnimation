//
//  ViewController.m
//  TransttingAnimation
//
//  Created by fyc on 16/8/18.
//  Copyright © 2016年 FuYaChen. All rights reserved.
//

#import "ViewController.h"
#import "UIView_extra.h"
#import "TwoVC.h"
#import "TransformView.h"
@interface ViewController ()
@property (nonatomic, retain)NSArray *animations;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIButton *b = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    b.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height - 150);
    [self.view addSubview:b];
    
    
    self.animations = @[@"模仿qq电话动画",@"效果二",@"效果三",@"效果四"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ide = @"c";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (!cell) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];
    }
    cell.textLabel.text = self.animations[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TwoVC *vc = [[TwoVC alloc]init];
            vc.type = XWPresentTwoTransitionTypePresent;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        case 1:
        {
            TwoVC *vc = [[TwoVC alloc]init];
            vc.type = XWPresentOneTransitionTypePresent;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        case 2:
        {
            UIWindow *window = [UIApplication sharedApplication].windows[0];
            TransformView *view = [[TransformView alloc] initWithFrame:self.view.bounds WithUIViewController:self];
            [window addSubview:view];
            [TransformView makeAnimationTop:view];
            break;
        }
        case 3:
        {
            TwoVC *vc = [[TwoVC alloc]init];
            vc.type = XWPresentThreeTransitionTypePresent;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    if (indexPath.row == 0) {

    }else{

    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
