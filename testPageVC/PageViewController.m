//
//  PageViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/16/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "PageViewController.h"
#import "CollectionViewController.h"
#import "MyCollectionViewController.h"
#import "ThirdCollectionViewController.h"
#import "TableViewController.h"
#import "ChildViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface PageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) CollectionViewController * clVC;
@property (strong, nonatomic) MyCollectionViewController * myClVC;
@property (strong, nonatomic) ThirdCollectionViewController * thirdClVC;
@property (strong, nonatomic) TableViewController * tbVC;
@property (strong, nonatomic) ChildViewController * childVC;

@end

@implementation PageViewController

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = NSSelectorFromString(@"viewControllers");
//        SEL swizzledSelector = @selector(test_handlePanGesture:);
//        
//        //printf("------%s-----\n", sel_getName(originalSelector));
//        //IMP originalImp = class_getMethodImplementation(class, originalSelector);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    navigationView.backgroundColor = [UIColor colorWithRed:235./255 green:235./255 blue:235/255.f alpha:1];
    [self.view addSubview:navigationView];
    
    UIButton * sendMessageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendMessageButton setTitle:@"Send Message" forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:sendMessageButton];
    [sendMessageButton sizeToFit];
    CGPoint center = navigationView.center;
    center.x = navigationView.center.x / 2.f;
    sendMessageButton.center = center;
    
    UIButton * resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:@"Reset Child" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetChildVCs) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:resetButton];
    [resetButton sizeToFit];
    resetButton.center = navigationView.center;
    center.x = navigationView.center.x * 3 / 2.f;
    resetButton.center = center;
    
    _clVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    _clVC.top = 64.f;
    _myClVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCollectionViewController"];
    _thirdClVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdCollectionViewController"];
    _tbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    _tbVC.top = 64.f;
    _childVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
    
    self.dataSource = self;
    self.delegate = self;
    [self setViewControllers:@[_myClVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    //[self getPageVCAllVar];
    //[self getScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getScrollView
{
    for (UIView * subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"_UIQueuingScrollView")]) {
            
            UIScrollView * scrollView = (UIScrollView *)subView;
            
            [scrollView addGestureRecognizer:self.test_panGestureRecognizer];
            
            // Forward the gesture events to the private handler of the onboard gesture recognizer.
            NSArray *internalTargets = [scrollView.panGestureRecognizer valueForKey:@"targets"];
            id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
            SEL internalAction = NSSelectorFromString(@"handlePan:");
            self.test_panGestureRecognizer.delegate = self;
            [self.test_panGestureRecognizer addTarget:internalTarget action:internalAction];
            
            scrollView.panGestureRecognizer.enabled = NO;
        }
    }
}

- (void)travelSubviewsOfView:(UIView *)view
{
    if (view == nil) {
        return;
    }
    NSLog(@"%@ isExclusiveTouch %d", NSStringFromClass([view class]), view.isExclusiveTouch);
    for (UIView * subview in view.subviews) {
        
        [self travelSubviewsOfView:subview];
    }
}

- (void)getPageVCAllVar
{
    unsigned int count = 0;
    Ivar * ivar = class_copyIvarList([UIPageViewController class], &count);
    
    for (int i = 0; i < count; i++) {
        
        const char * name = ivar_getName(ivar[i]);
        printf("%s\n", name);
    }
    printf("\n-----------------万能的分割线---------------\n\n");
    Method * method = class_copyMethodList([UIPageViewController class], &count);
    for (int i = 0; i < count; i++) {
        
        SEL sel = method_getName(method[i]);
        printf("%s\n", sel_getName(sel));
    }
}

- (void)sendMessage
{
    //objc_msgSend(self, NSSelectorFromString(@"_scrollView"));
    [self travelSubviewsOfView:self.view];
}

- (void)resetChildVCs
{
    [self setViewControllers:@[_myClVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
}

- (IBAction)messageButtonClicked:(id)sender
{
    [self sendMessage];
}

#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_myClVC]) {
        
        return _childVC;
    }else{
        return _myClVC;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_myClVC]) {
        
        return _childVC;
    }else{
        return _myClVC;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewDelayedTouchesBeganGestureRecognizer")]) {
        
        otherGestureRecognizer.delaysTouchesBegan = NO;
        return NO;
    }
    //[self getScrollView];
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
//    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
//
//    return YES;
//}

#pragma mark - Getter

- (UIPanGestureRecognizer *)test_panGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

#pragma mark - Handler touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesBegan :", NSStringFromClass([self class]));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesMoved :", NSStringFromClass([self class]));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesEnded :", NSStringFromClass([self class]));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touchesCancelled :", NSStringFromClass([self class]));
}


- (void)test_handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
    [self test_handlePanGesture:gestureRecognizer];
    
}

#pragma mark - Handle gesture recognizer

- (void)handlePan:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"UIGestureRecognizerStateChanged");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        case UIGestureRecognizerStateRecognized:
            NSLog(@"UIGestureRecognizerStateRecognized");
            break;
        default:
            break;
    }
}

@end
