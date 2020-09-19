#import <Cocoa/Cocoa.h>

@interface MochaDelegate : NSObject <NSApplicationDelegate> {
	NSImage* enabledImage;
	NSImage* disabledImage;
	
	BOOL enabled;
	NSStatusItem* statusItem;
}
- (id) init;
- (void) alert: (NSString*) string;
- (void) applicationDidFinishLaunching: (NSNotification*) notification;
- (void) buttonClicked: (NSStatusItem*) sender;
@end

@implementation MochaDelegate
- (id) init {
	return [super init];
}
- (void) applicationDidFinishLaunching: (NSNotification*) notification {
	NSString* resourcePath = @"/Library/Application Support/Mocha/";
	NSString* enabledPath = [resourcePath stringByAppendingPathComponent: @"active.png"];
	NSString* disabledPath = [resourcePath stringByAppendingPathComponent: @"inactive.png"];
	enabledImage = [[NSImage alloc] initByReferencingFile: enabledPath];
	disabledImage = [[NSImage alloc] initByReferencingFile: disabledPath];
	enabled = NO;
	
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSSquareStatusItemLength];
	statusItem.button.action = @selector (buttonClicked:);
	
	statusItem.button.image = disabledImage;
}
- (void) alert: (NSString*) string {
	NSAlert* alert = [[NSAlert alloc] init];
	[alert setMessageText: string];
	[alert addButtonWithTitle: @"OK"];
	[alert runModal];
}
- (void) buttonClicked: (NSStatusItem*) sender {
	enabled = !enabled;
	
	[[NSTask launchedTaskWithLaunchPath: @"/usr/bin/sudo" arguments: @[@"/usr/bin/MochaHelper", enabled ? @"enable" : @"disable"]] waitUntilExit];
	
	statusItem.button.image = enabled ? enabledImage : disabledImage;
}
@end

int main (int argc, char* argv[]) {
	MochaDelegate* delegate = [[MochaDelegate alloc] init];
	[[NSApplication sharedApplication] setDelegate: delegate];
	[NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
	[NSApp run];
	
	return EXIT_SUCCESS;
}
