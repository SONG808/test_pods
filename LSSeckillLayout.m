//
//  LSSeckillLayout.m
//  SchoolMakeUp
//
//  Created by 木木木公 on 2017/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LSSeckillLayout.h"

@interface LSSeckillLayout()
@end

@implementation LSSeckillLayout
- (void)prepareLayout {
    
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat inset_width = 30;
    CGFloat item_width  = width-2*inset_width;
    CGFloat item_height = item_width*(9.0/20);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(0, inset_width, 0, inset_width);
    self.itemSize = CGSizeMake(item_width,item_height);
    
    if (self.index != 0 && self.previousOffsetX == 0) {
        self.previousOffsetX = self.index*(self.itemSize.width+self.minimumLineSpacing);
        [self.collectionView setContentOffset:CGPointMake(self.previousOffsetX, 0) animated:NO];
    }
    
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.frame.size.width,
                                    self.collectionView.frame.size.height);
    CGFloat offset = CGRectGetMidX(visibleRect);
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = offset - attribute.center.x;
        // 越往中心移动，值越小，那么缩放就越小，从而显示就越大
        // 同样，超过中心后，越往左、右走，缩放就越大，显示就越小
        CGFloat scaleForDistance = distance / self.itemSize.height;
        // 0.2可调整，值越大，显示就越大
        CGFloat scaleForCell = 1 + 0.1 * (1 - fabs(scaleForDistance));
        
        // only scale y-axisr
        attribute.transform3D = CATransform3DMakeScale(1, scaleForCell>1?1:scaleForCell, 1);
        attribute.alpha = scaleForCell;
        attribute.zIndex = 1;
    }];
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 分页以1/3处
    if (proposedContentOffset.x > self.previousOffsetX + self.itemSize.width / 3.0) {
        self.previousOffsetX += self.itemSize.width + self.minimumLineSpacing;
    } else if (proposedContentOffset.x < self.previousOffsetX  - self.itemSize.width / 3.0) {
        self.previousOffsetX -= self.itemSize.width + self.minimumLineSpacing;
    }
    
    proposedContentOffset.x = self.previousOffsetX;
    return proposedContentOffset;
}

@end
