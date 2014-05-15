// PTGLViewController.h
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

@import Cocoa;
@import GLKit;

#import "PTGLView.h"
#import "PTGLProgram.h"

/**
 Provides a class equivalent to GLKViewController on iOS, including all animation management
 */
@interface PTGLViewController : NSViewController<PTGLViewDelegate> {
    CVDisplayLinkRef _displayLink;
    NSTimeInterval _timeOfLastUpdate, _timeOfLastDraw;
}

@property (strong, nonatomic) IBOutlet PTGLView * view;

/**
 The target number of frames per second. Acceptable values are 15, 30 and 60. For buttery smooth animation, aim for 60fps
 */
@property (nonatomic) NSInteger preferredFramesPerSecond;

/**
 Used to pause and resume the controller.
 */
@property (nonatomic, getter=isPaused) BOOL paused;

/**
 The total number of frames displayed since drawing began.
 */
@property (nonatomic, readonly) NSInteger framesDisplayed;

/**
 Time interval since properties.
 */
@property (nonatomic, readonly) NSTimeInterval timeSinceLastUpdate;
@property (nonatomic, readonly) NSTimeInterval timeSinceLastDraw;

///-------------------------
///@name Methods to override
///-------------------------

/**
 This is called when the view is being prepared before animation begins. You must configure the properties of your view (anti-aliasing, depth bits, color bits) before you do any other drawing because the OpenGL context is recreated.
 */
- (void)setupGL;

/**
 This method is called before the frame is presented. You should do any calculations (such as physics, game state, new matrices) here rather than in your rendering method
 */
- (void)update;

@end
