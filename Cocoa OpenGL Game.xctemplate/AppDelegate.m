//
//  ___FILENAME___
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_classPrefix:identifier___AppDelegate.h"
#import "___VARIABLE_classPrefix:identifier___ViewController.h"

@interface ___VARIABLE_classPrefix:identifier___AppDelegate ()

//Uncomment these if you want to create a full screen game
//@property NSWindow * fullScreenWindow;
//@property ViewController * viewController;

@end

@implementation ___VARIABLE_classPrefix:identifier___AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    //To create a full screen window, uncomment the following code and delete the window in MainMenu.xib
    /*NSRect mainDisplayRect = [NSScreen mainScreen].frame;
    
    self.fullScreenWindow = [[NSWindow alloc] initWithContentRect:mainDisplayRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    self.fullScreenWindow.level = NSMainMenuWindowLevel + 1;
    self.fullScreenWindow.hidesOnDeactivate = YES;
    self.fullScreenWindow.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
    
    self.viewController = [ViewController new];
    
    
    NSRect windowSize = self.fullScreenWindow.frame;
    CGRect viewRect = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height);
    self.viewController.view = [[PTGLView alloc] initWithFrame:viewRect];
    [self.fullScreenWindow.contentView addSubview:self.viewController.view];
    [self.fullScreenWindow.contentView setAutoresizesSubviews:YES];
    [self.viewController.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    [self.fullScreenWindow makeKeyAndOrderFront:nil];
    
    [self.viewController awakeFromNib];*/
}

@end
