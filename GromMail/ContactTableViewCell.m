//
//  ContactTableViewCell.m
//  GromMail
//
//  Created by kaon on 9/2/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Contact.h"
#import "EmailAddress.h"
#import "AppDelegate.h"

@implementation ContactTableViewCell
@synthesize image;
@synthesize nameTextField;
@synthesize outgoingEmailTextField;

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
    _contact = contact;

    // Update what this cell shows.
    [self.nameTextField setText:contact.name];
    NSString* email = [contact.emailAddressList firstObject];
    [self.outgoingEmailTextField setText:email];
    
    // Assume that model won't change from anything else, so don't register as Key-Value Observer...
}

- (IBAction)updateOutgoingEmail:(id)sender {
    EmailAddress* email = [NSEntityDescription insertNewObjectForEntityForName:@"EmailAddress"
                                                        inManagedObjectContext:[AppDelegate sharedManagedObjectContext]];
    NSString* emailString = self.outgoingEmailTextField.text;
    email.value = emailString;
//    NSOrderedSet* set = self.contact.emailAddressList;
//    [self.contact replaceObjectInEmailAddressListAtIndex:0 withObject:email];
    [self.contact removeObjectFromEmailAddressListAtIndex:0];
    [self.contact insertObject:email inEmailAddressListAtIndex:0];
}

- (IBAction)updateName:(id)sender {
    NSString* name = self.nameTextField.text;
    self.contact.name = name;
}
@end
