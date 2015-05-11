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
#import "ChangePasswordViewController.h"
#import "AppDelegate.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController{
    AppDelegate *appDelegate;
}

// init count param to control edit profiles
int countBtnClicked = 0;

//int profileFlag = 0;
// init data ()
NSString *a2 = @"";
NSString *a3 = @"";
NSString *a4 = @"";
NSString *a5 = @"";
NSString *a6 = @"";
//NSString *userName = [];
-(void)showRiderDetailsToEditingWithFname:(NSString *)firstName withLname:(NSString *)lastName withEmail:(NSString *)email withPhoneNo:(NSString *)phoneNo
{
    self.firstNameField.text = firstName;
    self.lastNameField.text = lastName;
    self.emailField.text = email;
    self.phoneNoField.text = phoneNo;
}
-(void)showRiderDetailsReadOnlyWithFname:(NSString *)firstName withLname:(NSString *)lastName withEmail:(NSString *)email withPhoneNo:(NSString *)phoneNo
{
    self.firstNameLb.text = firstName;
    self.lastNameLb.text = lastName;
    self.emailLb.text = email;
    self.phoneNoLb.text = phoneNo;
}


//[UIColor colorWithRed:0.992 green:0 blue:0 alpha:1] /*#fd0000*/
//[UIColor colorWithRed:0.839 green:0.129 blue:0.129 alpha:1] /*#d62121*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",appDelegate.profileFlag);
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    // set corlor
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    NSLog(@"YOURDATA:%@",appDelegate.yoursefl);
    // set data
    if ([appDelegate.profileFlag isEqualToString:@"0"]) {
        a3 = [appDelegate.yoursefl objectForKey:@"firstName"];
        a4 = [appDelegate.yoursefl objectForKey:@"lastName"];
        a5 = [appDelegate.yoursefl objectForKey:@"email"];
        a6 = [appDelegate.yoursefl objectForKey:@"phone"];
        NSLog(@"vao%@", appDelegate.profileFlag);
    }else if([appDelegate.profileFlag isEqualToString:@"1"]){
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        a3 = [userDefault valueForKey:@"firstName"];
        a4 = [userDefault valueForKey:@"lastName"];
        a5 = [userDefault valueForKey:@"email"];
        a6 = [userDefault valueForKey:@"phone"];
        NSLog(@"LOG vao:%@",appDelegate.profileFlag);
    }else{
        NSLog(@"SOME thing wrong");
    }

    // disable to change profiles
    self.firstNameField.hidden = YES;
    self.lastNameField.hidden = YES;
    self.emailField.hidden = YES;
    self.phoneNoField.hidden = YES;
    // show Label
    NSLog(@"COUNT load:%d",countBtnClicked);
    countBtnClicked = 0;
    [self showRiderDetailsReadOnlyWithFname:a3
                                     withLname:a4
                                     withEmail:a5
                                   withPhoneNo:a6];
    // to dimis keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    // set color
    //[self.ViewAll setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];
//    [UIColor colorWithRed:1 green:0.251 blue:0 alpha:1] /*#ff4000*/
    [self.viewAccount setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [self.viewUsualLocation setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    
    
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
    //self.passwordChangeBtn.hidden = NO;
    //enable editing
    self.firstNameField.hidden = NO;
    self.lastNameField.hidden = NO;
    self.emailField.hidden = NO;
    self.phoneNoField.hidden = NO;
    // hiding label
    self.firstNameLb.hidden = YES;
    self.lastNameLb.hidden = YES;
    self.emailLb.hidden = YES;
    self.phoneNoLb.hidden = YES;
    
    
    if (countBtnClicked==0) {
        [self showRiderDetailsToEditingWithFname:a3 withLname:a4 withEmail:a5 withPhoneNo:a6];
    }
    if(countBtnClicked>0){
        NSLog(@"COUNT on if:%d",countBtnClicked);
        [self showRiderDetailsReadOnlyWithFname:self.firstNameField.text
                                         withLname:self.lastNameField.text
                                         withEmail:self.emailField.text
                                       withPhoneNo:self.phoneNoField.text];
        [self showRiderDetailsToEditingWithFname:self.firstNameField.text
                                          withLname:self.lastNameField.text
                                          withEmail:self.emailField.text
                                        withPhoneNo:self.phoneNoField.text];
    }
    countBtnClicked++;
    NSLog(@"COUNT edit:%d",countBtnClicked);
}
-(void)hideKeyBoard {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.phoneNoField resignFirstResponder];
}
- (IBAction)doneEditProfile:(id)sender {
    appDelegate.profileFlag = @"1";
    self.editBtn.hidden =NO;
    self.doneEditBtn.hidden = YES;
    //self.passwordChangeBtn.hidden = YES;
    // disable to change profile
    self.firstNameField.hidden = YES;
    self.lastNameField.hidden = YES;
    self.emailField.hidden = YES;
    self.phoneNoField.hidden = YES;

    // hiding label
    self.firstNameLb.hidden = NO;
    self.lastNameLb.hidden = NO;
    self.emailLb.hidden = NO;
    self.phoneNoLb.hidden = NO;

    // show data change
    NSUserDefaults *userChange = [NSUserDefaults standardUserDefaults];
    [userChange setValue:self.firstNameField.text forKey:@"firstName"];
    [userChange setValue:self.lastNameField.text forKey:@"lastName"];
    [userChange setValue:self.emailField.text forKey:@"email"];
    [userChange setValue:self.phoneNoField.text forKey:@"phone"];

    //check data
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ( [self.firstNameField.text isEqualToString:@""])
    {
        
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your first name",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
        if([self.emailField.text isEqualToString:@""]||self.emailField.text==nil)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
            
            
            
        }
        else if ([emailTest evaluateWithObject:self.emailField.text] == NO)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input corect email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
        }

        else
        {
            if( [self.phoneNoField.text isEqualToString:@""]|| self.phoneNoField.text==nil)
            {
                UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                 message:NSLocalizedString(@"please input Phonenumber",nil)
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                       otherButtonTitles:nil, nil];
                [alertTmp show];
            }else{
                
                
                [unity updateByRiderById:[appDelegate.yoursefl objectForKey:@"riderId"]
                               firstName:self.firstNameField.text
                                lastName:self.lastNameField.text
                                   email:self.emailField.text
                                 phoneNo:self.phoneNoField.text owner:self];
                NSLog(@"COUNT done:%d",countBtnClicked);
            }
        }
}
-(void)checkUpdateRider{
    NSLog(@"MESSAGE:%@",self.message);
    if ([[self.message objectForKey:@"message"] isEqualToString:@"SUCCESS"]) {
         NSUserDefaults *userChange = [NSUserDefaults standardUserDefaults];
        [self.firstNameLb setText:[userChange valueForKey:@"firstName"]];
        [self.lastNameLb setText:[userChange valueForKey:@"lastName"]];
        [self.emailLb setText:[userChange valueForKey:@"email"]];
        [self.phoneNoLb setText:[userChange valueForKey:@"phone"]];
        

    }
    
}

- (IBAction)passwordChange:(id)sender {
    
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    ChangePasswordViewController *controller = (ChangePasswordViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"ChangePassword"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)addAddress:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    ChangeAddressViewController *controller = (ChangeAddressViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ChangeAddress"];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

- (IBAction)addMoreJob:(id)sender {
    
}
@end
