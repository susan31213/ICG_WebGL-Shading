precision mediump float;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

varying vec3 mvVertex;
varying vec3 normal;
varying vec4 fragcolor;

void main(void) {    
     float intensity = 0.0;
     for (int i=0; i<3; i++) {
          if(uLightEnable[i] == 0.0) {
            continue;
          }
          vec3 lightDir = normalize(uLightPosition[i] - mvVertex);
	     intensity += dot(lightDir, normalize(mat3(uMVMatrix) * normal));


     }
     
     float level = 1.0;
	if (intensity > 0.95)
		level = 1.0;
	else if (intensity > 0.5)
		level = 0.6;
	else if (intensity > 0.25)
		level = 0.4;
	else
		level = 0.2;
	gl_FragColor = vec4(fragcolor.rgb * uLightColor[0] * level, 1.0);
}
