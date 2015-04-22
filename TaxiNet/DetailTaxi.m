//
//  DetailTaxi.m
//  taxinet
//
//  Created by Louis Nhat on 3/31/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "DetailTaxi.h"

@interface DetailTaxi ()

@end

@implementation DetailTaxi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagedriver.layer.masksToBounds = YES;
    self.imagedriver.layer.cornerRadius = self.imagedriver.frame.size.height/2;
    NSLog(@"data: %@",self.dataTaxi);
    self.distance.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"distance"];
    self.to.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressFrom"];
    self.from.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressTo"];
    [self.boder setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder1 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder2 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder3 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder4 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    
    NSString *taxiname=[self.dataTaxi objectForKey:@"companyName"];
    NSString *cartype=[self.dataTaxi objectForKey:@"carTypeID"];
//    if ([self.dataTaxi objectForKey:@"companyName"]!=nil ||[[self.dataTaxi objectForKey:@"companyName"] isEqualToString:@""]) {
//        self.taxiname.text=[self.dataTaxi objectForKey:@"companyName"];
//    }
    NSString * name=[NSString stringWithFormat:@"%@ %@",[self.dataTaxi objectForKey:@"lastName"],[self.dataTaxi objectForKey:@"firstName"]];
    self.namedriver.text =name;
//    if ([self.dataTaxi objectForKey:@"carTypeID"]!=nil ||[[self.dataTaxi objectForKey:@"companyName"] isEqualToString:@""]) {
//        self.taxisheet.text=[self.dataTaxi objectForKey:@"carTypeID"];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Book:(id)sender {
    NSString *RiderID = [[NSUserDefaults standardUserDefaults] stringForKey:@"riderId"];
    NSString *DriverID=[self.dataTaxi objectForKey:@"id"];
    NSString *LongitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
    NSString *LatitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
    NSString *LongitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
    NSString *LatitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
    NSString *AdressFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressFrom"];
    NSString *AdressTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressTo"];
    
    CreateTrip *createtrip=[[CreateTrip alloc]init];
    createtrip.riderID=RiderID;
    createtrip.driverID=DriverID;
    createtrip.longitudeFrom=[LongitudeFrom doubleValue];
    createtrip.latitudeFrom=[LatitudeFrom doubleValue];
    createtrip.longitudeTo=[LongitudeTo doubleValue];
    createtrip.latitudeTo=[LatitudeTo doubleValue];
    createtrip.adressFrom=AdressFrom;
    createtrip.adressTo=AdressTo;
    createtrip.paymentMethod=@"cash";
    createtrip.fromCity=@"Ha Noi";
    createtrip.toCity=@"Ha Noi";
    
    NSString *data = [NSString stringWithFormat:@"{\"riderId\":\"%@\",\"driverId\":\"%@\",\"fromlongitude\":\"%@\",\"fromlatitude\":\"%@\",\"tolongitude\":\"%@\",\"tolatitude\":\"%@\",\"paymentMethod\":\"cash\",\"fromAddress\":\"%@\",\"toAddress\":\"%@\",\"fromCity\":\"Ha Noi\",\"toCity\":\"Ha Noi\"}",RiderID,DriverID,LongitudeFrom,LatitudeFrom,LongitudeTo,LatitudeTo,AdressFrom,AdressTo];
    
   NSLog(@"%@", data);

    NSData *plainData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    // Zm9v

    
    [unity CreateTrip:base64String owner:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HidenViewDetail" object:self];

}

- (IBAction)cancel:(id)sender {
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowViewDetail" object:self];
    }];
}
- (IBAction)Call:(id)sender {
    NSString *phoneNumber=[self.dataTaxi objectForKey:@"phoneNumber"];
    NSURL *url = [ [ NSURL alloc ] initWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
