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


@end

@implementation ELPictureViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (ELPictureViewController *)initWithPicture:(Picture *)aPicture {
//    self = [super init];
//    if (self) {
//        self.picture = aPicture;
//    }
//    
//    return self;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationLabel.text = self.picture.location;
    
    NSLog(@"Selected location: %@", self.picture.location);

    //[self.view setBackgroundColor: [UIColor whiteColor]];
    
    [self buildPictureView:self.picture];

    // setup a pinch gesture recognizer and make the target the custom transition handler
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.gestureTarget action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    // setup an edge pan gesture recognizer and make the target the custom transition handler
    UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.gestureTarget action:@selector(handleEdgePan:)];
    edgePanRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanRecognizer];
}



-(void)buildPictureView: (Picture *)picture
{
    
    //UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(STANDARD_X, STANDARD_Y, STANDARD_WIDTH, STANDARD_HEIGHT)];
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);
    dispatch_async(fetchQ, ^{
        
        NSURL *address = [NSURL URLWithString:picture.standardLink];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });

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
