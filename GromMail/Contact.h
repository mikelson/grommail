//
//  Contact.h
//  GromMail
//
//  Created by Peter on 9/1/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSOrderedSet *emailAddressList;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSData * draftImage;
@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inEmailAddressListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEmailAddressListAtIndex:(NSUInteger)idx;
- (void)insertEmailAddressList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEmailAddressListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEmailAddressListAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceEmailAddressListAtIndexes:(NSIndexSet *)indexes withEmailAddressList:(NSArray *)values;
- (void)addEmailAddressListObject:(NSManagedObject *)value;
- (void)removeEmailAddressListObject:(NSManagedObject *)value;
- (void)addEmailAddressList:(NSOrderedSet *)values;
- (void)removeEmailAddressList:(NSOrderedSet *)values;
@end
