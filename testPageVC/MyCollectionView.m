//
//  MyCollectionView.m
//  testPageVC
//
//  Created by Jingyue on 8/18/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "MyCollectionView.h"

@implementation MyCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%@ touchesBegan :", NSStringFromClass([self class]));
//}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@ touchesMoved :", NSStringFromClass([self class]));
//}
//

- (void)travelSuperViews:(UIView *)view
{
    if (view == nil) {
        return;
    }
    if ([[view class] isSubclassOfClass:[UIScrollView class]]) {
        
        //[self resetDelaysTouchesBeganOfView:view];
    }
    [self resetDelaysTouchesBeganOfView:view];
    [self travelSuperViews:view.superview];
}

- (void)resetDelaysTouchesBeganOfView:(UIView *)view
{
    for (UIGestureRecognizer * gestureRecognizer in view.gestureRecognizers) {
        
        NSLog(@"%@", gestureRecognizer);
        gestureRecognizer.delaysTouchesBegan = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesEnded :", NSStringFromClass([self class]));
    [self travelSuperViews:self];
    [super touchesEnded:touches withEvent:event];
}

//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@ touchesCancelled :", NSStringFromClass([self class]));
//}

@end
