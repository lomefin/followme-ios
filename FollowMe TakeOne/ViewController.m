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
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
}

- (NSDictionary*) packLocationInDictionary:(CLLocation*) location
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSString *spd = [NSString stringWithFormat:@"%2.2f", location.speed];
    NSString *acc = [NSString stringWithFormat:@"%2.2f", location.horizontalAccuracy];

    [dict setValue:lat forKey:@"latitude"];
    [dict setValue:lng forKey:@"longitude"];
    [dict setValue:spd forKey:@"speed"];
    [dict setValue:acc forKey:@"accuracy"];
    [dict setValue:@"Follower-IOS-1" forKey:@"version"];
    NSString* sender = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [dict setValue:sender forKey:@"sender"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSString *formattedDateString = [dateFormatter stringFromDate:location.timestamp];

    [dict setValue:formattedDateString forKey:@"timestamp"];
    
    return dict;
}

- (NSString*) convertDictionaryToJSON: (NSDictionary*) dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = @"{}";
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *) convertLocationToJSON:(CLLocation*) location
{
    NSDictionary* dict = [self packLocationInDictionary:location];
    NSString* json = [self convertDictionaryToJSON:dict];
    
    return json;
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

- (void)sendLocationToServer:(NSString*) jsonRequest
{
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    NSURL* url = [NSURL URLWithString:@"http://api.routing.uc.cl/trackpoints"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        
        NSString *pos = [NSString stringWithFormat:@"{%f,%f}@%2.2f[m/s] (%2.2f)", location.coordinate.latitude,location.coordinate.longitude,location.speed, location.horizontalAccuracy];
        
        
        NSString *newLocationJSON = [self convertLocationToJSON:location];

        [self sendLocationToServer:newLocationJSON];
        [self addTextToState:pos];
    }
}


@end
