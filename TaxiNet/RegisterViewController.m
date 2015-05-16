//
//  RegisterViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RegisterViewController.h"
#import "unity.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "TermsViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
bool checked=NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scroolview setContentSize:CGSizeMake(320,700)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
}

-(void)hideKeyboard{
    [self.EmailUser resignFirstResponder];
    [self.PassUser resignFirstResponder];
    [self.RepassUser resignFirstResponder];
    [self.NameUser resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.PhoneUser resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkResponseData:(NSString*)data{
    NSLog(@"RES DATA:%@",data);
    if ([data isEqualToString:@"EXIST_ACCOUNT"]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"E-mail already exists. Please enter another e-mail.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([data isEqualToString:@"SUCCESS"]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Congratulations! You have successfully registered.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self.navigationController pushViewController:controller animated:YES];

    }
    
}
- (IBAction)save:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    // check white space
   // NSRange whiteSpacea = [self.NameUser.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([self.EmailUser.text isEqualToString:@""]||self.EmailUser.text==nil) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your e-mail",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([emailTest evaluateWithObject:self.EmailUser.text] == NO)
    {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"E-mail incorrect! Please enter correct e-mail.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([self.EmailUser.text length] >= 50){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your e-mail too long.(less than or equal to 50 characters)",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if([self.PassUser.text isEqualToString:@""]|| self.PassUser.text==nil){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];

        
        
    }else if ([self.PassUser.text length] >= 20 || [self.PassUser.text length] < 6){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your password must be greater than 5 characters and less than or equal to 20 characters)",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    } else if (![self.PassUser.text isEqualToString:self.RepassUser.text]){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Password not match",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    
        
    }else if ([self.NameUser.text isEqualToString:@""] || self.NameUser.text == nil){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your first name",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([self.NameUser.text length] >= 30){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your first name too long( less than or equal to 30 characters).",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([self.lastName.text isEqualToString:@""] || self.lastName.text == nil ){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your last name",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        
    }
    else if ([self.lastName.text length] >= 50){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your last name too long.(less than or equal to 50 characters)",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([self.PhoneUser.text isEqualToString:@""] || self.PhoneUser.text == nil){
        
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your phone number",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if ([self.PhoneUser.text length] >= 20){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your phone number too long.(less than or equal to 20",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if (checked==NO){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please tap the checkbox to continue",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else{
        NSString *languageCode = @"en";
        NSString *countryCode = @"VN";
        NSString *data = [NSString stringWithFormat:   @"{\"email\":\"%@\",\"password\":\"%@\",\"firstname\":\"%@\",\"lastname\":\"%@\",\"phone\":\"%@\",\"language\":\"%@\",\"countrycode\":\"%@\"}",self.EmailUser.text,self.PassUser.text,self.NameUser.text,self.lastName.text,self.PhoneUser.text,languageCode,countryCode];
        
        NSLog(@"%@", data);
        
        NSData *plainData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String = [plainData base64EncodedStringWithOptions:0];
        NSLog(@"BASE%@,",base64String);
        //    NSDictionary *encode = [NSDictionary dictionaryWithObject:base64String forKey:@"valu"];
        
        [unity registerByEmail:base64String owner:self];
        
        
    }
    
    
}

- (IBAction)doCancel:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)goToTermsScreen:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"AppLogin" bundle:nil];
    TermsViewController *controller = (TermsViewController*)[story instantiateViewControllerWithIdentifier:@"TermsViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
- (IBAction)checkRule:(id)sender {
    if (!checked) {
        UIImage *btnImage = [UIImage imageNamed:@"checkBox.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=YES;
        
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"checkbox_non.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=NO;
    }
}
@end
