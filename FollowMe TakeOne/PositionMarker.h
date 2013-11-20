//
//  PositionMarker.h
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/16/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PositionMarker : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * precision;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Ride *ride;

@end
