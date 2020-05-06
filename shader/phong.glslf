precision mediump float;

uniform vec3 uLightPosition[3];
uniform vec3 uLightColor[3];
uniform float uLightEnable[3];

varying vec3 mvVertex;
varying vec4 fragcolor;
varying vec3 normalInterp;

const float ka = 0.1;
const float kd = 0.6;
const float ks = 0.3;

void main(void) {
   vec3 N = normalize(normalInterp);

   vec3 light = vec3(0.0, 0.0, 0.0);

   for (int i=0; i<3; i++) {
      if(uLightEnable[i] == 0.0) {
            continue;
      }

      vec3 L = normalize(uLightPosition[i] - mvVertex);

      float lambertian = max(dot(N, L), 0.0);
      float specularCos = 0.0;

      if(lambertian > 0.0) {
         vec3 R = reflect(-L, N);       // Reflected light vector
         vec3 V = normalize(-mvVertex); // Vector to viewer

         float specAngle = max(dot(R, V), 0.0);
         specularCos = pow(specAngle, 4.0);
      }

      vec3 ambient = ka * uLightColor[i];
      vec3 diffuse = kd * lambertian * uLightColor[i];
      vec3 specular = ks * specularCos * uLightColor[i];

      light += ambient + diffuse + specular;
   }

   gl_FragColor = vec4(fragcolor.rgb * light, 1.0);
}