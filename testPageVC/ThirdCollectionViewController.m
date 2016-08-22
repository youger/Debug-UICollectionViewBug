//
//  ThirdCollectionViewController.m
//  testPageVC
//
//  Created by Jingyue on 8/22/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

#import "ThirdCollectionViewController.h"

static NSString * const reuseIdentifier = @"Cell";

@interface ThirdCollectionViewController ()

@end

@implementation ThirdCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PSTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"third -collectionView:didSelectItemAtIndexPath %@", indexPath);
}

@end
