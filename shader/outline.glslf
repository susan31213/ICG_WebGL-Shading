precision mediump float;

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
    vec3 lightDir = normalize(uLightPosition[0] - mvVertex);
    vec3 L = normalize(lightDir);
    float diffuse = dot(nNormal, L);

    if(diffuse > 0.9){
         diffuse = 1.0;
    }else if(diffuse > 0.1){
         diffuse = 0.7;
    }else {
         diffuse = 0.3;
    }

    vec3 color = vec3(0.9, diffuse, 0.0);
    color *= 1.0;
    gl_FragColor = vec4(color, 1.0);
}