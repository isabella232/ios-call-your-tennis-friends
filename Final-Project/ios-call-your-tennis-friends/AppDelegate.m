//
//  AppDelegate.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "AppDelegate.h"
#import "CallViewController.h"
#import "CFriend.h"

@interface AppDelegate () <SINServiceDelegate, SINCallClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id config = [SinchService configWithApplicationKey:@"your-applicaiton-key"
                                     applicationSecret:@"your-application-secret"
                                       environmentHost:@"sandbox.sinch.com"];
    
    id<SINService> sinch = [SinchService serviceWithConfig:config];
    sinch.delegate = self;
    sinch.callClient.delegate = self;
    
    void (^onUserDidLogin)(NSString *) = ^(NSString *userId) {
        [sinch logInUserWithId:userId];
    };
    
    self.sinch = sinch;
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:@"UserDidLoginNotification"
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) { onUserDidLogin(note.userInfo[@"userId"]); }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - SINCallClientDelegate

- (void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call {
    
    UIViewController *top = self.window.rootViewController;
    
    NSString *devKey = @"gtn-developer-key";
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getUserInfo&format=raw&userID=%@&devKey=%@", [call remoteUserId], devKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if(!error)
    {
        CFriend *callingFriend = [[CFriend alloc] init];
        
        NSArray *components1 = [responseString componentsSeparatedByString:@"<firstname><![CDATA["];
        NSArray *components2 = [components1[1] componentsSeparatedByString:@"]]></firstname>"];
        [callingFriend setFirstName: components2[0]];
        
        components1 = [responseString componentsSeparatedByString:@"<lastname><![CDATA["];
        components2 = [components1[1] componentsSeparatedByString:@"]]></lastname>"];
        [callingFriend setLastName: components2[0]];
        
        components1 = [responseString componentsSeparatedByString:@"<picUrl><![CDATA["];
        components2 = [components1[1] componentsSeparatedByString:@"]]></picUrl>"];
        [callingFriend setPicUrl:components2[0]];
        
        CallViewController *controller = [top.storyboard instantiateViewControllerWithIdentifier:@"callScreen"];
        [controller setCallingFriend:callingFriend];
        [controller setCall:call];
        [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
        
    }
}


@end
