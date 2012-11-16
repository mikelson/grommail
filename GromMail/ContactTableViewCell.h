//
//  ContactTableViewCell.h
//  
//
//  Created by Peter Mikelsons on 11/14/12.
//
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactTableViewCell : UITableViewCell

@property (strong, nonatomic) Contact *contact;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

// protected (how?)
- (void)setButtonImage:(UIImage*)image;

@end
