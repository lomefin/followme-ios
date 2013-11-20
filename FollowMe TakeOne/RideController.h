//
//  RideController.h
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/16/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RideController : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

-(void) startNewRide;
@end
