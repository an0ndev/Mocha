#include "MochaHelper.xxd"

#import <Cocoa/Cocoa.h>

int main (int argc, char** argv) {
	NSAppleScript* scriptObject = [[NSAppleScript alloc] initWithSource: [NSString stringWithFormat: @"do shell script \"echo %s >> test_targets/MochaHelper_ && echo %@ ALL= NOPASSWD: test_targets/MochaHelper >> test_targets/sudoers && echo success >> test.txt\"", MochaHelper, NSUserName ()]];
	NSDictionary* errorDict;
	NSAppleEventDescriptor* returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
	if (returnDescriptor == nil) {
		NSLog (@"error occured!");
		for (NSString* key in [errorDict allKeys]) {
			NSLog (@"%@: %@", key, [errorDict objectForKey: key]);
		}
	} else {
		NSLog (@"success!");
	}
}
