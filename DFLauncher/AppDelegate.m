#import "AppDelegate.h"
#define UPDATE_FILE _fileContents = loadUTF8File(FILE_PATH)
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

NSString *CURRENT_DIR;
NSString *FILE_PATH;
NSString *INIT_PATH  = @"/data/init/init.txt";
NSString *VOLUME_ON  = @"[SOUND:YES]";
NSString *VOLUME_OFF = @"[SOUND:NO]";
NSString *RETINA_ON  = @"[PRINT_MODE:STANDARD]";
NSString *RETINA_OFF = @"[PRINT_MODE:2D]";

BOOL contains(NSString *a, NSString *b) {
    return [a rangeOfString: b].location != NSNotFound;
}

NSData *replaceString(NSString *fileContents, NSString *from, NSString *to) {
    return [[fileContents stringByReplacingOccurrencesOfString: from withString: to]
            dataUsingEncoding: NSUTF8StringEncoding];
}

NSData *toggleReplaceString(BOOL toggle, NSString *fileContents, NSString *from, NSString *to) {
    if (toggle) return replaceString(fileContents, from, to);
    else return replaceString(fileContents, to, from);
}

NSString *loadUTF8File(NSString *path) {
    return [NSString stringWithContentsOfFile: path
                                     encoding: NSUTF8StringEncoding
                                     error: NULL];
}

@implementation AppDelegate

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification {
    CURRENT_DIR = [[[[NSBundle mainBundle] bundlePath] stringByDeletingPathExtension] stringByDeletingLastPathComponent];
    [_showCurrentPath setStringValue: CURRENT_DIR];
     
    FILE_PATH = [CURRENT_DIR stringByAppendingString: INIT_PATH];
    UPDATE_FILE; //_fileContents = loadUTF8File(FILE_PATH);
    
    // mute on/off
    if (contains(_fileContents, VOLUME_OFF))
        [_toggleMute setState: YES];
    if (contains(_fileContents, VOLUME_ON))
        [_toggleMute setState: NO];
    
    // retina screen fix on/off
    if (contains(_fileContents, RETINA_OFF))
        [_toggleRetina setState: NO];
    if (contains(_fileContents, RETINA_ON))
        [_toggleRetina setState: YES];
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
    /*
    if ([sender state] == NSOffState)
        result = replaceString(_fileContents, VOLUME_OFF, VOLUME_ON);
    else
        result = replaceString(_fileContents, VOLUME_ON, VOLUME_OFF);
     */
    
    result = toggleReplaceString([sender state] == NSOffState, _fileContents, VOLUME_OFF, VOLUME_ON);
    
    [fm createFileAtPath: FILE_PATH contents: result attributes: nil];
    UPDATE_FILE;
}

- (IBAction)retinaMode:(id)sender {
    NSData *result;
    NSFileManager *fm = [NSFileManager defaultManager];
    /*
    if ([sender state] == NSOffState)
        result = replaceString(_fileContents, RETINA_ON, RETINA_OFF);
    else
        result = replaceString(_fileContents, RETINA_OFF, RETINA_ON);
    */
    result = toggleReplaceString([sender state] == NSOffState, _fileContents, RETINA_ON, RETINA_OFF);
    
    [fm createFileAtPath: FILE_PATH contents: result attributes: nil];
    UPDATE_FILE;
}
@end
