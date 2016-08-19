//
//  ViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/16/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
#import "PageViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) PageViewController * childPageVC;
@property (strong, nonatomic) ScrollViewController * scrollVC;
@property (strong, nonatomic) CollectionViewController * clVC;
@property (strong, nonatomic) TableViewController * tbVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    [resetButton sizeToFit];
    resetButton.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - 80)/2, CGRectGetHeight(self.view.bounds)- 120, 80, 80);
    resetButton.layer.cornerRadius = 40.f;
    
    UIPageViewController * pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    _childPageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    _scrollVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScrollViewController"];
    _clVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    _tbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    
    pageVC.dataSource = self;
    pageVC.delegate = self;
    [pageVC setViewControllers:@[_childPageVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    
    [pageVC didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:resetButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetButtonClicked:(id)sender
{
    UIViewController * initialViewController = [self.storyboard instantiateInitialViewController];
    [[UIApplication sharedApplication].keyWindow setRootViewController:initialViewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_clVC]) {
        
        return _childPageVC;
    }else{
        return _clVC;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isEqual:_clVC]) {
        
        return _childPageVC;
    }else{
        return _clVC;
    }
}

@end
