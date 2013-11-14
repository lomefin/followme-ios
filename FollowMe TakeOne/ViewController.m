//
//  ViewController.m
//  FollowMe TakeOne
//
//  Created by Routing Developer on 11/12/13.
//  Copyright (c) 2013 Routing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) addTextToState:(NSString *)message
{
    NSString* oldText = [@"\n" stringByAppendingString:self.statusTextView.text];
    NSString* newText = [message stringByAppendingString:oldText];
    [self.statusTextView setText:newText];

}

- (IBAction)followMeToggled:(id)sender {
    
    [self addTextToState:@"Switch toggled"];
    if(self.toggleButton.isOn){
        [self addTextToState:@"Is on"];
        [_locationManager startUpdatingLocation];
    }else
    {
        [self addTextToState:@"Is off"];
        [_locationManager stopUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        NSString *spd = [NSString stringWithFormat:@"%f", location.speed];
        
        NSString *statusUpdate = [[[[lat stringByAppendingString:@","] stringByAppendingString:lng] stringByAppendingString:@" at "]stringByAppendingString:spd];
        
        [self addTextToState:statusUpdate];
    }
}


@end
