# Godot exploration example

## How to use
- Clone this project
- Open in Godot 4.7
- Open omni_light_3d_ex.tscn for OmniLight3D playground, and spring_arm_3d.tscn for SpringArm3D playground

## Camera controls
Hold Right click to enter camera control mode.
- While holding right click:
+ WASD to move camera around
+ Mouse movement for camera yaw/pitch
+ Hold shift for speed boost


## Scene explanation
>[!IMPORTANT]
> Please test scenes in play mode
### OmniLight3D scene
This scene contains a bunch of OmniLight3D nodes in a dark room with different settings
1. Default settings
2. Same but higher light energy
3. Different color with high attenuation (how much light fades when further from source, higher value means light fades more)
4. Low attenuation 
5. Shadow is off (boxes don't receive shadow from the source light)
6. Shadow is on

### SpringArm3D scene
This scene contains two example of spring arm behaviors when collided differently by:
1. A wall that move closer and further on loop
2. The spring rotate and collide with a wall