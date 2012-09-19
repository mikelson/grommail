//
//  EmailAddress.h
//  GromMail
//
//  Created by kaon on 9/11/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface EmailAddress : NSManagedObject

@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Contact *contact;

@end
