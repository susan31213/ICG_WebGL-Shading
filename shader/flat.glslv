/*
    TODO HERE:
    modify vertex shader or write another one
    to implement flat, gouraud and phong shading

    NOTE:
    if you want to write bonus part (texture mapping),
    only Teapot.json has extra attribute "vertexTextureCoords"
    which is used for texture mappping.
*/

precision mediump float;

attribute vec3 aVertexPosition;
attribute vec3 aFrontColor;
attribute vec3 aVertexNormal;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];

varying vec3 mvVertex;
varying vec4 fragcolor;
varying vec3 vLightDirection[3];

void main(void) {
    mvVertex = (uMVMatrix * vec4(aVertexPosition, 1.0)).xyz;

    for (int i = 0; i < 3; i++) {
		vLightDirection[i] = normalize(uLightPosition[i]-mvVertex);
	}

    fragcolor = vec4(aFrontColor, 1.0);
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
}