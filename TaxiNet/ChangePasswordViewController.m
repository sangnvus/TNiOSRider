//
//  ChangePasswordViewController.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/27/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "unity.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController{
    AppDelegate *appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set color for app
    
    //[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1] /*#feefe7*/
    [self.viewBanner setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    

    [self.viewContent setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)checkPassword:(NSString*)message
{

    if ([message isEqualToString:@"PASSWORD_ERROR"]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"ERROR"
                                                         message:NSLocalizedString(@"Your old password is not correct.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else{
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Password successfully changed.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        LoginViewController  *controller = (LoginViewController *)[story instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self.navigationController pushViewController:controller animated:YES];
        NSString* riderId = [[NSUserDefaults standardUserDefaults] stringForKey:@"riderId"];
        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = [defs dictionaryRepresentation];
        for (id key in dict) {
            [defs removeObjectForKey:key];
        }
        [defs synchronize];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [unity LogOut:riderId];
        
    }
}

- (IBAction)doBack:(id)sender {
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    ProfileViewController *controller = (ProfileViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)doSave:(id)sender {
    if ([self.oldPasswordField.text  isEqual: @""] || [self.oldPasswordField.text length]==0) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your old password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if([self.PasswordField.text  isEqual: @""] || [self.PasswordField.text length]==0) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your new password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if([self.PasswordField.text length] < 6 || [self.PasswordField.text length] >= 20) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your new password must be greater than 6 and smaller than 20 characters",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if(![self.PasswordField.text isEqualToString:self.confirmPasswordField.text]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Confirm password does not match the password.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else{
        NSLog(@"DONE");
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [unity changePasswordByRiderId:[user valueForKey:@"riderId"]
                           oldPassword:self.oldPasswordField.text
                             nPassword:self.PasswordField.text owner:self];
    }
    
    
}

@end
