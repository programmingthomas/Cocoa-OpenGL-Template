//
//  Shader.vsh
//  OpenGL Template
//
//  Created by Thomas Denney on 13/05/2014.
//  Copyright (c) 2014 Programming Thomas. All rights reserved.
//

#version 140

in vec4 position;
in vec3 normal;

out vec4 diffuseColorOut;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec4 diffuseColor;

void main (void) {
    gl_Position = modelViewProjectionMatrix * position;

    lowp vec3 eyeNormal = normalize(normalMatrix * normal);
    lowp vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    
    lowp float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
    
    diffuseColorOut = vec4(diffuseColor.xyz * nDotVP, diffuseColor.a);
}
