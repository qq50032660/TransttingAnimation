//
//  TransformView.m
//  Transform3DView
//
//  Created by tcnj on 16/1/15.
//  Copyright © 2016年 cqz. All rights reserved.
//

#import "TransformView.h"
#import "UIColor+Helper.h"
#import "UIView+Tap.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue] //iOS版本


@interface TransformView()

@property (nonatomic, strong) UIViewController *fromVC;
@property (nonatomic,strong) UIView *backgroundView;//背景view
@property (nonatomic,strong) UIButton *cancelBtn;//删除按钮

@end

@implementation TransformView

- (id)initWithFrame:(CGRect)frame WithUIViewController:(UIViewController *)fromVC
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.fromVC = fromVC;
        
        [UIView animateWithDuration:0.2f animations:^{
            
            [fromVC.view.layer setTransform:[self firstTransform]];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f animations:^{
                [fromVC.view.layer  setTransform:[self secondTransformWithView:fromVC.view]];
            }];
        }];
        
        [self creatbackgroundView];

    }
    
    return self;
}
- (void)creatbackgroundView
{
    //创建背景view
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.6;
    [self addSubview:self.backgroundView];
    
    
    [self.backgroundView whenTapped:^{
        [UIView animateWithDuration:0.35 animations:^{
            self.fromVC.view.layer.transform = CATransform3DIdentity;
        }];
        [self makeAnimationBottom:self];
    }];
    
    if (iOSVersion >=8.0)
    {
#pragma mark ----blur效果
        UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEfView.frame = CGRectMake(0, 0, SCREENWIDTH, 280);
        visualEfView.alpha = 0.4;
        [self addSubview:visualEfView];
        
        [visualEfView whenTapped:^{
            [UIView animateWithDuration:0.35 animations:^{
                self.fromVC.view.layer.transform = CATransform3DIdentity;
            }];
            [self makeAnimationBottom:self];
        }];
    }

    //
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, SCREENWIDTH, SCREENHEIGHT-240)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondView];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(SCREENWIDTH-45, 25, 30, 30);
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"btn_picker_close"] forState:0];
    [self.cancelBtn addTarget:self action:@selector(cancelBackgroundView:) forControlEvents:UIControlEventTouchUpInside];
    [secondView  addSubview:self.cancelBtn];
    
}

#pragma mark -UIButtonEvent
- (void)cancelBackgroundView:(id)sender{
    
    NSLog(@"取消自身");
    [UIView animateWithDuration:0.35 animations:^{
        self.fromVC.view.layer.transform = CATransform3DIdentity;
    }];
    [self makeAnimationBottom:self];
    
}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    return t1;
    
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}
#pragma mark -弹出消失动画
- (void)makeAnimationBottom:(UIView *)views
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
    [self removeFromSuperview];
}
+ (void)makeAnimationTop:(UIView *)views{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
