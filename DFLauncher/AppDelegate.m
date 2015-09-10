#import "AppDelegate.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

NSString *const INIT_PATH  = @"/data/init/init.txt"
       , *const VOLUME_ON  = @"[SOUND:YES]"
       , *const VOLUME_OFF = @"[SOUND:NO]"
       , *const RETINA_ON  = @"[PRINT_MODE:STANDARD]"
       , *const RETINA_OFF = @"[PRINT_MODE:2D]"
       , *const FULL_ON    = @"[WINDOWED:NO]"
       , *const FULL_OFF   = @"[WINDOWED:YES]";

@implementation AppDelegate

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification {
    _currentDir = [[[[NSBundle mainBundle] bundlePath] stringByDeletingPathExtension] stringByDeletingLastPathComponent];
    [_showCurrentPath setStringValue: _currentDir];
     
    _filePath = [_currentDir stringByAppendingString: INIT_PATH];
    _fileContents = [_filePath loadUTF8File];
    
    // mute on/off
    if ([_fileContents containsString: VOLUME_OFF])
        [_toggleMute setState: YES];
    else if ([_fileContents containsString: VOLUME_ON])
        [_toggleMute setState: NO];
    
    // retina screen fix on/off
    if ([_fileContents containsString: RETINA_OFF])
        [_toggleRetina setState: NO];
    else if ([_fileContents containsString: RETINA_ON])
        [_toggleRetina setState: YES];
    
    // full-screen on/off
    if ([_fileContents containsString: FULL_OFF])
        [_toggleFullScreen setState: NO];
    else if ([_fileContents containsString: FULL_ON])
        [_toggleFullScreen setState: YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification { }

- (IBAction)playButtonClick: (id)sender {
    NSString *gamePath = [_currentDir stringByAppendingString: @"/df&"];
    
    NSTask *task = [NSTask new];
    [task setLaunchPath: @"/bin/bash"];
    [task setArguments: @[@"-c", gamePath]];
    [task launch];
    
    [NSApp terminate: self];
}

- (IBAction)folderButtonClick: (id)sender {
    const char *command =
        [[@"open " stringByAppendingString: _currentDir] cStringUsingEncoding: NSUTF8StringEncoding];
    
    system(command);
}

- (IBAction)quitButtonClick: (id)sender {
    [NSApp terminate: self];
}

- (IBAction)mute: (id)sender {
    _fileContents = [_fileContents replaceString: VOLUME_OFF
                                      withString: VOLUME_ON
                                      withSender: sender
                                          inFile: _filePath];
}

- (IBAction)retinaMode: (id)sender {
    _fileContents = [_fileContents replaceString: RETINA_ON
                                      withString: RETINA_OFF
                                      withSender: sender
                                          inFile: _filePath];
}

- (IBAction)fullScreenMode:(id)sender {
    _fileContents = [_fileContents replaceString: FULL_ON
                                      withString: FULL_OFF
                                      withSender: sender
                                          inFile: _filePath];
}
@end
