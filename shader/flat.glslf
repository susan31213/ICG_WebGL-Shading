/*
    TODO HERE: 
    modify fragment shader or write another one
    to implement flat, gouraud and phong shading 
*/

#extension GL_OES_standard_derivatives : enable
precision mediump float;

uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

varying vec3 mvVertex;
varying vec4 fragcolor;
varying vec3 vLightDirection[3];

const float ka = 0.1;
const float kd = 0.6;
const float ks = 0.3;

void main(void) {
    vec3 X = dFdx(mvVertex);
    vec3 Y = dFdy(mvVertex);
    vec3 normal = normalize(cross(X,Y));

    vec3 V = -normalize(mvVertex);
    vec3 light = vec3(0.0, 0.0, 0.0);

    for (int i = 0; i < 3; i++) {
        if(uLightEnable[i] == 0.0) {
            continue;
        }
        vec3 R = reflect(-vLightDirection[i], normal);
        
        float specularCos = pow(max(dot(R, V), 0.0), 4.0);
        float diffuseCos = max(dot(normal, vLightDirection[i]), 0.0);

        light += uLightColor[i] * ka + uLightColor[i] * diffuseCos + uLightColor[i] * specularCos;
    }

    // vec3 lightDirection = normalize(uLightPosition[0] - mvVertex);

    // float light = max(0.0, dot(lightDirection, normal));

    gl_FragColor = vec4(fragcolor.rgb * light, 1.0);
}