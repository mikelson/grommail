//
//  SettingsViewController.h
//  GromMail
//
//  Created by kaon on 9/1/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "MyViewController.h"

@interface SettingsViewController : MyViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITableView *whiteListTableView;
- (IBAction)updateUserName:(UITextField *)sender;
- (IBAction)updateUserEmail:(UITextField *)sender;

- (IBAction)addWhitelist;

@end
