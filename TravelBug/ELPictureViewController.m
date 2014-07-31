//
//  ELPictureViewController.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELPictureViewController.h"

static NSInteger const STANDARD_WIDTH = 320;
static NSInteger const STANDARD_HEIGHT = 320;
static NSInteger const STANDARD_X = 0;
static NSInteger const STANDARD_Y = 124;


@interface ELPictureViewController ()

@property (strong, nonatomic) Picture *picture;
@end

@implementation ELPictureViewController


- (ELPictureViewController *)initWithPicture:(Picture *)aPicture {
    self = [super init];
    if (self) {
        self.picture = aPicture;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    UIImageView *imageView = [self buildPictureView:self.picture];

    [self.view addSubview:imageView];
}



-(UIImageView *)buildPictureView: (Picture *)picture
{
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(STANDARD_X, STANDARD_Y, STANDARD_WIDTH, STANDARD_HEIGHT)];
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);
    dispatch_async(fetchQ, ^{
        
        NSURL *address = [NSURL URLWithString:picture.standardLink];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
    
    
    return imageView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
