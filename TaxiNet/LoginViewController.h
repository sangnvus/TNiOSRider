//
//  LoginViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
@interface LoginViewController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)Login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailLogin;
@property (weak, nonatomic) IBOutlet UITextField *passLogin;
@property (weak, nonatomic) IBOutlet UIButton *FBLogin;
@property (weak,nonatomic) NSDictionary *dataUser;
-(void)checkLogin;


@end
