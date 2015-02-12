#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

NSString *CURRENT_DIR;
NSString *FILE_PATH;
NSString *INIT_PATH  = @"/data/init/init.txt";
NSString *VOLUME_ON  = @"[SOUND:YES]";
NSString *VOLUME_OFF = @"[SOUND:NO]";

BOOL contains(NSString *a, NSString *b) {
    return [a rangeOfString: b].location != NSNotFound;
}

NSData *replaceString(NSString *fileContents, NSString *from, NSString *to) {
    return [[fileContents stringByReplacingOccurrencesOfString: from withString: to]
            dataUsingEncoding: NSUTF8StringEncoding];
}

@implementation AppDelegate

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification {
    CURRENT_DIR = [[[[NSBundle mainBundle] bundlePath] stringByDeletingPathExtension] stringByDeletingLastPathComponent];
    [_showCurrentPath setStringValue: CURRENT_DIR];
     
    FILE_PATH = [CURRENT_DIR stringByAppendingString: INIT_PATH];
    _fileContents = [NSString stringWithContentsOfFile: FILE_PATH
                                              encoding: NSUTF8StringEncoding
                                                 error: NULL];
    if (contains(_fileContents, VOLUME_OFF))
        [_toggleMute setState: YES];
    if (contains(_fileContents, VOLUME_ON))
        [_toggleMute setState: NO];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification { }

- (IBAction)playButtonClick: (id)sender {
    NSString *gamePath = [CURRENT_DIR stringByAppendingString: @"/df&"];
    
    NSTask *task = [NSTask new];
    [task setLaunchPath: @"/bin/bash"];
    [task setArguments: @[@"-c", gamePath]];
    [task launch];
    
    [NSApp terminate: self];
}

- (IBAction)folderButtonClick: (id)sender {
    const char *command =
        [[@"open " stringByAppendingString: CURRENT_DIR] cStringUsingEncoding: NSUTF8StringEncoding];
    
    system(command);
}

- (IBAction)quitButtonClick: (id)sender {
    [NSApp terminate: self];
}

- (IBAction)mute: (id)sender {
    NSData *result;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([sender state] == NSOffState)
        result = replaceString(_fileContents, VOLUME_OFF, VOLUME_ON);
    else
        result = replaceString(_fileContents, VOLUME_ON, VOLUME_OFF);
    
    [fm createFileAtPath: FILE_PATH contents: result attributes: nil];
}
@end
