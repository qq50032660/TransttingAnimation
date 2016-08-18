//
//  TransitionFunction.h
//  TransttingAnimation
//
//  Created by fyc on 16/8/18.
//  Copyright © 2016年 FuYaChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, XWPresentOneTransitionType) {
    XWPresentOneTransitionTypePresent = 0,//管理present动画
    XWPresentOneTransitionTypeDismiss,//管理dismiss动画
    XWPresentTwoTransitionTypePresent,//qq语音动画
    XWPresentTwoTransitionTypeDismiss,//qq语音动画
    XWPresentThreeTransitionTypePresent,
    XWPresentThreeTransitionTypeDismiss//渐隐
};

@interface TransitionFunction : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) XWPresentOneTransitionType type;

+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type;

@end
