//
//  LCZoomTransition.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/14/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

@import UIKit;

@protocol LCZoomTransitionGestureTarget <NSObject>

- (void) handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer;
- (void) handleEdgePan:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer;

@end

@interface LCZoomTransition : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate, LCZoomTransitionGestureTarget>

- (instancetype)initWithNavigationController:(UINavigationController *)nc;

@property (nonatomic, strong) UIView *sourceView;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) CGFloat transitionDuration;

@property(nonatomic,assign) UINavigationController *parent;
@property(nonatomic,assign,getter = isInteractive) BOOL interactive;


@end
