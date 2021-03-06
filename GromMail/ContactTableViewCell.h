//
//  ContactTableViewCell.h
//  
//
//  Created by Peter Mikelsons on 11/14/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//
//

#import <UIKit/UIKit.h>
@class Contact;
@class ContactPictureButton;

@interface ContactTableViewCell : UITableViewCell

@property (strong, nonatomic) Contact *contact;
@property (weak, nonatomic) IBOutlet ContactPictureButton *pictureView;

// protected (how?)
- (void)setButtonImage:(UIImage*)image;

@end
