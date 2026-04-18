#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <dlfcn.h>
#import "./fishhook.h"

// Define the original MGCopyAnswer function pointer
CFTypeRef (*orig_MGCopyAnswer)(CFStringRef question);

// Create the replacement function
CFTypeRef hooked_MGCopyAnswer(CFStringRef question) {
    // Check if the app is asking for the device's artwork subtype
    if (CFStringCompare(question, CFSTR("ArtworkDeviceSubType"), 0) == kCFCompareEqualTo) {
        
        // 2556 is the ArtworkDeviceSubType for the iPhone 14 Pro.
        // Spoofing this value tells the app's UI to render the Dynamic Island safe areas.
        int subtype = 2556; 
        return CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &subtype);
    }
    
    // You can also spoof the hardware model string if the app checks that directly
    if (CFStringCompare(question, CFSTR("hw.machine"), 0) == kCFCompareEqualTo) {
        return CFStringCreateWithCString(kCFAllocatorDefault, "iPhone15,2", kCFStringEncodingUTF8);
    }
    
    // For all other queries, return the real device's actual response
    return orig_MGCopyAnswer(question);
}

// The constructor attribute ensures this runs immediately when the dylib is loaded into memory
__attribute__((constructor))
static void initialize_dynamic_island_spoof() {
    // Set up the fishhook rebinding struct
    struct rebinding rebindings[] = {
        {"MGCopyAnswer", hooked_MGCopyAnswer, (void **)&orig_MGCopyAnswer}
    };
    
    // Apply the hook
    rebind_symbols(rebindings, 1);
    
    NSLog(@"[DynamicIslandSpoofer] Successfully injected and hooked MGCopyAnswer!");
}
