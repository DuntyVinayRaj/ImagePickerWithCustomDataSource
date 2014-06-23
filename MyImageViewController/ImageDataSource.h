//
//  ImageDataSource.h
//  MyImageViewController
//
//  Created by Vinay Raj on 23/06/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface ImageDataSource : NSObject<UICollectionViewDataSource>

-(void)reloadContentsViewController : (ViewController*)controller
                           success  :(void (^)(NSArray *assetList))success
                             failure:(void (^)(NSError *error))failure;

@end
