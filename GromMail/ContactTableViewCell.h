//
//  ContactTableViewCell.h
//  GromMail
//
//  Created by kaon on 9/2/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@class SettingsViewController;

@interface ContactTableViewCell : UITableViewCell <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) Contact *contact;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *outgoingEmailTextField;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (strong, nonatomic) UIPopoverController* popover;
@property (weak, nonatomic) SettingsViewController *viewController;
- (IBAction)updateOutgoingEmail:(id)sender;
- (IBAction)updateName:(id)sender;
- (IBAction)changePicture:(UIButton *)sender;
@end
