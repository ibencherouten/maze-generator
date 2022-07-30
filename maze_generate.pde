import java.util.*;


Maze maze = new Maze(10, 10);
void setup(){
  size(1000, 800);
  maze.generate();
}

void draw(){
  background(255);  
  maze.draw();
}
