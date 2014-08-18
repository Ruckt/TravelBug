//
//  ELCustomThumbnailTableViewCell.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELCustomThumbnailTableViewCell.h"
#import "UIColor+Colors.h"


@interface ELCustomThumbnailTableViewCell()
@end

@implementation ELCustomThumbnailTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier picture:(Picture *)picture {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"Init location: %@", picture.location);
    }
    return self;
}

- (void)configureCellWithPicture:(Picture *)picture {
    [self addingColor];
    self.locationLabel.text = picture.location;
    NSLog(@"Configure location: %@", picture.location);

}

-(void)addingColor
{
    self.cellImageView.layer.borderWidth = 6.0;
    self.cellImageView.layer.borderColor = [UIColor blueSkyTravelBug].CGColor;
}


@end
