//
//  ELConstants.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/29/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const INSTAGRAM_REDIRECT_URI;
extern NSString* const INSTAGRAM_API_URL;
extern NSString* const INSTAGRAM_CLIENT_ID;

@interface ELConstants : NSObject

- (NSURL *)urlForAccessToken;

@end
