//
//  Shader.fsh
//  OpenGL Template
//
//  Created by Thomas Denney on 13/05/2014.
//  Copyright (c) 2014 Programming Thomas. All rights reserved.
//

#version 140

in lowp vec4 diffuseColorOut;
out vec4 outColor;

void main (void) {
    outColor = diffuseColorOut;
}
