// PTGLView.h
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

//Standard enums

/*
 Enums for depth buffer formats.
 */
typedef NS_ENUM(GLint, PTGLViewDrawableDepthFormat) {
	PTGLViewDrawableDepthFormatNone = 0,
	PTGLViewDrawableDepthFormat16 = 16,
	PTGLViewDrawableDepthFormat24 = 24,
};

/*
 Enums for MSAA.
 */
typedef NS_ENUM(GLint, PTGLViewDrawableMultisample) {
	PTGLViewDrawableMultisampleNone,
	PTGLViewDrawableMultisample4X,
};

//Forward declaration of delegate
@protocol PTGLViewDelegate;

/**
 This class is a port of GLKView from iOS to OSX, using NSOpenGLView methods were appropriate. Many of the options are exactly the same
 @note This uses OpenGL Core Profile 3.2
 @note You do not need to subclass this class. Please you the delegate method for drawing instead
 */
@interface PTGLView : NSOpenGLView

///------------------------
///@name Drawing properties
///------------------------

@property (nonatomic) PTGLViewDrawableDepthFormat drawableDepthFormat;
@property (nonatomic) PTGLViewDrawableMultisample drawableMultisample;

@property (nonatomic, retain) NSOpenGLContext * context;

///--------------------------
///@name Read only properties
///--------------------------

@property (nonatomic, readonly) NSInteger drawableWidth;
@property (nonatomic, readonly) NSInteger drawableHeight;

///--------------
///@name Delegate
///--------------

@property (nonatomic) id<PTGLViewDelegate> delegate;

/**
 Called by PTGLViewController
 */
- (void)display;

@end

@protocol PTGLViewDelegate <NSObject>

@required
/**
 Render the contents of the OpenGL view
 @note The rectangle will is measured in points, not pixels. Use -drawableWidth and -drawableHeight to get the pixel height
 */
- (void)ptglView:(PTGLView*)view drawInRect:(CGRect)rect;

/*@optional

- (void)mouseMoved:(PTGLView*)view event:(NSEvent*)event;
- (void)mouseEntered:(PTGLView*)view event:(NSEvent*)event;
- (void)mouseExited:(PTGLView*)view event:(NSEvent*)event;
- (void)mouseDragged:(PTGLView*)view event:(NSEvent*)event;*/

@end
