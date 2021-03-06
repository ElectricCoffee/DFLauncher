//
//  AppDelegate.h
//  DFLauncher
//
//  Created by Electric Coffee on 11/02/15.
//  Copyright (c) 2015 Electric Coffee. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <stdio.h>
#import "NSString+RichString.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSString *_fileContents, *_currentDir, *_filePath;
}

// outlets
@property (weak) IBOutlet NSButton *toggleMute;
@property (weak) IBOutlet NSButton *toggleRetina;
@property (weak) IBOutlet NSTextField *showCurrentPath;
@property (weak) IBOutlet NSButton *toggleFullScreen;

// actions
- (IBAction)playButtonClick: (id)sender;
- (IBAction)folderButtonClick: (id)sender;
- (IBAction)quitButtonClick: (id)sender;
- (IBAction)mute: (id)sender;
- (IBAction)retinaMode:(id)sender;
- (IBAction)fullScreenMode:(id)sender;

@end

