precision mediump float;

attribute vec3 aVertexPosition;
attribute vec3 aFrontColor;
attribute vec3 aVertexNormal;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;

varying vec3 mvVertex;
varying vec4 fragcolor;
varying vec3 normalInterp;

void main(void) {
    mvVertex = (uMVMatrix * vec4(aVertexPosition, 1.0)).xyz;
    normalInterp = normalize(mat3(uMVMatrix) * aVertexNormal);
    fragcolor = vec4(aFrontColor, 1.0);
    
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
}