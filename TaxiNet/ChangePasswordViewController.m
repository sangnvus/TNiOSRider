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
    ///*#3b5998 mau 1*/ [UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1] /*#3b5998*/
    ///*#8b9dc3 mau 2*/ [UIColor colorWithRed:0.545 green:0.616 blue:0.765 alpha:1] /*#8b9dc3*/
    //[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1] /*#dfe3ee*/ mau 3
    //[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1] /*#f7f7f7*/ mau 4
    [self.viewBanner setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];

    [self.viewContent setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    
    
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
-(void)checkPassword
{

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
    else if(![self.PasswordField.text isEqualToString:self.confirmPasswordField.text]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Password does not match the confirm password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else{
        NSLog(@"DONE");
    }
}

- (IBAction)doBack:(id)sender {
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    ProfileViewController *controller = (ProfileViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)doSave:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [unity changePasswordByRiderId:[user valueForKey:@"riderId"]
                       oldPassword:self.oldPasswordField.text
                         nPassword:self.PasswordField.text];
    
}
@end
