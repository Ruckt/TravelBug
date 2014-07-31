//
//  ELCustomThumbnailTableViewCell.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture+Methods.h"

@interface ELCustomThumbnailTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier picture:(Picture *)picture;
- (void)configureCellWithPicture:(Picture *)thePicture;

@end


