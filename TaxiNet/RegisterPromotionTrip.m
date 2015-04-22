//
//  RegisterPromotionTrip.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/16/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RegisterPromotionTrip.h"

#define METERS_PER_MILE 1609.344
@interface RegisterPromotionTrip ()

@end

@implementation RegisterPromotionTrip

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    // 1
    NSUserDefaults *getRegisterPro = [NSUserDefaults standardUserDefaults];
    double fLogitude,fLatitude,tLongitude,tLatitude;
    NSString *sflong,*sflat,*stlong,*stlat;
    sflong = [getRegisterPro objectForKey:@"registerProFromLong"];
    sflat = [getRegisterPro objectForKey:@"registerProFromLat"];
    stlong = [getRegisterPro objectForKey:@"registerProToLong"];
    stlat = [getRegisterPro objectForKey:@"registerProToLat"];
    fLogitude = [sflong doubleValue];
    fLatitude = [sflat doubleValue];
    tLongitude = [stlong doubleValue];
    tLatitude = [stlat doubleValue];
    NSLog(@"LONG : %f",fLogitude);
    NSLog(@"LONG STR%@",sflong);
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = fLatitude;
    zoomLocation.longitude= fLogitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doBack:(id)sender {
}
@end
