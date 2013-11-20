//
//  Ride.h
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/16/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PositionMarker;

@interface Ride : NSManagedObject

@property (nonatomic, retain) NSDate * started_at;
@property (nonatomic, retain) NSDate * finished_at;
@property (nonatomic, retain) NSNumber * ride_number;


@end
