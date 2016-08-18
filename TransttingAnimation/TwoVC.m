//
//  TwoVC.m
//  TransttingAnimation
//
//  Created by fyc on 16/8/18.
//  Copyright © 2016年 FuYaChen. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation TwoVC
-(instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop:)];
    [imageView addGestureRecognizer:tap];
}
-(void)pop:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [TransitionFunction transitionWithTransitionType:self.type];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (self.type == XWPresentTwoTransitionTypePresent) {
        return [TransitionFunction transitionWithTransitionType:XWPresentTwoTransitionTypeDismiss];
    }else if (self.type == XWPresentThreeTransitionTypePresent){
        return [TransitionFunction transitionWithTransitionType:XWPresentThreeTransitionTypeDismiss];
    }
    return [TransitionFunction transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
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

@end
