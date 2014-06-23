//
//  ViewController.m
//  MyImageViewController
//
//  Created by Vinay Raj on 15/06/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"
#import "ImageDataSource.h"
#import "EnlargeImageViewController.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *vwImgCollection;
@property (nonatomic, retain) NSArray *cameraImages;
@property (nonatomic, retain) ALAsset *selectedAsset;

@property (strong, nonatomic) IBOutlet ImageDataSource *ImageDataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Log : Loaded");
    
    
    self.navigationItem.hidesBackButton = YES;
    self.vwImgCollection.delegate = self;

    // Data source has been assigned to new custom delegate class here
    
    self.vwImgCollection.dataSource = self.ImageDataSource;
    
    
    [self.ImageDataSource reloadContentsViewController:self success:^(NSArray *assetList)
     {
         self.cameraImages = assetList;
     }failure:^(NSError *error)
     {
         NSLog(@"Log : Could not fetch images from camera roll");
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedAsset = (ALAsset*)self.cameraImages[indexPath.row];
    [self performSegueWithIdentifier:@"enlarge" sender:self];
   // NSLog(@"Log : Selected image is at index - %d", indexPath.row);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"enlarge"] )
    {
        EnlargeImageViewController *enlargeVw = (EnlargeImageViewController*)segue.destinationViewController;
        enlargeVw.enlargedAsset = self.selectedAsset;
        
    }
}

@end
