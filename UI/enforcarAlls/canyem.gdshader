shader_type canvas_item;

uniform float speed = 2.0;
uniform float frequency_y = 5.0;
uniform float frequency_x = 5.0;
uniform float amplitude_y = 50.0;
uniform float amplitude_x = 25.0;
uniform float inclination = 45.0;

void vertex() {
	VERTEX.x += sin((UV.x - TIME * speed) * frequency_y) * amplitude_y * UV.x;
	VERTEX.y += cos((UV.y - TIME * speed) * frequency_x) * amplitude_x * UV.x;
	VERTEX.y -= UV.y * inclination;
}