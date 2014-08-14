//
//  ELMainPictureTableViewController
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELMainPictureTableViewController.h"
#import "ELCustomThumbnailTableViewCell.h"
#import "ELPictureViewController.h"
#import "ELDataStore.h"
#import "ELPictureDataProvider.h"

static NSString *CellIdentifier = @"Cell";

@interface ELMainPictureTableViewController ()

@property (strong, nonatomic) ELDataStore *dataStore;
@property (strong, nonatomic) NSArray *pictures;

@end

@implementation ELMainPictureTableViewController

//- (id)initWithStyle:(UITableViewStyle)style {
//    self = [super initWithStyle:style];
//    if (self) {
//        
//        self.dataStore = [ELDataStore sharedELDataStore];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEvent:) name:@"FetchComplete" object:nil];
//
//        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];        
//        self.pictures = [self.dataStore pictures];
//        NSLog(@"initialized");
//                
//    }
//    return self;
//}


- (void) viewDidLoad
{
    self.dataStore = [ELDataStore sharedELDataStore];
    ELPictureDataProvider *dataProvider = [ELPictureDataProvider new];
    
    [dataProvider fetchPicturesWithCompletionHandler:^(NSArray *images, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            // Instead of loading images from internet, if the request has errors, we can load it from core data:

            NSManagedObjectContext *context = self.dataStore.managedObjectContext;
            // Load from core data:
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            // Specify how the fetched objects should be sorted
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pictureID" ascending:YES];
            [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

            NSError *error = nil;
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects == nil) {
                NSLog(@"Error: %@", error);
            }
            self.pictures = fetchedObjects;
            NSLog(@"Fetched Objects: %ld", [fetchedObjects count]);
            [self.tableView reloadData];
            
            return;
        }
        self.pictures = images;
        NSLog(@"IIIIIImages count: %ld", [images count]);
        [self.tableView reloadData];
        [dataProvider downloadImageDataIntoObject:self.pictures];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - NSNotification Center

- (void)receiveEvent:(NSNotification *)notification {
    NSLog(@"Received Picture Data Data Data");
    
    [self.tableView reloadData];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count: %ld", [self.pictures count]);
    return [self.pictures count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ELCustomThumbnailTableViewCell *cell = (ELCustomThumbnailTableViewCell *) [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Picture *picture = [self.pictures objectAtIndex:indexPath.row];
    
    
    //NSLog(@"thumbnail URL: %@", picture.thumbnailLink);
    
    if (!cell) {
        // This is only being called when you are instantiating the cell for the first time.
        cell = [[ELCustomThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier picture:picture];
        NSLog(@" If location: %@", picture.location);
    }

    // We are re-using a cell. We are not re-instantiating it. We are just going to change its picture.
    [cell configureCellWithPicture:picture];
    
    cell.cellImageView.image = nil;
    
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);
    dispatch_async(fetchQ, ^{
        
        NSURL *address = [NSURL URLWithString:picture.thumbnailLink];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //ELCustomThumbnailTableViewCell *updateCell = (ELCustomThumbnailTableViewCell *) [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell) { // if nil then cell is not visible hence no need to update
                cell.cellImageView.image = image;
            }
        });
    });
    NSLog(@"Return location: %@", picture.location);
    
    return cell;
}




#pragma mark - Table view delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"pictureSelected"])
    {
        
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Picture *picture = [self.pictures objectAtIndex:ip.row];

        ELPictureViewController *pictureViewController = (ELPictureViewController *)segue.destinationViewController;
        pictureViewController.picture = picture;
        
    }
    
}





@end