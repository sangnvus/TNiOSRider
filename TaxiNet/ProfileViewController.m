//
//  ProfileViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ProfileViewController.h"
#import "REFrostedViewController.h"
#import "unity.h"
#import "ChangeAddressViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

// init count param to control edit profiles
int countBtnClicked = 0;
// init data ()
NSString *a1 = @"";
NSString *a2 = @"";
NSString *a3 = @"";
NSString *a4 = @"";
NSString *a5 = @"";
NSString *a6 = @"";
//NSString *userName = [];
-(void)showRiderDetailsToEditingWithUserName:(NSString *)userName loginWithPass:(NSString *)password withFname:(NSString *)firstName withLname:(NSString *)lastName withEmail:(NSString *)email withPhoneNo:(NSString *)phoneNo
{
    
    self.passwordField.text = password;
    self.firstNameField.text = firstName;
    self.lastNameField.text = lastName;
    self.emailField.text = email;
    self.phoneNoField.text = phoneNo;
}
-(void)showRiderDetailsReadOnlyWithUserName:(NSString *)userName loginWithPass:(NSString *)password withFname:(NSString *)firstName withLname:(NSString *)lastName withEmail:(NSString *)email withPhoneNo:(NSString *)phoneNo
{
    self.userName.text = userName;
    self.passwordLb.text = password;
    self.firstNameLb.text = firstName;
    self.lastNameLb.text = lastName;
    self.emailLb.text = email;
    self.phoneNoLb.text = phoneNo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set corlor
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];
    
    //  get user's data
    NSUserDefaults *loginInfo = [NSUserDefaults standardUserDefaults];
    
    a1 = [loginInfo stringForKey:@"username"];
    //a2 = [loginInfo stringForKey:@"password"];
    a2 = @"********";
    a3 = [loginInfo stringForKey:@"firstName"];
    a4 = [loginInfo stringForKey:@"lastName"];
    a5 = [loginInfo stringForKey:@"email"];
    a6 = [loginInfo stringForKey:@"phone"];
    // disable to change profiles
    self.firstNameField.hidden = YES;
    self.lastNameField.hidden = YES;
    self.emailField.hidden = YES;
    self.phoneNoField.hidden = YES;
    self.passwordField.hidden = YES;
    // show Label
    NSLog(@"COUNT load:%d",countBtnClicked);
    countBtnClicked = 0;
    [self showRiderDetailsReadOnlyWithUserName:a1 loginWithPass:a2 withFname:a3 withLname:a4 withEmail:a5 withPhoneNo:a6];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
-(IBAction)editProfile:(id)sender {
    NSLog(@"COUNT:%d",countBtnClicked);
    
    self.editBtn.hidden =YES;
    self.doneEditBtn.hidden = NO;
    self.passwordChangeBtn.hidden = NO;
    //enable editing
    self.firstNameField.hidden = NO;
    self.lastNameField.hidden = NO;
    self.emailField.hidden = NO;
    self.phoneNoField.hidden = NO;
    self.passwordField.hidden = NO;
    // hiding label
    self.firstNameLb.hidden = YES;
    self.lastNameLb.hidden = YES;
    self.emailLb.hidden = YES;
    self.phoneNoLb.hidden = YES;
    self.passwordLb.hidden = YES;
    
    
    if (countBtnClicked==0) {
        [self showRiderDetailsToEditingWithUserName:a1 loginWithPass:a2 withFname:a3 withLname:a4 withEmail:a5 withPhoneNo:a6];
    }
    if(countBtnClicked>0){
        NSLog(@"COUNT on if:%d",countBtnClicked);
        [self showRiderDetailsReadOnlyWithUserName:a1
                                     loginWithPass:a2
                                         withFname:self.firstNameField.text
                                         withLname:self.lastNameField.text
                                         withEmail:self.emailField.text
                                       withPhoneNo:self.phoneNoField.text];
        [self showRiderDetailsToEditingWithUserName:a1
                                      loginWithPass:a2
                                          withFname:self.firstNameField.text
                                          withLname:self.lastNameField.text
                                          withEmail:self.emailField.text
                                        withPhoneNo:self.phoneNoField.text];
    }
    countBtnClicked++;
    NSLog(@"COUNT edit:%d",countBtnClicked);
}

- (IBAction)doneEditProfile:(id)sender {
    self.editBtn.hidden =NO;
    self.doneEditBtn.hidden = YES;
    self.passwordChangeBtn.hidden = YES;
    // disable to change profile
    self.firstNameField.hidden = YES;
    self.lastNameField.hidden = YES;
    self.emailField.hidden = YES;
    self.phoneNoField.hidden = YES;
    self.passwordField.hidden = YES;
    // hiding label
    self.firstNameLb.hidden = NO;
    self.lastNameLb.hidden = NO;
    self.emailLb.hidden = NO;
    self.phoneNoLb.hidden = NO;
    self.passwordLb.hidden = NO;
    // show data change
    NSLog(@"DATA:%@",self.firstNameField.text);
    NSUserDefaults *updateUserInfo = [NSUserDefaults standardUserDefaults];
    [updateUserInfo setObject:self.firstNameField.text forKey:@"firstName"];
    [updateUserInfo setObject:self.lastNameField.text forKey:@"lastName"];
    [updateUserInfo setObject:self.emailField.text forKey:@"email"];
    [updateUserInfo setObject:self.phoneNoField.text forKey:@"phone"];
    //[updateUserInfo synchronize];
    [self showRiderDetailsReadOnlyWithUserName:a1
                                 loginWithPass:a2
                                     withFname:self.firstNameField.text
                                     withLname:self.lastNameField.text
                                     withEmail:self.emailField.text
                                   withPhoneNo:self.phoneNoField.text];
    [self showRiderDetailsToEditingWithUserName:a1
                                  loginWithPass:a2
                                      withFname:self.firstNameField.text
                                      withLname:self.lastNameField.text
                                      withEmail:self.emailField.text
                                    withPhoneNo:self.phoneNoField.text];
    [unity updateByRiderById:[updateUserInfo stringForKey:@"riderId"]
                   firstName:[updateUserInfo stringForKey:@"firstName"]
                    lastName:[updateUserInfo stringForKey:@"lastName"]
                       email:[updateUserInfo stringForKey:@"email"]
                     phoneNo:[updateUserInfo stringForKey:@"phone"]];
    NSLog(@"COUNT done:%d",countBtnClicked);
    
}

- (IBAction)passwordChange:(id)sender {
    
    
}

- (IBAction)addAddress:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    ChangeAddressViewController *controller = (ChangeAddressViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ChangeAddress"];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

- (IBAction)addMoreJob:(id)sender {
    
}
@end
