//
//  ELAppDelegate.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/29/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;





/*
 
 Criteria
 
 iOS project written in Objective-C OR Swift
 
 Connects to an open photo API (Flickr or 500px)
 
 Uses a UITableView to display a minimum of 20 images from the API each within a custom UITableViewCell
 
 Lazy loads images as you scroll down the UITableView using NSOperations in an NSOperationQueue to load images in the background
 
 Caches images so they are only downloaded once
 
 Should be able to scroll smoothly
 
 Should be able to click a single cell to see a full screen image... preferably with a nice transition
 
 */

@end
