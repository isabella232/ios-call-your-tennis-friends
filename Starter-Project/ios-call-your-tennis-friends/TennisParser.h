//
//  TennisParser.h
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/9/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFriend.h"

@interface TennisParser : NSObject <NSXMLParserDelegate>

@property NSString *GTNDevKey;
@property NSMutableArray *friendArray;

- (id) initWithKey:(NSString *)key;
- (id) initWithKey:(NSString *)key Array:(NSMutableArray *)array;
- (NSString *) parseXMLForIDWithUsername:(NSString *)username Password:(NSString *)password;
- (CFriend *) parseXMLForFriendWithUserID:(NSString *)userID;
- (void) parseXMLForFriendsWithUserID:(NSString *)userID;

@end
