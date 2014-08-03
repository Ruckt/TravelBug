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

extern NSString* const ID_PETE_HALVORSEN;
extern NSString* const ID_MATT_GEE;
extern NSString* const ID_ZACH_GLASSMAN;
extern NSString* const ID_JORDAN_HERSCHEL;
extern NSString* const ID_CHRIS_BURKARD;
extern NSString* const ID_OLIVER_VEGAS;

@interface ELConstants : NSObject

- (NSURL *)urlForAccessToken;

@end
