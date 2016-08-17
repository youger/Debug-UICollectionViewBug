//
//  ScrollViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/17/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "ScrollViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
#import "ChildViewController.h"

@interface ScrollViewController ()

@property (strong, nonatomic) CollectionViewController * clVC;
@property (strong, nonatomic) TableViewController * tbVC;
@property (strong, nonatomic) ChildViewController * childVC;

@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    navigationView.backgroundColor = [UIColor colorWithRed:235./255 green:235./255 blue:235/255.f alpha:1];
    [self.view addSubview:navigationView];
    
    _clVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    _clVC.inPageVC = YES;
    _tbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    _childVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];

    [self addChildViewController:_clVC];
    [self.scrollView addSubview:_clVC.view];
    [_clVC didMoveToParentViewController:self];
    
    [self addChildViewController:_tbVC];
    CGRect secondViewFrame = self.view.frame;
    secondViewFrame.origin.x = self.view.bounds.size.width;
    _tbVC.view.frame = secondViewFrame;
    [self.scrollView addSubview:_tbVC.view];
    
    [_tbVC didMoveToParentViewController:self];
    
    self.scrollView.contentSize = CGSizeMake(2 * self.view.bounds.size.width, self.view.bounds.size.height);
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
