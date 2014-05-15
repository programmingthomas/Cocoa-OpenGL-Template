// PTGLView.m
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

#import "PTGLView.h"

@interface PTGLView ()

- (void)_initCommon;
- (void)_configurePixelFormat;

@end

@implementation PTGLView

#pragma mark - Initialization

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initCommon];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initCommon];
    }
    return self;
}

- (void)_initCommon {
    //This method ensures that retina support is enabled by default
    [self setWantsBestResolutionOpenGLSurface:YES];
    _drawableDepthFormat = PTGLViewDrawableDepthFormat24;
    _drawableMultisample = PTGLViewDrawableMultisampleNone;
    [self _configurePixelFormat];
}

#pragma mark - View setup

- (void)_configurePixelFormat {
    NSOpenGLPixelFormatAttribute attrs[] = {
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
        NSOpenGLPFAColorSize    , 24                           ,
        NSOpenGLPFAAlphaSize    , 8                            ,
        NSOpenGLPFADoubleBuffer ,
        NSOpenGLPFAAccelerated  ,
        NSOpenGLPFANoRecovery   ,
        NSOpenGLPFASupersample,
        NSOpenGLPFASampleBuffers, 1,
        NSOpenGLPFADepthSize, self.drawableDepthFormat,
        self.drawableMultisample ? NSOpenGLPFASamples : 0, self.drawableMultisample ? 4 : 0,
        0
    };
    self.pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
    self.openGLContext = [[NSOpenGLContext alloc] initWithFormat:self.pixelFormat shareContext:nil];
    [self.openGLContext makeCurrentContext];
}

- (void)setDrawableDepthFormat:(PTGLViewDrawableDepthFormat)drawableDepthFormat {
    if (_drawableDepthFormat != drawableDepthFormat) {
        _drawableDepthFormat = drawableDepthFormat;
        [self _configurePixelFormat];
    }
}

- (void)setDrawableMultisample:(PTGLViewDrawableMultisample)drawableMultisample {
    if (_drawableMultisample != drawableMultisample) {
        _drawableMultisample = drawableMultisample;
        [self _configurePixelFormat];
    }
}

#pragma mark - Rendering

- (void)display {
    if (!self.isHiddenOrHasHiddenAncestor) {
        [self lockFocus];
        [self.openGLContext update];
        [self.openGLContext makeCurrentContext];
        
        if (self.drawableMultisample == PTGLViewDrawableMultisample4X) {
            glEnable(GL_MULTISAMPLE);
        }
        
        [self.delegate ptglView:self drawInRect:[self convertRectToBacking:self.bounds]];
        
        [self.openGLContext flushBuffer];
        [self unlockFocus];
    }
}

#pragma mark - Sizing

- (NSInteger)drawableWidth {
    return (NSInteger)CGRectGetWidth([self convertRectToBacking:self.bounds]);
}

- (NSInteger)drawableHeight {
    return (NSInteger)CGRectGetHeight([self convertRectToBacking:self.bounds]);
}

- (void)updateTrackingAreas {
    NSArray * areas = [self.trackingAreas copy];
    for (NSTrackingArea * area in areas) {
        [self removeTrackingArea:area];
        NSTrackingArea * newArea = [[NSTrackingArea alloc] initWithRect:self.frame options:area.options owner:area.owner userInfo:area.userInfo];
        [self addTrackingArea:newArea];
    }
}

@end
