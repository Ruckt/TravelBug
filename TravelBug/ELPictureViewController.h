//
//  ELPictureViewController.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture+Methods.h"
#import "LCZoomTransition.h"

@interface ELPictureViewController : UIViewController

@property (strong, nonatomic) Picture *picture;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) id<LCZoomTransitionGestureTarget> gestureTarget;

@end
