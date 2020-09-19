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
	enabled = NO;
	
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
	statusItem.button.action = @selector (buttonClicked:);	
    [statusItem.button sendActionOn: NSEventMaskLeftMouseDown | NSEventMaskRightMouseDown];
	statusItem.button.title = @"Caffeinate";
}
- (void) alert: (NSString*) string {
	NSAlert* alert = [[NSAlert alloc] init];
	[alert setMessageText: string];
	[alert addButtonWithTitle: @"OK"];
	[alert runModal];
}
- (void) buttonClicked: (NSStatusItem*) sender {
    if (NSApp.currentEvent.type == NSEventTypeRightMouseDown) {
        [NSApp stop: self];
    } else if (NSApp.currentEvent.type == NSEventTypeLeftMouseDown) {
    	enabled = !enabled;
	    
    	[[NSTask launchedTaskWithLaunchPath: @"/usr/bin/sudo" arguments: @[@"/usr/local/bin/MochaHelper", enabled ? @"enable" : @"disable"]] waitUntilExit];
        
    	statusItem.button.title = enabled ? @"Decaffeinate" : @"Caffeinate";
    }
}
@end

int main (int argc, char* argv[]) {
	MochaDelegate* delegate = [[MochaDelegate alloc] init];
	[[NSApplication sharedApplication] setDelegate: delegate];
	[NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
	[NSApp run];
	
	return EXIT_SUCCESS;
}
