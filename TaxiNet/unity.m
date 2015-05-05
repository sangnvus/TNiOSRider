//
//  unity.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "unity.h"

#define URL_SIGNIN @"http://192.168.0.102:8080/TN/restServices/riderController/LoginiOS"
#define CHANGE_PASSWORD_URL @"http://192.168.0.102:8080/TN/restServices/riderController/ChangePassword"
#define REGISTER_URL @"http://192.168.0.102:8080/TN/restServices/CommonController/register"

#define UPDATE_URL @"http://192.168.0.102:8080/TN/restServices/riderController/UpdateRider"
#define NEAR_TAXI_URL @"http://192.168.0.102:8080/TN/restServices/DriverController/getNearDriver"
#define FIND_PROMOTION_TRIP_URL @"http://192.168.0.102:8080/TN/restServices/PromotionTripController/FindPromotionTripiOS"
#define MY_PROMOTION_URL @"http://192.168.0.102:8080/TN/restServices/PromotionTripController/GetListPromotionTripRideriOS"
#define CREATETRIP @"http://192.168.0.102:8080/TN/restServices/TripController/CreateTripiOS"
#define REGISTER_PROMOTION_TRIP_URL @"http://192.168.0.102:8080/TN/restServices/PromotionTripController/RegisterPromotionTripiOS"
#define UPDATETRIP @"http://192.168.0.102:8080/TN/restServices/TripController/UpdateTripiOS"


// localhost
//#define URL_SIGNIN @"http://localhost:8080/TN/restServices/riderController/LoginiOS"
//
//#define CHANGE_PASSWORD_URL @"http://localhost:8080/TN/restServices/riderController/ChangePassword"
//
//#define REGISTER_URL @"http://localhost:8080/TN/restServices/CommonController/register"
//
//#define UPDATE_URL @"http://localhost:8080/TN/restServices/riderController/UpdateRider"
//
//#define NEAR_TAXI_URL @"http://localhost:8080/TN/restServices/DriverController/getNearDriver"
//
//#define FIND_PROMOTION_TRIP_URL @"http://localhost:8080/TN/restServices/PromotionTripController/FindPromotionTripiOS"
//
//#define MY_PROMOTION_URL @"http://localhost:8080/TN/restServices/PromotionTripController/GetListPromotionTripRideriOS"
//
//#define CREATETRIP @"http://localhost:8080/TN/restServices/TripController/CreateTripiOS"
//
//#define REGISTER_PROMOTION_TRIP_URL @"http://localhost:8080/TN/restServices/PromotionTripController/RegisterPromotionTripiOS"
//
//#define UPDATETRIP @"http://localhost:8080/TN/restServices/TripController/UpdateTripiOS"

@implementation unity

+(void)login_by_email:(NSString *)email
                 pass:(NSString *)pass
                regId:(NSString *)regId
           deviceType:(NSString *)deviceType
                owner:(LoginViewController*)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    NSString *regId1= @"111";
    NSString *url=[NSString stringWithFormat:@"%@",URL_SIGNIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"username":email, @"password":pass ,@"regId":regId1, @"deviceType":deviceType};
    
    [manager POST:url parameters:params2
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         model.dataUser=[NSDictionary dictionaryWithDictionary:responseObject];
         owner.dataUser=model.dataUser;
         [owner checkLogin];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"regID:%@",params2);
         NSLog(@"ERROR:%@",error);
         
         UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                          message:NSLocalizedString(@"Please check your internet connection",nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                otherButtonTitles:nil, nil];
         [alertTmp show];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
     }];
}
+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url=[NSString stringWithFormat:@"%@",REGISTER_URL];
    NSDictionary *parram = @{@"email":email, @"password":pass ,@"firstname":firstname, @"lastname":lastname,@"phone":phone, @"language":language,@"usergroup":usergroup, @"countrycode":countrycode} ;

    [manager POST:url
       parameters:parram
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             UIAlertView *successReg = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Register successfull" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [successReg show];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

+(void)updateByRiderById:(NSString *)riderId
               firstName:(NSString *)firstName
                lastName:(NSString *)lastName
                   email:(NSString *)email
                 phoneNo:(NSString *)phoneNo
                   owner:(ProfileViewController *)owner
{
    NSString *url=[NSString stringWithFormat:@"%@",UPDATE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"id":riderId, @"firstname":firstName, @"lastname":lastName, @"phoneNumber":phoneNo, @"email":email};
    [manager POST:url
       parameters:params2  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           owner.message = [NSDictionary dictionaryWithDictionary:responseObject];
           NSLog(@"RESTPONSE: %@", [owner.message objectForKey:@"message"]);
           [owner checkUpdateRider];
       }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"ERROR"
                                                               message:NSLocalizedString(@"Please check your internet connection",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];
    
    
}

+(void)getNearTaxi:(NSString *)latitude andLongtitude:(NSString *)longtitude owner:(HomeViewController *)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@",NEAR_TAXI_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"latitude":latitude,@"longitude":longtitude};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              model.neartaxi=(NSArray *)responseObject;
              owner.nearTaxi=model.neartaxi;
              [owner checkGetnearTaxi];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
          }];
}

+(void)findPromotionTrips:(NSString*)fromLatitude
         andfromLongitude:(NSString*)fromLongitude
           withToLatitude:(NSString*)toLatitude
           andToLongitude:(NSString*)toLongitude
            numberOfSeats:(NSString*)noOfSeats
                startTime:(NSString *)startDate
                    owner:(FindPromotionTripResult *)owner


{

    PromotionInfo *promotionData = [[PromotionInfo alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@",FIND_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"fromLatitude":fromLatitude, @"fromLongitude":fromLongitude, @"toLatitude":toLatitude, @"toLongitude":toLongitude, @"numberOfSeats":noOfSeats, @"startTime":startDate};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              promotionData.promotionDataArr = [NSArray arrayWithArray:responseObject];
              
              owner.promotionTripResult = promotionData.promotionDataArr;
              [owner checkAndSetData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {

          }];
}
+(void)CreateTrip:(NSString*)param owner:(DetailTaxi *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@",CREATETRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param1 = @{@"json":param};

    [manager POST:url
       parameters:param1
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"success");
              NSLog(@"%@",(NSArray *)responseObject);
              NSString *requestid=[responseObject objectForKey:@"id"];
              [[NSUserDefaults standardUserDefaults] setObject:requestid forKey:@"requestid"];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");
          }];
    
//    NSString *api=[NSString stringWithFormat:@"%@?json=%@",CREATETRIP,param];
//    NSLog(@"api:%@",api);
//    
//    [manager GET:api parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSLog(@"JSON: %@", responseObject);
//             
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             
//         }];
}

+(void)registerPromotionTrip:(NSString *)dataEncode owner:(RegisterPromotionTrip *)owner
{
    
    NSString *url=[NSString stringWithFormat:@"%@",REGISTER_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param1 = @{@"json":dataEncode};
    [manager POST:url
       parameters:param1
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Succesfull, %@",responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"Error"
                                                               message:NSLocalizedString(@"ERROR ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];

}
+(void)updateTrip:(NSString*)RequestID userID:(NSString *)userID status:(NSString *)status owner : (HomeViewController *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@",UPDATETRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"requestId":RequestID,@"userId":userID,@"status":status};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([status isEqualToString:@"PI"]) {
              }
              NSLog(@"success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");
              
          }];
}

+(void) getMyPromotionTrip:(NSString *)riderId owner:(ShowMyPromotionTrip *)owner{
    NSString *url = [NSString stringWithFormat:@"%@",MY_PROMOTION_URL];
    MyPromotionTrip *myPro = [[MyPromotionTrip alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":riderId};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              myPro.myPromotionTrip = [NSArray arrayWithArray:responseObject];
              owner.myPromotionTrips = myPro.myPromotionTrip;
              [owner showdata];
              NSLog(@"success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");
              
          }];
}

+(void)changePasswordByRiderId:(NSString *)riderId oldPassword:(NSString *)oldPassword nPassword:(NSString *)nPassword
{
    NSString *url = [NSString stringWithFormat:@"%@",CHANGE_PASSWORD_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":riderId,@"oldpassword":oldPassword,@"newpassword":nPassword};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"response:%@",responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ERROR:%@",error);
          }];
}






@end
