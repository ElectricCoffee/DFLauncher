//
//  NSString+RichString.h
//  DFLauncher
//
//  Created by Nikolaj Lepka on 10/09/15.
//  Copyright (c) 2015 Electric Coffee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RichString)

- (NSData *) replaceString: (NSString *)oldStr withString: (NSString *)newStr;
- (NSData *) replaceString: (NSString *)oldStr withString: (NSString *)newStr withToggle: (BOOL)toggle;
- (NSString *) loadUTF8File;

@end
