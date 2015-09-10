//
//  NSString+RichString.m
//  DFLauncher
//
//  Created by Nikolaj Lepka on 10/09/15.
//  Copyright (c) 2015 Electric Coffee. All rights reserved.
//

#import "NSString+RichString.h"

@implementation NSString (RichString)

- (NSData*) replaceString: (NSString *)oldStr withString: (NSString *)newStr {
    return [[self stringByReplacingOccurrencesOfString: oldStr withString: newStr]
            dataUsingEncoding: NSUTF8StringEncoding];
}

- (NSData *) replaceString: (NSString *)oldStr withString: (NSString *)newStr withToggle: (BOOL)toggle {
    if (toggle) return [self replaceString: oldStr withString: newStr];
    else return [self replaceString: newStr withString: oldStr];
}

- (NSString *) replaceString: (NSString *)oldStr withString: (NSString *)newStr withSender: (id)sender inFile: (NSString *)path {
    NSData *result = [self replaceString: oldStr
                              withString: newStr
                              withToggle: [sender state] == NSOffState];
    
    [[NSFileManager defaultManager] createFileAtPath: path contents: result attributes: nil];
    return [path loadUTF8File];
}

- (NSString *) loadUTF8File {
    return [NSString stringWithContentsOfFile: self encoding: NSUTF8StringEncoding error: NULL];
}



@end
