Garrett Darley, gdarley
External Resources: Book of Shaders, chapter on noise specifically referencing 
maze shader, of which I used as a reference to make the road lines.
https://gurtd.github.io/hw01-noisy-terrain/
Used fbm in order to create height value for terrain plane, changable terrain 
seed value in gui simply changes the random function seed to change the terrain.
Color of terrain is dependent on the height value and uses a mix of two colors 
depending on the height.
An fbm value is also used to give another plane a random value to affect a mix 
for color two shades of blue to create water at a specific height, however I 
introduced a time uniform that is sent to the shader using cosine in order to 
change the mix value continously, thus animating the water. 
For the roads (black lines) I used a maze generator as a reference, found on 
thebookofshaders.com, in order to create a series of straight lines. The shader 
uses the location in world space, and treats it as a square in a large grid, and 
based on a noise function picks a direction for a line to be placed, and thus 
creates the series of lines. The slider found in the gui for the roads increases/
decreases the density of the roads.


