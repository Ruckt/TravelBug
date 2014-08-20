//
//  ELPictureDataProvider.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/31/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELPictureDataProvider.h"
#import "ELDataStore.h"
#import "ELConstants.h"
#import "Picture+Methods.h"
#import <AFNetworking.h>

@interface ELPictureDataProvider()

@property (nonatomic, strong) ELDataStore *dataStore;

@end



@implementation ELPictureDataProvider

- (id)init {
    _dataStore = [ELDataStore sharedELDataStore];
    return self;
}

- (void)fetchPicturesWithCompletionHandler:(void(^)(NSArray* images, NSError *error))completionHandler {
    NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=25",ID_ZACH_GLASSMAN, INSTAGRAM_CLIENT_ID];
    //NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@&count=30", INSTAGRAM_CLIENT_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:instagramEndpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSArray *pictures = [self pictureObjectsFromResponse:responseDictionary];
        if (completionHandler) {
            completionHandler(pictures,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}

/*
[dataProvider fetchPicturesWithCompletionHandler:^(NSArray *images, NSError *error) {
    if (error) {
    self.pictures = images;
 */
    
    
//- (void)performMultiplePictureRequestsWithCompletionHandler:(void(^)(NSArray* images, NSError *error))completionHandler {
- (void)performMultiplePictureRequestsWithCompletionHandler{
    NSString *photographer1 = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=10",ID_ZACH_GLASSMAN, INSTAGRAM_CLIENT_ID];
    NSURL *instagramEndpoint1 = [[NSURL alloc] initWithString:photographer1];
    NSString *photographer2 = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=10",ID_CHRIS_BURKARD, INSTAGRAM_CLIENT_ID];
    NSURL *instagramEndpoint2 = [[NSURL alloc] initWithString:photographer2];
    
    NSString *photographer3 = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=10",ID_MATT_GEE, INSTAGRAM_CLIENT_ID];
    NSURL *instagramEndpoint3 = [NSURL URLWithString:photographer3];
    
    NSArray *instragramEndpoints = [NSArray arrayWithObjects:instagramEndpoint1, instagramEndpoint2, instagramEndpoint3, nil];
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    
    for (NSURL *photographerURL in instragramEndpoints) {
        NSURLRequest *request = [NSURLRequest requestWithURL:photographerURL];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [mutableOperations addObject:operation];
        
    }
    
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/resources/123.json"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    op.responseSerializer = [AFJSONResponseSerializer serializer];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [[NSOperationQueue mainQueue] addOperation:op];

    
    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);
    }
                                   
                                                                     completionBlock:^(NSArray *operations) {
                                                                         NSLog(@"All operations in batch complete");
                                                                         
                                                                         NSError *error;
                                                                         for (AFHTTPRequestOperation *op in operations) {
                                                                             if (op.isCancelled){
                                                                                 return ;
                                                                             }
                                                                             if (op.responseObject){
                                                                                 NSLog(@"Response object: %@", op.responseObject);
                                                                                 // process your responce here
                                                                             }
                                                                             if (op.error){
                                                                                 error = op.error;
                                                                             }
                                                                         }
                                                                     }];
    
    [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
    NSLog(@"Operations: %@",operations);
}




// Returns picture objects from a single response.
- (NSArray *)pictureObjectsFromResponse:(NSDictionary *)dictionary
{
    NSDictionary *subDictionary = [dictionary objectForKey:@"data"];
    NSMutableArray *resultPictures = [NSMutableArray new];
    for (NSDictionary *eachPictureInfo in subDictionary) {
        NSString *pictureID = [eachPictureInfo objectForKey:@"id"];
        
        NSDictionary *imageInfo = [eachPictureInfo objectForKey:@"images"];
        NSDictionary *thumbnailInfo = [imageInfo objectForKey:@"thumbnail"];
        NSString *thumbnailLink = [thumbnailInfo objectForKey:@"url"];
        
        NSDictionary *standardInfo = [imageInfo objectForKey:@"standard_resolution"];
        NSString *standardLink = [standardInfo objectForKey:@"url"];
        
        //NSLog(@"Location Info %@", locationInfo);
        
        NSString *location = @"Paradise";
        if ([eachPictureInfo objectForKey:@"location"] != [NSNull null]) {
            NSDictionary *locationInfo = [eachPictureInfo objectForKey:@"location"];
            location = [locationInfo objectForKey:@"name"];
            NSLog(@"Location %@", location);
        }

        Picture *picture = [Picture pictureID:pictureID thumbnailURL:thumbnailLink andStandardURL:standardLink atLocation:location inManagedObjectContext:self.dataStore.managedObjectContext];
        [resultPictures addObject:picture];
    }
    return resultPictures;
}



@end
