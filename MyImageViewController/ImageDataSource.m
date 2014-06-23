//
//  ImageDataSource.m
//  MyImageViewController
//
//  Created by Vinay Raj on 23/06/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "ImageDataSource.h"
#import "ImageCell.h"
#import "EnlargeImageViewController.h"

@interface ImageDataSource()
@property (nonatomic, retain) ViewController *controller;
@property(nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (weak, nonatomic) IBOutlet UICollectionView *vwImgCol;
@property (nonatomic, retain)ALAsset *selectedAsset;
@end



@implementation ImageDataSource

-(void)reloadContentsViewController : (ViewController*)controller
                           success  :(void (^)(NSArray *assetList))success
                             failure:(void (^)(NSError *error))failure
{
    self.controller = controller;
    [self loadAssetsFromCameraRoll:^(NSArray *assetList)
    {
        self.imagesArray = [assetList mutableCopy];
        [self.vwImgCol reloadData];
     
        success(assetList);
        
    }failure:^(NSError *error)
    {
        failure(error);
    }];
}

-(void)loadAssetsFromCameraRoll:(void (^)(NSArray *assetList))success
                        failure:(void (^)(NSError *error))failure
{
    
    NSMutableArray *filteredUniquePhotos = [NSMutableArray array];
    
    // Log Access Denial Errors
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) { failure(error); };
    
    // Block for enumerating individual videos from groups
    ALAssetsGroupEnumerationResultsBlock enumerationBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        
        
        if( asset != nil )
            [filteredUniquePhotos addObject:asset];
        else
            success( filteredUniquePhotos );
        
    };
    
    // emumerate through our groups and only add groups that contain videos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsUsingBlock:enumerationBlock];
    };
    
    // Alloc if existing library is nil
    if (self.assetsLibrary == nil)
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:listGroupBlock failureBlock:failureBlock];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *cell = (ImageCell*)[cv dequeueReusableCellWithReuseIdentifier:@"ImageStaticCell" forIndexPath:indexPath];
    
    ALAsset *asset = (ALAsset*)self.imagesArray[indexPath.row];
    cell.image.image = [UIImage imageWithCGImage:asset.thumbnail];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return self.imagesArray.count;
}

@end
