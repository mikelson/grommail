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
#import "SettingsViewController.h"

@implementation ContactTableViewCell
@synthesize nameTextField;
@synthesize outgoingEmailTextField;
@synthesize pictureButton;

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
    EmailAddress* email = [contact.emailAddressList firstObject];
    [self.outgoingEmailTextField setText:email.value];
    UIImage* image = [UIImage imageWithData:contact.picture];
    if (!image) {
        [pictureButton setTitle:@"add photo" forState:UIControlStateNormal];
        NSBundle* bundle = [NSBundle mainBundle];
        NSString* path = [bundle pathForResource:@"contact-placeholder" ofType:@"jpg"];
        image = [UIImage imageWithContentsOfFile:path];
    } else {
        [pictureButton setTitle:nil forState:UIControlStateNormal];
    }
    [pictureButton setBackgroundImage:image forState:UIControlStateNormal];
    
    // Assume that model won't change from anything else, so don't register as Key-Value Observer...
}

- (IBAction)updateOutgoingEmail:(id)sender {
    // Create new address instance.
    EmailAddress* email = [NSEntityDescription insertNewObjectForEntityForName:@"EmailAddress"
                                                        inManagedObjectContext:[AppDelegate sharedManagedObjectContext]];
    NSString* emailString = self.outgoingEmailTextField.text;
    email.value = emailString;
    
    // Add address to Contact.
    // Ordered set accessors are buggy, see http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors
//    [self.contact replaceObjectInEmailAddressListAtIndex:0 withObject:email];
    // Workaround using inverse relationships:
    // Remove what was there before:
    if ([self.contact.emailAddressList count]) {
        EmailAddress* oldEmail = [self.contact.emailAddressList objectAtIndex:0];
        [oldEmail setContact:nil];
    }
    // Set new address's contact,
    email.contact = self.contact;
}

- (IBAction)updateName:(id)sender {
    NSString* name = self.nameTextField.text;
    self.contact.name = name;
}

- (IBAction)changePicture:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"photo library not available!");
        return;
    }
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    // default picker.mediaTypes of kUTTypeImage is fine
    
    // Present the user interface.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // On iPad, the correct way to present an image picker depend on its source type.
        // If you specify a source type of UIImagePickerControllerSourceTypePhotoLibrary or UIImagePickerControllerSourceTypeSavedPhotosAlbum, you must present the image picker using a popover controller.
        // If you specify a source type of UIImagePickerControllerSourceTypeCamera, you can present the image picker modally (full-screen) or by using a popover. However, Apple recommends that you present the camera interface only full-screen.
        self.popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        self.popover.delegate = self;
        
        CGRect rect = sender.frame;
        UIView* view = sender.superview;
        [self.popover presentPopoverFromRect:rect inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        // "On iPhone or iPod touch, do this modally (full-screen) by calling the presentViewController:animated:completion: method of the currently active view controller, passing your configured image picker controller as the new view controller."
        [self.viewController presentModalViewController:picker animated:YES];
    }
}

#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popover = nil;
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    // Assign image to view
    [pictureButton setBackgroundImage:image forState:UIControlStateNormal];
    
    // Assign data to model
    self.contact.picture = UIImagePNGRepresentation(image);
    
    [self imagePickerControllerDidCancel:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the picker
    [picker removeFromParentViewController];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    } else {
        [self.viewController dismissModalViewControllerAnimated:YES];
    }
}
@end
