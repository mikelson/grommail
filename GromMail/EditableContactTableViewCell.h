//
//  ContactTableViewCell.h
//  GromMail
//
//  Created by kaon on 9/2/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

@class SettingsViewController;

#import "ContactTableViewCell.h"

@interface EditableContactTableViewCell : ContactTableViewCell <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *outgoingEmailTextField;
@property (strong, nonatomic) UIPopoverController* popover;
@property (weak, nonatomic) SettingsViewController *viewController;
- (IBAction)updateOutgoingEmail:(id)sender;
- (IBAction)updateName:(id)sender;

- (void)changePicture:(UIGestureRecognizer *)sender;
@end
