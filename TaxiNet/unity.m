//
//  unity.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "unity.h"

#define URL_SIGNIN @"http://192.168.43.181:8080/TN/restServices/riderController/Login"
#define UPDATE_URL @"http://192.168.43.181:8080/TN/restServices/riderController/UpdateRider"
#define NEAR_TAXI_URL @"http://192.168.43.181:8080/TN/restServices/DriverController/getNearDriver"
#define FIND_PROMOTION_TRIP_URL @"http://localhost:8080/TN/restServices/PromotionTripController/FindPromotionTip"
#define CREATETRIP @"http://192.168.43.181:8080/TN/restServices/TripController/CreateTripiOS"
#define REGISTER_PROMOTION_TRIP_URL @"http://192.168.43.181:8080/TN/restServices/PromotionTripController/RegisterPromotionTip"

@implementation unity
{

}

+(void)login_by_email:(NSString *)email
                 pass:(NSString *)pass
                regId:(NSString *)regId
           deviceType:(NSString *)deviceType
                owner:(LoginViewController*)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    
    NSString *url=[NSString stringWithFormat:@"%@",URL_SIGNIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"username":email, @"password":pass ,@"regId":regId, @"deviceType":deviceType};
    
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
         UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                          message:NSLocalizedString(@"please check info login",nil)
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

    NSString *api=[NSString stringWithFormat:@"http://192.168.125.10:8080/TN/restServices/CommonController/register?email=%@&password=%@&firstname=%@&lastname=%@&phone=%@&language=%@&usergroup=%@&countrycode=%@",email,pass,firstname,lastname,phone,language,usergroup,countrycode];
    NSLog(@"api:%@",api);

    [manager GET:api parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

+(void)updateByRiderById:(NSString *)riderId firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email phoneNo:(NSString *)phoneNo
{
    NSString *url=[NSString stringWithFormat:@"%@",UPDATE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"id":riderId, @"firstname":firstName, @"lastname":lastName, @"phoneNumber":phoneNo, @"email":email};
    [manager POST:url
       parameters:params2  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           
       }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"LỖI"
                                                               message:NSLocalizedString(@"Cap nhat du lieu khong thanh cong ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Đồng ý",nil)
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

+(void)findPromotionTrips:(double)fromLatitude
         andfromLongitude:(double)fromLongitude
           withToLatitude:(double)toLatitude
           andToLongitude:(double)toLongitude
                    owner:(FindPromotionTrip*)owner

{
    NSString *fromLat,*fromLong;
    NSString *tolat,*toLong;
    // convert double to string
    fromLat =[NSString stringWithFormat:@"%f",fromLatitude];
    fromLong = [NSString stringWithFormat:@"%f",fromLongitude];
    tolat = [NSString stringWithFormat:@"%f", toLatitude];
    toLong = [NSString stringWithFormat:@"%f", toLongitude];
    
    PromotionInfo *promotionData = [[PromotionInfo alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@",FIND_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"fromLatitude":fromLat, @"fromLongitude":fromLong, @"toLatitude":tolat, @"toLongitude":toLong};
    [manager POST:url parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+(void)registerPromotionTrip:(NSString *)promotionTripId
                     riderId:(NSString *)riderId
                    fromCity:(NSString *)fromCity
                 fromAddress:(NSString *)fromAddress
                      toCity:(NSString *)tocity
                   toAddress:(NSString *)toAddress
               numberOfSeats:(NSString *)number
{
 
    
    
    
    
    NSString *url=[NSString stringWithFormat:@"%@",REGISTER_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @ {@"promotionTripId":promotionTripId, @"riderId":riderId, @"fromCity":fromAddress, @"fromAddress":fromCity, @"toCity":tocity,@"toAddress":toAddress, @"numberOfseat":number};
    [manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Succesfull, %@",responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"Error"
                                                               message:NSLocalizedString(@"Cap nhat du lieu khong thanh cong ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Đồng ý",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];

    
}


@end
