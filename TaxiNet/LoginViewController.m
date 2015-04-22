//
//  LoginViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "unity.h"
#import "UserInfo.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    MBProgressHUD *HUD;
    AppDelegate*appdelegate;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:HUD];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"offLoginloading" object:nil];
    
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"offLoginloading"]) {
        [HUD removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)Login:(id)sender {
    
    if (self.emailLogin==nil|| [self.emailLogin.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input username",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if (self.passLogin.text==nil|| [self.passLogin.text isEqualToString:@""])
    {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input Password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
    {
        NSString *deviceType = @"iOS";
        [HUD show:YES];
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
        [unity login_by_email:self.emailLogin.text pass:self.passLogin.text regId:deviceToken deviceType:deviceType  owner:self];
    }
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
//    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//    [self.navigationController pushViewController:controller animated:YES];

}
-(void)checkLogin
{

    NSUserDefaults *loginInfo = [NSUserDefaults standardUserDefaults];
    // set data to NSDictionary
    appdelegate.yoursefl=(NSMutableDictionary*)self.dataUser;
    NSLog(@"data9999:%@",[appdelegate.yoursefl objectForKey:@"email"]);
    // save data login
    //NSString *passLog = @"******";
    [loginInfo setObject:self.emailLogin.text forKey:@"username"];
    [loginInfo setObject:self.passLogin.text forKey:@"password"];
    [loginInfo setObject:[self.dataUser objectForKey:@"email"] forKey:@"email"];
    [loginInfo setObject:[self.dataUser objectForKey:@"firstName"] forKey:@"firstName"];
    [loginInfo setObject:[self.dataUser objectForKey:@"lastName"] forKey:@"lastName"];
    [loginInfo setObject:[self.dataUser objectForKey:@"phone"] forKey:@"phone"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"homeAddress"] forKey:@"homeAddress"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"homeAddressLng"] forKey:@"homeAddressLng"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"homeAddressLat"] forKey:@"homeAddressLat"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"image"] forKey:@"image"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"latitude"] forKey:@"latitude"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"longitude"] forKey:@"longitude"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"message"] forKey:@"message"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"officeAddress"] forKey:@"officeAddress"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"officeAddressLng"] forKey:@"officeAddressLng"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"officeAddressLat"] forKey:@"officeAddressLat"];
    [loginInfo setObject:[self.dataUser objectForKey:@"riderId"] forKey:@"riderId"];
    [[NSUserDefaults standardUserDefaults] setObject:[self.dataUser objectForKey:@"riderId"] forKey:@"riderId"];

    //    [loginInfo setObject:[self.dataUser objectForKey:@"role"] forKey:@"role"];
    //    [loginInfo setObject:[self.dataUser objectForKey:@"type"] forKey:@"type"];
    
    
    NSLog(@"Test login data: %@",self.dataUser);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
