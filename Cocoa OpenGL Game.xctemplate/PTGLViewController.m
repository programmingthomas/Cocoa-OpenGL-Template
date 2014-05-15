// PTGLViewController.m
//
// Copyright 2014 Thomas Denney
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "PTGLViewController.h"

@interface PTGLViewController ()

- (void)_startAnimation;
- (void)_pauseAnimation;

- (void)_updateAndRender;

@end

@implementation PTGLViewController

@synthesize view = _ptglView;

#pragma mark - Initial setup

- (void)awakeFromNib {
    [super awakeFromNib];
    self.view.window.acceptsMouseMovedEvents = YES;

    [self.view addTrackingArea:[[NSTrackingArea alloc] initWithRect:self.view.frame options:NSTrackingMouseEnteredAndExited|NSTrackingMouseMoved|NSTrackingActiveInKeyWindow owner:self userInfo:nil]];
    
    self.preferredFramesPerSecond = 60;
    self.view.delegate = self;
    
    [self setupGL];
    
    [self _startAnimation];
}

- (void)setupGL {
    //Subclasses should override this method;
}

#pragma mark - Start/stop animation

- (void)_startAnimation {
    CGDirectDisplayID displayID = CGMainDisplayID();
    CVReturn error = CVDisplayLinkCreateWithCGDisplay(displayID, &_displayLink);
    
    if (error == kCVReturnSuccess) {
        _timeOfLastUpdate = _timeOfLastDraw = CFAbsoluteTimeGetCurrent();
        
        CVDisplayLinkSetOutputCallback(_displayLink, MyDisplayLinkCallback, (__bridge void*)self);
        CVDisplayLinkStart(_displayLink);
    }
    else {
        NSLog(@"Display Link created with error: %d", error);
        _displayLink = NULL;
    }
}

- (void)_pauseAnimation {
    CVDisplayLinkStop(_displayLink);
    _displayLink = NULL;
}

- (void)setPaused:(BOOL)paused {
    _paused = paused;
    if (paused) {
        [self _pauseAnimation];
    }
    else {
        [self _startAnimation];
    }
}

#pragma mark - Rendering

- (void)_updateAndRender {
    if (self.framesDisplayed % (60 / self.preferredFramesPerSecond) == 0) {
        [self update];
        _timeOfLastUpdate = CFAbsoluteTimeGetCurrent();
        if (!self.view.isHiddenOrHasHiddenAncestor) {
            [self.view display];
            _timeOfLastDraw = CFAbsoluteTimeGetCurrent();
        }
    }
    _framesDisplayed++;
}

- (void)update {
    //Subclasses should override this method
}

- (void)ptglView:(PTGLView *)view drawInRect:(CGRect)rect {
    //Subclasses should override this method
}

#pragma mark - Timing

- (NSTimeInterval)timeSinceLastDraw {
    return CFAbsoluteTimeGetCurrent() - _timeOfLastDraw;
}

- (NSTimeInterval)timeSinceLastUpdate {
    return CFAbsoluteTimeGetCurrent() - _timeOfLastUpdate;
}

- (void)setPreferredFramesPerSecond:(NSInteger)preferredFramesPerSecond {
    //Only 15, 30 and 60fps are allowed
    if (preferredFramesPerSecond <= 15) {
        _preferredFramesPerSecond = 15;
    }
    else if (preferredFramesPerSecond <= 30) {
        _preferredFramesPerSecond = 30;
    }
    else {
        _preferredFramesPerSecond = 60;
    }
}

#pragma mark - Callback function 

// This is the renderer output callback function
static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext) {
    [(__bridge PTGLViewController*)displayLinkContext _updateAndRender];
    return kCVReturnSuccess;
}

@end
