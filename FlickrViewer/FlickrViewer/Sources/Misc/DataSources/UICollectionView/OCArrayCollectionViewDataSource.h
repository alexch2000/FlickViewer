//
//  OCArrayCollectionViewDataSource.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/25/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface OCArrayCollectionViewDataSource<__covariant CellType:UICollectionViewCell *, __covariant ObjectType> : NSObject <UICollectionViewDataSource>

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier cellClass:(Class)cellClass configurationBlock:(void(^)(CellType cell, ObjectType object))configuratBlock;
@property (nonatomic, readonly) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy, readonly) void(^configurationBlock)(CellType cell, ObjectType object);

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
