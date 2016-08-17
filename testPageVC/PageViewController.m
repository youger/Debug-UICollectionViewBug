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
    sendMessageButton.center = navigationView.center;
    
    _clVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    _clVC.inPageVC = YES;
    _tbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    _childVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
    
    self.dataSource = self;
    self.delegate = self;
    [self setViewControllers:@[_clVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self getPageVCAllVar];
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
    objc_msgSend(self, NSSelectorFromString(@"_scrollView"));
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
