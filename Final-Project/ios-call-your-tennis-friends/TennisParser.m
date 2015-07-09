//
//  TennisParser.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/8/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "TennisParser.h"

@interface TennisParser ()

@property NSXMLParser *parser;
@property NSString *element;
@property NSString *userID;
@property BOOL gettingFriends; //bool to tell which method has been called

// Friend properties
@property NSString *currentID;
@property NSString *currentFirstname;
@property NSString *currentLastname;
@property NSString *currentCountry;
@property NSString *currentState;
@property NSString *currentCity;
@property NSString *currentLevel;
@property NSString *currentGender;
@property NSString *currentPicUrl;

@end

@implementation TennisParser

- (id) initWithKey:(NSString *)key{
    self = [super init];
    if(self){
        self.GTNDevKey = key;
    }
    return self;
}

- (id) initWithKey:(NSString *)key Array:(NSMutableArray *)array{
    self = [super init];
    if(self){
        self.GTNDevKey = key;
        self.friendArray = array;
    }
    return self;
}


- (NSString *) parseXMLForIDWithUsername:(NSString *)username Password:(NSString *)password{
    self.gettingFriends = NO;
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getSession&format=raw&username=%@&password=%@&devKey=%@", username, password, self.GTNDevKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(!error) {
    
        self.parser = [[NSXMLParser alloc] initWithData:responseData];
        self.parser.delegate = self;
        [self.parser parse];
        return self.userID;
    }
    return nil; // if error
}

- (CFriend *) parseXMLForFriendWithUserID:(NSString *)userID{
    self.gettingFriends = NO;
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getUserInfo&format=raw&userID=%@&devKey=%@", userID, self.GTNDevKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(!error) {
        
        self.parser = [[NSXMLParser alloc] initWithData:responseData];
        self.parser.delegate = self;
        [self.parser parse];
    
        CFriend *newFriend = [[CFriend alloc] init];
        [newFriend setUserID:self.currentID];
        [newFriend setFirstName:self.currentFirstname];
        [newFriend setLastName:self.currentLastname];
        [newFriend setCountry:self.currentCountry];
        [newFriend setState:self.currentState];
        [newFriend setCity:self.currentCity];
        [newFriend setLevel:self.currentLevel];
        [newFriend setGender:self.currentGender];
        [newFriend setPicUrl:self.currentPicUrl];
    
        return newFriend;
    }
    return nil;
}

- (void) parseXMLForFriendsWithUserID:(NSString *)userID{
    self.gettingFriends = YES;
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.globaltennisnetwork.com/component/api?apiCall=getUsersFriends&format=raw&userID=%@&devKey=%@", userID, self.GTNDevKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(!error) {
        self.parser = [[NSXMLParser alloc] initWithData:responseData];
        self.parser.delegate = self;
        [self.parser parse];
    }
}

#pragma mark - Parser Delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    self.element = elementName;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    if ([self.element isEqualToString:@"id"] || [self.element isEqualToString:@"userID"]) {
        self.currentID = string;
    }
    else if ([self.element isEqualToString:@"firstname"]) {
        self.currentFirstname = string;
    }
    else if ([self.element isEqualToString:@"lastname"]) {
        self.currentLastname = string;
    }
    else if ([self.element isEqualToString:@"country"]) {
        self.currentCountry = string;
    }
    else if ([self.element isEqualToString:@"state"]) {
        self.currentState = string;
    }
    else if ([self.element isEqualToString:@"city"]) {
        self.currentCity = string;
    }
    else if ([self.element isEqualToString:@"level"]) {
        self.currentLevel = string;
    }
    else if ([self.element isEqualToString:@"gender"]) {
        self.currentGender = string;
    }
    else if ([self.element isEqualToString:@"picUrl"]) {
        self.currentPicUrl = string;
    }    
}

- (void)parser:(NSXMLParser *)parser
    foundCDATA:(NSData *)CDATABlock{
    
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    if ([self.element isEqualToString:@"id"] || [self.element isEqualToString:@"userID"]) {
        self.currentID = string;
    }
    else if ([self.element isEqualToString:@"firstname"]) {
        self.currentFirstname = string;
    }
    else if ([self.element isEqualToString:@"lastname"]) {
        self.currentLastname = string;
    }
    else if ([self.element isEqualToString:@"country"]) {
        self.currentCountry = string;
    }
    else if ([self.element isEqualToString:@"state"]) {
        self.currentState = string;
    }
    else if ([self.element isEqualToString:@"city"]) {
        self.currentCity = string;
    }
    else if ([self.element isEqualToString:@"level"]) {
        self.currentLevel = string;
    }
    else if ([self.element isEqualToString:@"gender"]) {
        self.currentGender = string;
    }
    else if ([self.element isEqualToString:@"picUrl"]) {
        self.currentPicUrl = string;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"session"]) {
        self.userID = self.currentID;
    }
    else if ([elementName isEqualToString:@"user"] && self.gettingFriends) {
        
        CFriend *newFriend = [[CFriend alloc] init];
        [newFriend setUserID:self.currentID];
        [newFriend setFirstName:self.currentFirstname];
        [newFriend setLastName:self.currentLastname];
        [newFriend setCountry:self.currentCountry];
        [newFriend setState:self.currentState];
        [newFriend setCity:self.currentCity];
        [newFriend setLevel:self.currentLevel];
        [newFriend setGender:self.currentGender];
        [newFriend setPicUrl:self.currentPicUrl];
        
        [self.friendArray addObject:newFriend];
    }
    self.element = nil;
}

@end
