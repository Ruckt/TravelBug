//
//  ELInstagramConsoleViewController.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/29/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELInstagramConsoleViewController.h"
#import "ELDataStore.h"
#import "ELConstants.h"
#import "Picture+Methods.h"
#import "ELThumbnailListViewController.h"
#import "ELPictureDataProvider.h"

@interface ELInstagramConsoleViewController ()

@property (strong, nonatomic) ELDataStore *dataStore;
@property (strong, nonatomic) ELPictureDataProvider *dataProvider;

@property (strong, nonatomic) UIWebView *consoleWebView;
@property (strong, nonatomic) ELConstants *constantMethods;
@property (strong, nonatomic) NSString *stringAccessToken;

@property (strong, nonatomic) NSArray *mediaObjects;

@end

@implementation ELInstagramConsoleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.dataStore = [ELDataStore sharedELDataStore];
        self.constantMethods = [[ELConstants alloc] init];
        self.dataProvider = [[ELPictureDataProvider alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //[self.dataProvider fetchPictures];

    
    self.consoleWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.consoleWebView.delegate = self;
    
    [self loadURL];
    [self.view addSubview:self.consoleWebView];
    
    self.title = @"Popular Pictures";
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadURL{
    
    NSURL *tokenURL = [self.constantMethods urlForAccessToken];
    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
    //NSLog(@"load URL: %@", tokenURL);
    [self.consoleWebView loadRequest:request];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString* urlString = [[request URL] absoluteString];
    NSString *responsePrefix = @"ios-app://redirect?code=";
    //NSLog(@"URL STRING : %@ ",urlString);
    
    NSRange tokenParam = [urlString rangeOfString: responsePrefix];
    if (tokenParam.location != NSNotFound)
    {
        self.stringAccessToken = [urlString stringByReplacingOccurrencesOfString:responsePrefix withString:@""];
        //NSLog(@"AccessToken = %@ ",self.stringAccessToken);
 
        self.consoleWebView.hidden = YES;
        
    //    [self segueToListView];
    [self fetchPopularMediaWithCompletionBlock:^(BOOL success) {}];
    }

    return YES;
}


#pragma mark - Navigation

-(void)segueToListView {
    ELThumbnailListViewController *thumbnailListViewController = [[ELThumbnailListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:thumbnailListViewController animated:YES];
}


#pragma mark - image downloading

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock
{
    
    NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=10",ID_MATT_GEE, INSTAGRAM_CLIENT_ID];
    //NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", INSTAGRAM_CLIENT_ID];
    NSURL *URL = [NSURL URLWithString:instagramEndpoint];
    //NSLog(@"Response URL : %@ ",instagramEndpoint);
   
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        NSError *JSONParseError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONParseError];
        //NSLog(@"dictionary: %@", dictionary);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error || JSONParseError || httpResponse.statusCode != 200 || dictionary == nil)
        {
            completionBlock(NO);
        }
        else
        {
            [self pictureParsedFromResponse:dictionary];
            completionBlock(YES);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self segueToListView];
        });
    }];
    [task resume];
}

- (void)pictureParsedFromResponse:(NSDictionary *)dictionary
{
    
    NSDictionary *subDictionary = [dictionary objectForKey:@"data"];
    
    for (NSDictionary *eachPictureInfo in subDictionary) {
        
        NSString *picutreID = [eachPictureInfo objectForKey:@"id"];
       
        NSDictionary *imageInfo = [eachPictureInfo objectForKey:@"images"];
        NSDictionary *thumbnailInfo = [imageInfo objectForKey:@"thumbnail"];
        NSString *thumbnailLink = [thumbnailInfo objectForKey:@"url"];
        
        NSDictionary *standardInfo = [imageInfo objectForKey:@"standard_resolution"];
        NSString *standardLink = [standardInfo objectForKey:@"url"];
        
        NSString *location = [eachPictureInfo objectForKey:@"location"];
        NSLog(@"Location %@", location);
        
        Picture *picture = [Picture pictureID:picutreID thumbnailURL:thumbnailLink andStandardURL:standardLink inManagedObjectContext:self.dataStore.managedObjectContext];
        [self.dataStore addPicture:picture];
        
      // NSLog(@"Picture Info %@", eachPictureInfo);
//        NSLog(@"Thumbnail %@", thumbnailLink);
//        NSLog(@"Standard %@", standardLink);
    }
}




@end
