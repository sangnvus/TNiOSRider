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
#import "HomeViewController.h"
#import "DetailTaxi.h"
#import "ProfileViewController.h"
#import "DEMOMenuViewController.h"
#import "FindPromotionTripResult.h"
#import "RegisterViewController.h"
#import "HistoryViewController.h"
#import "TripHistory.h"
#import "ViewController.h"
#import "ChangePasswordViewController.h"

@class HomeViewController;
@class DetailTaxi;
@interface unity : NSObject
+(void)AutoLogin:(NSString *)regId  owner:(ViewController*)owner;
+(void)login_by_email : (NSString*)email pass:(NSString *)pass regId:(NSString*)regId deviceType:(NSString*)deviceType owner:(LoginViewController*)owner;

+(void)registerByEmail:(NSString*)jsonData owner:(RegisterViewController*)owner;

+(void)updateByRiderById:(NSString*)dataEncode owner:(ProfileViewController*)owner;

+(void)getNearTaxi:(NSString*)latitude
     andLongtitude:(NSString*)longtitude owner:(HomeViewController *)owner;

+(void)findPromotionTrips : (NSString*)formLatitude
          andfromLongitude: (NSString*)fromLongitude
            withToLatitude: (NSString*)toLatitude
            andToLongitude: (NSString*)toLongitude
             numberOfSeats:(NSString*)noOfSeats
                 startTime:(NSString*)startDate
                     owner: (FindPromotionTripResult*)owner;

+(void)registerPromotionTrip:(NSString*)dataEncode owner: (FindPromotionTripResult *)owner;

+(void)CreateTrip:(NSString*)param owner:(DetailTaxi *)owner;

+(void)updateTrip:(NSString*)RequestID userID:(NSString *)userID status:(NSString *)status owner : (HomeViewController *)owner;

+(void)getMyPromotionTrip: (NSString*)riderId owner:(ShowMyPromotionTrip*)owner;
+(void)changePasswordByRiderId:(NSString*)riderId oldPassword:(NSString*)oldPassword nPassword:(NSString*)nPassword owner:(ChangePasswordViewController*)owner;

+(void)getTripHistoryWithRiderId:(NSString*)riderId
                           owner:(HistoryViewController*)owner;
+(void)automationLogin:(NSString*)tokenDevice deviceType:(NSString*)deviceType;
+(void)LogOut:(NSString*)riderId;

@end
