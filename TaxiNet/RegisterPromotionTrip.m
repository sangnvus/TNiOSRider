//
//  RegisterPromotionTrip.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/16/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RegisterPromotionTrip.h"
#import "FindPromotionTripResult.h"
#import "unity.h"

#define METERS_PER_MILE 1609.344
@interface RegisterPromotionTrip ()

@end

@implementation RegisterPromotionTrip

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    NSUserDefaults *registerUser = [NSUserDefaults standardUserDefaults];
    [self.fromField setText:[registerUser objectForKey:@"registerProFromAdd"]];
    [self.toField setText:[registerUser objectForKey:@"registerProToAdd"]];
    [self.fromCityField setText:[registerUser objectForKey:@"registerProFromCity"]];
    [self.toCityField setText:[registerUser objectForKey:@"registerProFromCity"]];
    [self.numberField setText:[registerUser objectForKey:@"noOfSeats"]];    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    // 1
    NSUserDefaults *getRegisterPro = [NSUserDefaults standardUserDefaults];
    double fLongitude,fLatitude,tLongitude,tLatitude;
    NSString *sflong,*sflat,*stlong,*stlat;
    sflong = [getRegisterPro objectForKey:@"registerProFromLong"];
    sflat = [getRegisterPro objectForKey:@"registerProFromLat"];
    stlong = [getRegisterPro objectForKey:@"registerProToLong"];
    stlat = [getRegisterPro objectForKey:@"registerProToLat"];
    fLongitude = [sflong doubleValue];
    fLatitude = [sflat doubleValue];
    tLongitude = [stlong doubleValue];
    tLatitude = [stlat doubleValue];
    NSLog(@"LONG : %f",fLongitude);
    NSLog(@"LONG STR%@",sflong);
    
    
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = fLatitude;
//    zoomLocation.longitude= fLongitude;
//    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(fLatitude, fLongitude);
    myAnnotation.title = @"Start place";
//
//    
//    CLLocationCoordinate2D zoomLocation2;
//    zoomLocation2.latitude = tLatitude;
//    zoomLocation2.longitude= tLongitude;
//
    MKPointAnnotation *myAnnotation2 = [[MKPointAnnotation alloc] init];
    myAnnotation2.coordinate = CLLocationCoordinate2DMake(tLatitude, tLongitude);
    myAnnotation2.title = @"Stop place";

    
    CLLocationCoordinate2D zoomLocationTT;
    zoomLocationTT.latitude = (tLatitude + fLatitude)/2 ;
    zoomLocationTT.longitude= (tLongitude + fLongitude)/2;
    
    CLLocationCoordinate2D coordinateArray[2];
    coordinateArray[0] = CLLocationCoordinate2DMake(fLatitude, fLongitude);
    coordinateArray[1] = CLLocationCoordinate2DMake(tLatitude, tLongitude);
    
    
    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]]; //If you want the route to be visible
    
    [self.mapView addOverlay:self.routeLine];
    
    // 2
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // zoom
    MKCoordinateRegion viewRegion2 = MKCoordinateRegionMakeWithDistance(zoomLocationTT, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    [self.mapView setRegion:viewRegion2 animated:YES];
    
    [self.mapView addAnnotation:myAnnotation];
    
    [self.mapView addAnnotation:myAnnotation2];
    // dimiss keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

}


-(void)hideKeyBoard {
    [self.fromField resignFirstResponder];
    [self.toField resignFirstResponder];
    [self.numberField resignFirstResponder];
}



- (IBAction)doBack:(id)sender {
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    FindPromotionTripResult *controller = (FindPromotionTripResult*)[homeStoryboard instantiateViewControllerWithIdentifier:@"FindPromotionTripResult"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)doRegisterPromotionTrip:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *promotionTripId = [user valueForKey:@"promotionTripId"];
    //notice
    NSString *riderId = [user objectForKey:@"riderId"];
    NSString *fromCity = [user valueForKey:@"fromCityShow1"];
    NSString *fromAddress = [user objectForKey:@"registerProFromAdd"];
    NSString *toCity = [user valueForKey:@"toCityShow1"];
    NSString *toAddress = [user objectForKey:@"registerProToAdd"];
    NSString *time = @"2015-05-17 22:03:53";
    NSString *numberOfSeats = [user objectForKey:@"noOfSeats"];
    
        NSString *data = [NSString stringWithFormat:   @"{\"promotionTripId\":\"%@\",\"riderId\":\"%@\",\"fromCity\":\"%@\",\"fromAddress\":\"%@\",\"toCity\":\"%@\",\"toAddress\":\"%@\",\"time\":\"%@\",\"numberOfSeat\":\"%@\"}",promotionTripId,riderId,fromCity,fromAddress,toCity,toAddress,time,numberOfSeats];
    
    NSLog(@"%@", data);
    
    NSData *plainData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"BASE%@,",base64String);
//    NSDictionary *encode = [NSDictionary dictionaryWithObject:base64String forKey:@"valu"];
    
    [unity registerPromotionTrip:base64String owner:self];
}



@end
