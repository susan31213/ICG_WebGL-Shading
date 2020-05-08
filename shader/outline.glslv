attribute vec3 aVertexPosition;
attribute vec3 aFrontColor;
attribute vec3 aVertexNormal;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform mat4 uNMatrix;
uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

const float ka = 0.1;
const float kd = 0.6;
const float ks = 0.3;

varying vec3 mvVertex;
varying vec3 nNormal;

void main(void) {
    vec3 N = normalize(aVertexNormal);
    nNormal  = (uNMatrix * vec4(N, 1.0)).xyz;
    mvVertex = (uMVMatrix * vec4(aVertexPosition, 1.0)).xyz;

    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
}