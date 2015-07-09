//
//  LoginViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"
#import "TennisParser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PasswordTextField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"showMaster"]) {
        [[segue destinationViewController] setUserID: sender];
     }
 }

- (IBAction)LoginAction:(id)sender {
    NSString *userName = self.UsernameTextField.text;
    NSString *password = self.PasswordTextField.text;
    NSString *devKey = @"gtn-dev-key";
    
    TennisParser *parser = [[TennisParser alloc] initWithKey:devKey];
    self.username = [parser parseXMLForIDWithUsername:userName Password:password];
    
    if (self.username) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidLoginNotification"
                                                            object:nil
                                                          userInfo:@{@"userId" : self.username}];
        
        [self performSegueWithIdentifier:@"showMaster" sender:self.username];
    }
    
}

@end
