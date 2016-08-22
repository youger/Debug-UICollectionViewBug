#testPageVC
###Bug描述：

UICollectionView在多层嵌套的UIPageViewController中，初始稍微滚动PageViewController,UICollectionView 的代理方法```- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath```会失效

###临时解决方法:

设置所有ScrollView的UIScrollViewDelayedTouchesBeganGestureRecognizer手势delaysTouchesBegan 为 NO。

###原因:

