precision mediump float;

attribute vec3 aVertexPosition;
attribute vec3 aFrontColor;
attribute vec3 aVertexNormal;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

varying vec3 mvVertex;
varying vec3 normal;
varying vec4 fragcolor;

void main(void) {
    mvVertex = (uMVMatrix * vec4(aVertexPosition, 1.0)).xyz;
    normal = aVertexNormal;
    fragcolor = vec4(aFrontColor, 1.0);
    
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
}
