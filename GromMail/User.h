//
//  User.h
//  GromMail
//
//  Created by Peter on 9/1/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *incomingEmailServer;
@property (nonatomic, retain) NSManagedObject *outgoingEmailServer;
@property (nonatomic, retain) NSOrderedSet *whiteList;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inWhiteListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWhiteListAtIndex:(NSUInteger)idx;
- (void)insertWhiteList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWhiteListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWhiteListAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceWhiteListAtIndexes:(NSIndexSet *)indexes withWhiteList:(NSArray *)values;
- (void)addWhiteListObject:(NSManagedObject *)value;
- (void)removeWhiteListObject:(NSManagedObject *)value;
- (void)addWhiteList:(NSOrderedSet *)values;
- (void)removeWhiteList:(NSOrderedSet *)values;
@end
