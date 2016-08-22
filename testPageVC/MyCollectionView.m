//
//  MyCollectionView.m
//  testPageVC
//
//  Created by Jingyue on 8/18/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "MyCollectionView.h"

@implementation MyCollectionView

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self travelSuperViews:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesEnded :", NSStringFromClass([self class]));
    
    [super touchesEnded:touches withEvent:event];
}


@end
