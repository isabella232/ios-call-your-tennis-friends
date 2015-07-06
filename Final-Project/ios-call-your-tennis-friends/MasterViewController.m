//
//  MasterViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CallViewController.h"
#import "AppDelegate.h"
#import "CFriend.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestFriends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CFriend *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CFriend *object = self.objects[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [object firstName], [object lastName]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void) requestFriends {
    NSString *devKey = @"gtn-developer-key";
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getUsersFriends&format=raw&userID=%@&devKey=%@", self.userID, devKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if(!error)
    {
        NSArray *components1 = [responseString componentsSeparatedByString:@"<user>"];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:components1];
        [tempArray removeObjectAtIndex:0];
        components1 = [NSArray arrayWithArray:tempArray];
        
        for (NSString *component in components1){
            NSArray *components2 = [component componentsSeparatedByString:@"</user>"];
            NSString *friendInfo = components2[0];
            
            CFriend *newFriend = [[CFriend alloc] init];
            NSArray *components3, *components4;
            
            components3 = [friendInfo componentsSeparatedByString:@"<id>"];
            components4 = [components3[1] componentsSeparatedByString:@"</id>"];
            [newFriend setUserID:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<firstname><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></firstname>"];
            [newFriend setFirstName:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<lastname><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></lastname>"];
            [newFriend setLastName:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<country><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></country>"];
            [newFriend setCountry:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<state><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></state>"];
            [newFriend setState:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<city><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></city>"];
            [newFriend setCity:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<level>"];
            components4 = [components3[1] componentsSeparatedByString:@"</level>"];
            [newFriend setLevel:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<gender>"];
            components4 = [components3[1] componentsSeparatedByString:@"</gender>"];
            [newFriend setGender:components4[0]];
            
            components3 = [friendInfo componentsSeparatedByString:@"<picUrl><![CDATA["];
            components4 = [components3[1] componentsSeparatedByString:@"]]></picUrl>"];
            [newFriend setPicUrl:components4[0]];
            
            if (!self.objects) {
                self.objects = [[NSMutableArray alloc] init];
            }
            [self.objects addObject:newFriend];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_objects.count-1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];
        }
    }
}


@end
