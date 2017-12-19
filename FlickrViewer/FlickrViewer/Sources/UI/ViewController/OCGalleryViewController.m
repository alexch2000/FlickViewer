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

static NSString * const sReuseIdentifier = @"ReuseIdentifier";

@interface OCGalleryViewController () <
UICollectionViewDataSource,
UISearchResultsUpdating,
OCGalleryViewModelDelegate,
UICollectionViewDelegate
>

@property (nonatomic) UISearchController *searchImageController;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) OCImageProvider *imageProvider;
@property (nonatomic) UILabel *emptySearchResultsLabel;

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
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[OCGalleryCollectionViewCell class] forCellWithReuseIdentifier:sReuseIdentifier];
    [self.view addSubview:collectionView];
    
    [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.galleryViewModel.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OCGalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sReuseIdentifier forIndexPath:indexPath];
    
    cell.imageProvider = self.imageProvider;
    cell.imageURL = self.galleryViewModel.photos[indexPath.row].photoURL;
    
    return cell;
}

- (void)galleryViewModel:(id<OCGalleryViewModel>)model didAppendPhotos:(NSArray<id<OCPhotoViewModel>> *)photos {
    [self.collectionView reloadData];
}

- (void)galleryViewModelDidStartNewSearch:(id<OCGalleryViewModel>)model {
    [self.collectionView setScrollsToTop:YES];
    [self.collectionView reloadData];
    self.emptySearchResultsLabel.hidden = [model.searchText length] != 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *lastIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSInteger threshold = (NSInteger)( (double)self.galleryViewModel.photos.count * 0.6 );
    if (lastIndexPath.row > threshold) {
        [self.galleryViewModel loadNextPage];
    }
}

@end
