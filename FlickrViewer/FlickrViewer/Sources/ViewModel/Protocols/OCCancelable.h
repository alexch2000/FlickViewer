//
//  OCCancelProtocol.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/26/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCCancelable <NSObject>

- (void)cancel;

@end
