//
//  ContactTableViewCell.h
//  GromMail
//
//  Created by kaon on 9/2/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactTableViewCell : UITableViewCell

@property (strong, nonatomic) Contact *contact;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *outgoingEmailTextField;
- (IBAction)updateOutgoingEmail:(id)sender;
- (IBAction)updateName:(id)sender;
@end
