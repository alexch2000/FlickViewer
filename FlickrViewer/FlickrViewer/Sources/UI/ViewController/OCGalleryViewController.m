//
//  OCGalleryViewController.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCGalleryViewController.h"
#import "OCGalleryCollectionViewCell.h"
#import "OCFlickrService.h"
#import "OCFlickrRequest+Search.h"
#import "OCGalleryCollectionViewCell.h"

#import "OCGalleryViewModel.h"
#import "OCPhotoViewModel.h"

#import "OCArrayCollectionViewDataSource.h"

static NSString * const sReuseIdentifier = @"ReuseIdentifier";

@interface OCGalleryViewController () <
UISearchResultsUpdating,
OCGalleryViewModelDelegate,
UICollectionViewDelegate
>

@property (nonatomic) UISearchController *searchImageController;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) OCImageProvider *imageProvider;
@property (nonatomic) UILabel *emptySearchResultsLabel;

@property (nonatomic) OCArrayCollectionViewDataSource<OCGalleryCollectionViewCell *, id<OCPhotoViewModel>> *dataSource;

@end

@implementation OCGalleryViewController

- (instancetype)initWithViewModel:(id<OCGalleryViewModel>)viewModel imageProvider:(OCImageProvider *)imageProvider {
    NSParameterAssert(viewModel);
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _galleryViewModel = viewModel;
        _galleryViewModel.delegate = self;
        _imageProvider = imageProvider;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Gallery", @"Gallery Title");
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    [self setupCollectionView];
    [self setupSearchController];
    [self setupEmptyLabel];
    [self setupDataSource:self.collectionView];
}

- (void)setupEmptyLabel {
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = NSLocalizedString(@"Enter text to find images", @"Enter text caption");
    
    [self.view addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
                                              [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              ]
     ];
    self.emptySearchResultsLabel = label;
}

- (void)setupCollectionView {
    [self setupFlowLayout];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.delegate = self;

    [self.view addSubview:collectionView];
    [NSLayoutConstraint activateConstraints:@[
                                            [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                            [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                            ]
     ];
    
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setupDataSource:(UICollectionView *)collectionView {
    _dataSource = [[OCArrayCollectionViewDataSource alloc] initWithCollectionView:collectionView
                                                                  reuseIdentifier:sReuseIdentifier
                                                                        cellClass:[OCGalleryCollectionViewCell class]
                                                               configurationBlock:^(UICollectionViewCell * _Nonnull cell, id  <OCPhotoViewModel>_Nonnull object) {
                                                                   OCGalleryCollectionViewCell *photoCell = (OCGalleryCollectionViewCell *)cell;
                                                                   photoCell.imageProvider = self.imageProvider;
                                                                   photoCell.imageURL = object.photoURL;
                                                               }];
}

- (void)setupFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout = flowLayout;
}

- (void)updateCellSize {
    self.flowLayout.minimumInteritemSpacing = 10.0;
    CGFloat cellSize = (CGRectGetWidth(self.collectionView.bounds) - 30.0f) / 3.0;
    self.flowLayout.itemSize = CGSizeMake(cellSize, cellSize);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateCellSize];
}

- (void)setupSearchController {
    self.searchImageController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchImageController.obscuresBackgroundDuringPresentation = NO;
    self.searchImageController.dimsBackgroundDuringPresentation = NO;
    self.searchImageController.searchResultsUpdater = self;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchImageController;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        // Fallback on earlier versions
        self.navigationItem.titleView = self.searchImageController.searchBar;
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.galleryViewModel newSearchForText:searchController.searchBar.text];
}

- (void)galleryViewModel:(id<OCGalleryViewModel>)model didAppendPhotos:(NSArray<id<OCPhotoViewModel>> *)photos {
    self.dataSource.array = model.photos;
}

- (void)galleryViewModelDidStartNewSearch:(id<OCGalleryViewModel>)model {
    [self.collectionView setScrollsToTop:YES];
    self.dataSource.array = model.photos;
    self.emptySearchResultsLabel.hidden = [model.searchText length] != 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *lastIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSInteger threshold = MAX((NSInteger)( (double)self.galleryViewModel.photos.count * 0.6 ), self.galleryViewModel.photos.count - 100);
    if (lastIndexPath.row > threshold) {
        [self.galleryViewModel loadNextPage];
    }
}

@end

