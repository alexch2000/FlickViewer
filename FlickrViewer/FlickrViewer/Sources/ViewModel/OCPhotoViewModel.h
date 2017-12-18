//
//  OCPhotoViewModel.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import Foundation;

@protocol OCPhotoViewModel <NSObject>
@property (nonatomic, readonly, nonnull) NSURL *photoURL;
@end

