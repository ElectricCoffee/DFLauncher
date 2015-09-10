#import "AppDelegate.h"
//#define UPDATE_FILE _fileContents = loadUTF8File(FILE_PATH)
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

NSString *const INIT_PATH  = @"/data/init/init.txt";
NSString *const VOLUME_ON  = @"[SOUND:YES]";
NSString *const VOLUME_OFF = @"[SOUND:NO]";
NSString *const RETINA_ON  = @"[PRINT_MODE:STANDARD]";
NSString *const RETINA_OFF = @"[PRINT_MODE:2D]";
NSString *const FULL_ON    = @"[WINDOWED:NO]";
NSString *const FULL_OFF   = @"[WINDOWED:YES]";

//NSData *toggleReplaceString(BOOL toggle, NSString *fileContents, NSString *from, NSString *to) {
//    if (toggle) //return replaceString(fileContents, from, to);
//        return [fileContents replaceString: from withString: to];
//    else //return replaceString(fileContents, to, from);
//        return [fileContents replaceString: to withString: from];
//}

//NSString *loadUTF8File(NSString *path) {
//    return [NSString stringWithContentsOfFile: path
//                                     encoding: NSUTF8StringEncoding
//                                     error: NULL];
//}

@implementation AppDelegate

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification {
    _currentDir = [[[[NSBundle mainBundle] bundlePath] stringByDeletingPathExtension] stringByDeletingLastPathComponent];
    [_showCurrentPath setStringValue: _currentDir];
     
    _filePath = [_currentDir stringByAppendingString: INIT_PATH];
    _fileContents = [_filePath loadUTF8File];
    
    // mute on/off
    if ([_fileContents containsString: VOLUME_OFF])
        [_toggleMute setState: YES];
    if ([_fileContents containsString: VOLUME_ON])
        [_toggleMute setState: NO];
    
    // retina screen fix on/off
    if ([_fileContents containsString: RETINA_OFF])
        [_toggleRetina setState: NO];
    if ([_fileContents containsString: RETINA_ON])
        [_toggleRetina setState: YES];
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
    NSData *result;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    result = //toggleReplaceString([sender state] == NSOffState, _fileContents, VOLUME_OFF, VOLUME_ON);
        [_fileContents replaceString: VOLUME_OFF
                          withString: VOLUME_ON
                          withToggle: [sender state] == NSOffState];
    
    [fm createFileAtPath: _filePath contents: result attributes: nil];
    _fileContents = [_filePath loadUTF8File];
}

- (IBAction)retinaMode: (id)sender {
    NSData *result;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    result = //toggleReplaceString([sender state] == NSOffState, _fileContents, RETINA_ON, RETINA_OFF);
        [_fileContents replaceString: RETINA_ON
                          withString: RETINA_OFF
                          withToggle: [sender state] == NSOffState];
    
    [fm createFileAtPath: _filePath contents: result attributes: nil];
    _fileContents = [_filePath loadUTF8File];
}
@end
