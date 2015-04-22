//
//  CreateTrip.h
//  TaxiNet
//
//  Created by Louis Nhat on 4/20/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateTrip : NSObject
@property (nonatomic,retain) NSString *riderID;
@property (nonatomic,retain) NSString *driverID;
@property (nonatomic,assign) double longitudeFrom;
@property (nonatomic,assign) double latitudeFrom;
@property (nonatomic,assign) double longitudeTo;
@property (nonatomic,assign) double latitudeTo;
@property (nonatomic,retain) NSString *adressFrom;
@property (nonatomic,retain) NSString *adressTo;

@property (nonatomic,retain) NSString *paymentMethod;
@property (nonatomic,retain) NSString *fromCity;
@property (nonatomic,retain) NSString *toCity;

@end
