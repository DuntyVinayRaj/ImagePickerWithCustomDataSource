//
//  EnlargeImageViewController.m
//  MyImageViewController
//
//  Created by Vinay Raj on 15/06/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "EnlargeImageViewController.h"

@interface EnlargeImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *enlargeImage;

@end

@implementation EnlargeImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.enlargeImage.image = [UIImage imageWithCGImage:[self.enlargedAsset.defaultRepresentation fullScreenImage]
                                                  scale:[self.enlargedAsset.defaultRepresentation scale] orientation:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
