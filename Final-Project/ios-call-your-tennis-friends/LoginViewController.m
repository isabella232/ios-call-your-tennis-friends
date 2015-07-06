//
//  LoginViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"

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
    NSString *devKey = @"gtn-developer-key";
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getSession&format=raw&username=%@&password=%@&devKey=%@", userName, password, devKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if(!error)
    {
        //NSLog(@"Response from server = %@", responseString);
        
        NSArray *components1 = [responseString componentsSeparatedByString:@"<userID>"];
        NSArray *components2 = [components1[1] componentsSeparatedByString:@"</userID>"];
        self.username = components2[0];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidLoginNotification"
                                                            object:nil
                                                          userInfo:@{@"userId" : self.username}];
        
        [self performSegueWithIdentifier:@"showMaster" sender:self.username];
    }
}

@end
