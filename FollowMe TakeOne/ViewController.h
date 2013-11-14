//
//  ViewController.h
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/12/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController
- (IBAction)followMeToggled:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *statusTextView;
@property (weak, nonatomic) IBOutlet UISwitch *toggleButton;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;


@end
