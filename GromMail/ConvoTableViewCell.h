//
//  ConvoTableViewCell.h
//  GromMail
//
//  "Convo" is abbreviation of "Conversation", in this case an email exchange with a contact.
//
//  Created by Peter Mikelsons on 11/13/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ConvoTableViewCell : ContactTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
