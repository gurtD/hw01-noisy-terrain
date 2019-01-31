#version 300 es
precision highp float;

uniform vec2 u_PlanePos; // Our location in the virtual world displayed by the plane
uniform float u_Time;

in vec3 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_Col;

in float fs_Sine;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

void main()
{
    float t = clamp(smoothstep(40.0, 50.0, length(fs_Pos)), 0.0, 1.0); // Distance fog
    vec3 mixed_color = mix(vec3(14.0 / 255.0, 91.0 / 255.0, 206.0 / 255.0), vec3(136.0 / 255.0, 220.0 / 255.0, 224.0 / 255.0), cos((u_Time / fs_Sine)) / 2.0);
    out_Col = vec4(mix(mixed_color, vec3(164.0 / 255.0, 233.0 / 255.0, 1.0), t), 1.0);
}
