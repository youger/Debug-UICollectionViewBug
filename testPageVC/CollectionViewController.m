//
//  CollectionViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/16/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.frame = CGRectMake(0, _top, self.view.bounds.size.width, self.view.bounds.size.height - _top);
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(justForTest:)];
    pan.delegate = self;
    [self.collectionView addGestureRecognizer:pan];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"gestureRecognizer %@: %@",NSStringFromClass([gestureRecognizer class]), NSStringFromClass([gestureRecognizer.view class]));
    NSLog(@"otherGestureRecognizer %@: %@",NSStringFromClass([otherGestureRecognizer class]), otherGestureRecognizer.view);
    NSLog(@"delaysTouchesBegan %d", otherGestureRecognizer.delaysTouchesBegan);
    printf("\n");
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewDelayedTouchesBeganGestureRecognizer")]) {
        
        //otherGestureRecognizer.delaysTouchesBegan = NO;
        //return NO;
    }
    //[self getScrollView];
    return YES;
}

- (void)justForTest:(id)sender
{}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor brownColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-collectionView:didSelectItemAtIndexPath %@", indexPath);
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}

@end
