//
//  ViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "unity.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AppDelegate*appdelegate;
}
@synthesize dataAutoLogin;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"GetDevideToken" object:nil];

    // Do any additional setup after loading the view, typically from a nib.

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"GetDevideToken"]) {
        [unity AutoLogin:appdelegate.deviceToken owner:self];
//        [unity AutoLogin:@"123" owner:self];

    }
}
-(void)CheckLogin
{
    NSLog(@"auto:%@",dataAutoLogin);
    appdelegate.yoursefl = (NSMutableDictionary*)dataAutoLogin;
    NSString *idDriver=[dataAutoLogin objectForKey:@"riderId"];
    if ([idDriver isEqual:[NSNull null]]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[self.dataAutoLogin objectForKey:@"riderId"] forKey:@"riderId"];
        appdelegate.yoursefl=(NSMutableDictionary*)self.dataAutoLogin;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
        HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
        [self.navigationController pushViewController:controller animated:YES];    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
