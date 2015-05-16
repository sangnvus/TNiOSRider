//
//  unity.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "unity.h"
//#define URL @"http://192.168.100.5:8080/TN"
//#define URL @"http://callingme.info/taxinet"
#define URL @"http://112.78.6.159:8080/taxinet"

#define URL_AUTO_LOGIN @"/restServices/riderController/AutoLoginiOS"
#define URL_SIGNIN @"/restServices/riderController/LoginiOS"
#define CHANGE_PASSWORD_URL @"/restServices/riderController/ChangePassword"
#define REGISTER_URL @"/restServices/riderController/registeriOS"
#define UPDATE_URL @"/restServices/riderController/updateRideriOS"
#define NEAR_TAXI_URL @"/restServices/DriverController/getNearDriveriOS"
#define FIND_PROMOTION_TRIP_URL @"/restServices/PromotionTripController/FindPromotionTripiOS"
#define MY_PROMOTION_URL @"/restServices/PromotionTripController/GetListPromotionTripRideriOS"
#define CREATETRIP @"/restServices/TripController/CreateTripiOS"
#define REGISTER_PROMOTION_TRIP_URL @"/restServices/PromotionTripController/RegisterPromotionTripiOS"
#define UPDATETRIP @"/restServices/TripController/UpdateTripiOS"
#define HISTORY_URL @"/restServices/TripController/GetListCompleteTripRideriOS"
#define LOGOUT @"/restServices/riderController/Logout"
#define AUTOLOGIN @"/restServices/riderController/AutoLoginiOS"



@implementation unity

+(void)login_by_email:(NSString *)email
                 pass:(NSString *)pass
                regId:(NSString *)regId
           deviceType:(NSString *)deviceType
                owner:(LoginViewController*)owner
{
    if ([regId isEqualToString:@""]|| [regId length]==0) {
        regId = [NSString stringWithFormat:@"123"];
    }
    UserInfo *model = [[UserInfo alloc] init];
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,URL_SIGNIN];
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

+(void)registerByEmail:(NSString *)jsonData owner:(RegisterViewController *)owner
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,REGISTER_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"json":jsonData};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {

              [owner checkResponseData:[responseObject objectForKey:@"message"]];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"Error"
                                                               message:NSLocalizedString(@"Please check your internet connection. ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];
}

+(void)updateByRiderById:(NSString*)dataEncode
                   owner:(ProfileViewController *)owner
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,UPDATE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"json":dataEncode};
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
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,NEAR_TAXI_URL];
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
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,FIND_PROMOTION_TRIP_URL];
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
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,CREATETRIP];
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

+(void)registerPromotionTrip:(NSString *)dataEncode owner: (FindPromotionTripResult *)owner
{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,REGISTER_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param1 = @{@"json":dataEncode};
    [manager POST:url
       parameters:param1
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [owner registerSuccess];
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
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,UPDATETRIP];
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
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,MY_PROMOTION_URL];
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

+(void)changePasswordByRiderId:(NSString *)riderId
                   oldPassword:(NSString *)oldPassword
                     nPassword:(NSString *)nPassword
                         owner:(ChangePasswordViewController *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,CHANGE_PASSWORD_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":riderId,@"oldpassword":oldPassword,@"newpassword":nPassword};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"response:%@",responseObject);
              [owner checkPassword:[responseObject objectForKey:@"message"]];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ERROR:%@",error);
          }];
}

+(void)getTripHistoryWithRiderId:(NSString *)riderId owner:(HistoryViewController *)owner
{
    TripHistory *history = [[TripHistory alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,HISTORY_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":riderId};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              history.myTripsHistory = [NSArray arrayWithArray:responseObject];
              owner.myHistoryTrips = history.myTripsHistory;
              [owner showResponseData];
              NSLog(@"SUCC");
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ERROR:%@",error);
          }];
    
    
}
+(void)automationLogin:(NSString *)tokenDevice deviceType:(NSString *)deviceType
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,URL_AUTO_LOGIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"regId":tokenDevice,@"deviceType":deviceType};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"SUSUSUUS");
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"FIFIFI: %@",error);
          }];
    
}
+(void)LogOut:(NSString*)riderId
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,LOGOUT];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":riderId};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");
              
          }];
}
+(void)AutoLogin:(NSString *)regId  owner:(ViewController*)owner
{
    UserInfo *user=[[UserInfo alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,AUTOLOGIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"regId":regId,@"deviceType":@"iOS"};
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              user.dataUser=[NSDictionary dictionaryWithDictionary:responseObject];
              owner.dataAutoLogin=user.dataUser;
              [owner CheckLogin];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                               message:NSLocalizedString(@"Please check your internet connection",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"offAutoLoginloading" object:self];
              
          }];
}

@end
