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
#import "RegisterViewController.h"
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
    // hide keyboard when tap other arena
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

}
-(void)hideKeyBoard{
    [self.emailLogin resignFirstResponder];
    [self.passLogin resignFirstResponder];
    
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


- (IBAction)Login:(id)sender {
    
    if (self.emailLogin==nil|| [self.emailLogin.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your e-mail",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if (self.passLogin.text==nil|| [self.passLogin.text isEqualToString:@""])
    {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
    {
        NSString *deviceType = @"iOS";
        [HUD show:YES];
//        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
        NSString *deviceToken = appdelegate.deviceToken;

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
    NSString *rFirstName = [appdelegate.yoursefl objectForKey:@"firstName"];
    NSString *rLastName = [appdelegate.yoursefl objectForKey:@"lastName"];
    [loginInfo setObject:[NSString stringWithFormat:@"%@ %@",rFirstName,rLastName] forKey:@"RiderFullName"];
    
    if ([[appdelegate.yoursefl objectForKey:@"message"] isEqualToString:@"1"] ) {
        
        
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"User is not exist",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
    }else if([[appdelegate.yoursefl objectForKey:@"message"] isEqualToString:@"0"]){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Wrong password!",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
        
    }else{

         [[NSUserDefaults standardUserDefaults] setObject:[self.dataUser objectForKey:@"riderId"] forKey:@"riderId"];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
        HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (IBAction)registerRider:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"AppLogin" bundle: nil];
    RegisterViewController *controller = (RegisterViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"RegisterViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)forgotPassword:(id)sender {
}

@end
