//
//  PageViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/16/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "PageViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
#import "ChildViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface PageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) CollectionViewController * clVC;
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
    _clVC.inPageVC = YES;
    _tbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    _childVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
    
    self.dataSource = self;
    self.delegate = self;
    [self setViewControllers:@[_clVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self getPageVCAllVar];
    [self getScrollView];
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
}

- (void)resetChildVCs
{
    [self setViewControllers:@[_clVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
}

- (IBAction)messageButtonClicked:(id)sender
{
    [self sendMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_clVC]) {
        
        return _childVC;
    }else{
        return _clVC;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_clVC]) {
        
        return _childVC;
    }else{
        return _clVC;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan :");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved :");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded :");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled :");
}

- (void)test_handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
    [self test_handlePanGesture:gestureRecognizer];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
//    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewDelayedTouchesBeganGestureRecognizer")]) {
//        
//        return NO;
//    }
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
//    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
//    
//    return YES;
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
