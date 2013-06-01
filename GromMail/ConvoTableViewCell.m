//
//  ConvoTableViewCell.m
//  GromMail
//
//  Created by Peter Mikelsons on 11/13/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "ConvoTableViewCell.h"
#import "Contact.h"

@implementation ConvoTableViewCell
@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContact:(Contact *)contact
{
    // Update model used by this cell.
    super.contact = contact;
    
    // Update what this cell shows.
    self.nameLabel.text = self.contact.name;
    [self setButtonImage:[UIImage imageWithData:self.contact.picture]];
    
    // Assume that model won't change from anything else, so don't register as Key-Value Observer...
}

@end
