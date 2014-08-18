//
//  ELPictureViewController.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELPictureViewController.h"
#import "UIColor+Colors.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    CAShapeLayer *shapeView = [[CAShapeLayer alloc] init];
    [shapeView setPath:[self createLine].CGPath];
    [[self.view layer] addSublayer:shapeView];

    CAShapeLayer *shapeView2 = [[CAShapeLayer alloc] init];
    [shapeView2 setPath:[self createSecondLine].CGPath];
    [[self.view layer] addSublayer:shapeView2];
    
    self.locationLabel.text = self.picture.location;


    NSLog(@"Selected location: %@", self.picture.location);
    [self buildPictureView:self.picture];

    //Custom transition methods:
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.gestureTarget action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.gestureTarget action:@selector(handleEdgePan:)];
    edgePanRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanRecognizer];
    
    
}

- (UIBezierPath*)createLine
{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100.0, 500.0)];
    [path addLineToPoint:CGPointMake(300.0, 500.0)];
    [path addLineToPoint:CGPointMake(300.0, 502.0)];
    [path addLineToPoint:CGPointMake(100.0, 502.0)];
    [path closePath];
    return path;
}

- (UIBezierPath*)createSecondLine
{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150.0, 515.0)];
    [path addLineToPoint:CGPointMake(300.0, 515.0)];
    [path addLineToPoint:CGPointMake(300.0, 517.0)];
    [path addLineToPoint:CGPointMake(150.0, 517.0)];
    [path closePath];
    return path;
}

-(void)buildPictureView: (Picture *)picture
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);
    dispatch_async(fetchQ, ^{
        
        NSURL *address = [NSURL URLWithString:picture.standardLink];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

- (void)drawRect:(CGRect)rect
{
    // Create an oval shape to draw.
    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:
                           CGRectMake(0, 0, 200, 100)];
    
    // Set the render colors.
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    //CGContextSaveGState(aRef);
    
    // Adjust the view's origin temporarily. The oval is
    // now drawn relative to the new origin point.
    CGContextTranslateCTM(aRef, 50, 50);
    
    // Adjust the drawing options as needed.
    aPath.lineWidth = 5;
    
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
    
    // Restore the graphics state before drawing any other content.
    //CGContextRestoreGState(aRef);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
