attribute vec3 aVertexPosition;
attribute vec3 aFrontColor;
attribute vec3 aVertexNormal;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

varying vec4 fragcolor;

const float ka = 0.1;
const float kd = 0.6;
const float ks = 0.3;

void main(void) {
    vec3 mvVertex = (uMVMatrix * vec4(aVertexPosition, 1.0)).xyz;

    // V, N, L, H
    vec3 V = -normalize(mvVertex);
    vec3 N = normalize(mat3(uMVMatrix) * aVertexNormal);

    vec3 light = vec3(0.0, 0.0, 0.0);

    for (int i = 0; i<3; i++) {
        if(uLightEnable[i] == 0.0) {
            continue;
        }

        vec3 L = normalize(uLightPosition[i] - mvVertex);
        vec3 H = normalize(V + L);

        // gouraud = ambient + diffuse + specular
        vec3 gouraudShading = vec3(0.0);

        vec3 ambient = uLightColor[i] * ka * aFrontColor;

        float cosTheta = max(dot(L, N), 0.0);
        vec3 diffuse = uLightColor[i] * kd * aFrontColor * cosTheta;

        float cosAlpha = max(dot(H, N), 0.0);
        vec3 specular = uLightColor[i] * ks * pow(cosAlpha, 10.0);
        if(dot(L, N) < 0.0){
            specular = vec3(0.0);
        }

        gouraudShading = ambient + diffuse + specular;
        light += gouraudShading;
    }

    fragcolor = vec4(light, 1.0);
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
}