//
//  MyLayout.m
//  WaterFall
//
//  Created by Gaoming on 16/10/11.
//
//

#import "MyLayout.h"

@implementation MyLayout
{
    NSMutableArray *_attributesArray;
    NSMutableArray *_columnHeights;
}
- (void)prepareLayout
{
    _attributesArray = [[NSMutableArray alloc] init];
    _columnHeights = [[NSMutableArray alloc] init];
    [super prepareLayout];
    //演示方便 我们设置为静态的2列
    //计算每一个item的宽度
//    float WIDTH = ([UIScreen mainScreen].bounds.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing)/2;
    float WIDTH = 100;
    //定义数组保存每一列的高度
    //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
    CGFloat colHight[2]={self.sectionInset.top,self.sectionInset.bottom};
    //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
    for (int i=0; i<_itemCount; i++) {
        //设置每个item的位置等相关属性
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        //创建一个布局属性类，通过indexPath来创建
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        //随机一个高度 在40——190之间
        CGFloat hight = arc4random()%150+40;
        //哪一列高度小 则放到那一列下面
        //标记最短的列
        int width=0;
        if (colHight[0]<colHight[1]) {
            //将新的item高度加入到短的一列
            colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
            width=0;
        }else{
            colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
            width=1;
        }
        
        //设置item的位置
        attris.frame = CGRectMake(self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*width, colHight[width]-hight-self.minimumLineSpacing, 100, 100);
        [_attributesArray addObject:attris];
    }

    //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
    if (colHight[0]>colHight[1]) {
        self.itemSize = CGSizeMake(WIDTH, (colHight[0]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }else{
        self.itemSize = CGSizeMake(WIDTH, (colHight[1]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributesArray;
}



//- (CGSize)collectionViewContentSize
//{
//    return CGSizeMake(400, 1000);
//}

@end
