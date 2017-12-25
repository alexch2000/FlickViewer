//
//  OCArrayCollectionViewDataSource.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/25/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCArrayCollectionViewDataSource.h"

@implementation OCArrayCollectionViewDataSource

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier cellClass:(Class)cellClass configurationBlock:(void(^)(UICollectionViewCell *cell, id object))configurationBlock {
    self = [super init];
    NSParameterAssert(collectionView);
    NSParameterAssert(cellClass);
    NSParameterAssert(reuseIdentifier);
    NSParameterAssert(configurationBlock);
    
    if (self) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _reuseIdentifier = [reuseIdentifier copy];
        
        [_collectionView registerClass:cellClass forCellWithReuseIdentifier:_reuseIdentifier];
        [_collectionView reloadData];
        
        _configurationBlock = [configurationBlock copy];
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_reuseIdentifier forIndexPath:indexPath];
    _configurationBlock(cell, self.array[indexPath.row]);
    return cell;
}

- (void)setArray:(NSArray *)array {
    if (![_array isEqualToArray:array]) {
        _array = [array copy];
        [_collectionView reloadData];
    }
}

@end
