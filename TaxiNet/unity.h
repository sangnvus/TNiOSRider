//
//  unity.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "PromotionInfo.h"
#import "MyPromotionTrip.h"
#import "AppDelegate.h"
#import "ShowMyPromotionTrip.h"
#import "FindPromotionTrip.h"
#import "HomeViewController.h"
#import "DetailTaxi.h"
#import "ProfileViewController.h"
#import "DEMOMenuViewController.h"
#import "RegisterPromotionTrip.h"
#import "FindPromotionTripResult.h"
@class HomeViewController;
@class DetailTaxi;
@interface unity : NSObject

+(void)login_by_email : (NSString*)email pass:(NSString *)pass regId:(NSString*)regId deviceType:(NSString*)deviceType owner:(LoginViewController*)owner;

+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode;

+(void)updateByRiderById : (NSString*)riderId
                firstName:(NSString*)firstName
                 lastName:(NSString*)lastName
                    email:(NSString*)email
                  phoneNo:(NSString*)phoneNo owner:(ProfileViewController*)owner;

+(void)getNearTaxi:(NSString*)latitude
     andLongtitude:(NSString*)longtitude owner:(HomeViewController *)owner;

+(void)findPromotionTrips : (NSString*)formLatitude
          andfromLongitude: (NSString*)fromLongitude
            withToLatitude: (NSString*)toLatitude
            andToLongitude: (NSString*)toLongitude
             numberOfSeats:(NSString*)noOfSeats
                 startTime:(NSString*)startDate
                     owner: (FindPromotionTripResult*)owner;

+(void)registerPromotionTrip:(NSString*)dataEncode owner:(RegisterPromotionTrip*)owner;

+(void)CreateTrip:(NSString*)param owner:(DetailTaxi *)owner;

+(void)updateTrip:(NSString*)RequestID userID:(NSString *)userID status:(NSString *)status owner : (HomeViewController *)owner;

+(void)getMyPromotionTrip: (NSString*)riderId owner:(ShowMyPromotionTrip*)owner;
+(void)changePasswordByRiderId:(NSString*)riderId oldPassword:(NSString*)oldPassword nPassword:(NSString*)nPassword;



@end
