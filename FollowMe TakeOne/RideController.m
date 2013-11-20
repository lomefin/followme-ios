//
//  RideController.m
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/16/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import "RideController.h"
#import "Ride.h"
#import "PositionMarker.h"

@implementation RideController

-(void) startNewRide
{
    Ride* ride = [[Ride alloc] init];
    NSManagedObjectContext* context = [ride managedObjectContext];
    
    NSFetchRequest* fetch = [[NSFetchRequest alloc] initWithEntityName:@"Ride"];
        

}

@end
