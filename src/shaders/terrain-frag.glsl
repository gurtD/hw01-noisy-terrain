#version 300 es
precision highp float;

uniform vec2 u_PlanePos; // Our location in the virtual world displayed by the plane
uniform float u_Road;

in vec3 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_Col;

in float fs_Sine;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec2 truchetPattern(in vec2 _st, in float _index){
    _index = fract(((_index-0.5)*2.0));
    if (_index > 0.75) {
        _st = vec2(1.0) - _st;
    } else if (_index > 0.5) {
        _st = vec2(1.0-_st.x,_st.y);
    } else if (_index > 0.25) {
        _st = 1.0-vec2(1.0-_st.x,_st.y);
    }
    return _st;
}

vec3 land_grandient(float height) {
  vec3 white = vec3(1.0, 1.0, 1.0);
  vec3 green = vec3(37.0 / 255.0, 145.0 / 255.0, 27.0 / 255.0);
  vec3 brown = vec3(109.0 / 255.0, 78.0 / 255.0, 64.0 / 255.0);

  if ( height >= 0.8 ) {
      return mix(green, white, (pow(height, 2.0) + 0.5) / 1.2);
  } else {
      return mix(brown, green, pow(height, 2.0) );
  }
}

void main()
{
    vec2 st = u_PlanePos.xy + fs_Pos.xz;
    st *= u_Road;

    vec2 ipos = floor(st);  // integer
    vec2 fpos = fract(st);  // fraction

    vec2 tile = truchetPattern(fpos, random( ipos ));

    float road = 0.0;

    road = smoothstep(tile.x-0.001,tile.x,tile.y)-
            smoothstep(tile.x,tile.x+0.01,tile.y);

    float t = clamp(smoothstep(40.0, 50.0, length(fs_Pos)), 0.0, 1.0); // Distance fog
    vec3 height_color = land_grandient(fs_Sine / 7.0);
    if ( road > 0.0) {
        out_Col = vec4(mix(vec3(35.0 / 255.0, 30.0 / 255.0, 23.0 / 255.0), vec3(164.0 / 255.0, 233.0 / 255.0, 1.0), t), 1.0);
        
    } else {
        out_Col = vec4(mix(height_color, vec3(164.0 / 255.0, 233.0 / 255.0, 1.0), t), 1.0);
    }
}
