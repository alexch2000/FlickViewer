//
//  OCGalleryCollectionViewCell.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCGalleryCollectionViewCell.h"
#import "OCAsyncCall.h"
#import "OCImageProvider.h"

@interface OCGalleryCollectionViewCell()

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) OCAsyncCall *currentImageCall;

@end

@implementation OCGalleryCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
    
    self.imageView.clipsToBounds = YES;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.activityIndicatorView];
    
    [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.activityIndicatorView startAnimating];
    self.backgroundColor = [UIColor grayColor];
}

- (void)setImage:(UIImage * _Nullable)image animated:(BOOL)animated {
    self.imageView.image = image;
    BOOL showImageView = image != nil;
    void(^updateUIBlock)(void) = ^{
        if (showImageView) {
            self.imageView.alpha = 1.0;
            self.activityIndicatorView.alpha = 0.0;
        } else {
            self.imageView.alpha = .0;
            self.activityIndicatorView.alpha = 1.0;
            [self.activityIndicatorView startAnimating];
        }
    };
    if (animated) {
        [UIView animateWithDuration:0.35 animations:updateUIBlock];
    } else {
        updateUIBlock();
    }
}

- (void)setImageURL:(NSURL *)imageURL {
    if (_imageURL != imageURL) {
        [self.currentImageCall cancel];
        if ([self.imageProvider hasImageForURL:imageURL]) {
            [self setImage:[self.imageProvider imageForURL:imageURL] animated:NO];
        } else {
            self.currentImageCall = [self.imageProvider loadImageForURL:imageURL finishBlock:^(UIImage *result, NSError *error) {
                if (error == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [self setImage:result animated:YES];
                    });
                } else {
                    NSLog(@"%@", error);
                }
            }];
            [self setImage:nil animated:NO];
        }
    }
}

@end

