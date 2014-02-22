//
//  Icon.h
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Icon : NSManagedObject

@property (nonatomic, retain) NSNumber * icon_id;
@property (nonatomic, retain) NSString * path;

@end
