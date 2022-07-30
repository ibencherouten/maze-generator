// Java program to illustrate copyof method
import java.util.Arrays;

public class Maze{
  float m_x = 10., m_y = 10.;
  float m_width, m_height, c_width, c_height, row, column;
  Cell[][] grid;
  
  public Maze(int row, int column){
    m_width = 500.;
    m_height = 500.;
    this.row = row;
    this.column = column;
    c_width = m_width/column;
    c_height = m_height/row;
    grid = new Cell[row][column];
    for(int i=0; i<row; i++)
      for(int j=0; j<column; j++)
        grid[i][j] = new Cell();
    
    grid[0][0].walls[0] = true;
    
  }
  
  public void draw(){
    for(int i=0; i<row; i++){
      for(int j=0; j<column; j++){
        if(grid[i][j].walls[0] == false){
          float x = m_x + j*c_width;
          float y1 = m_y + i*c_height;
          float y2 = m_y + i*c_height + c_height;
          line(x, y1, x, y2);
        }
        if(grid[i][j].walls[2] == false){
          float x = m_x + j*c_width + c_width;
          float y1 = m_y + i*c_height;
          float y2 = m_y + i*c_height + c_height;
          line(x, y1, x, y2);
        }
        if(grid[i][j].walls[1] == false){
          float y = m_y + i*c_height;
          float x1 = m_x + j*c_width;
          float x2 = m_x + j*c_width + c_width;
          line(x1, y, x2, y);
        }
        
        if(grid[i][j].walls[3] == false){
          float y = m_y + i*c_height + c_height;
          float x1 = m_x + j*c_width;
          float x2 = m_x + j*c_width + c_width;
          line(x1, y, x2, y);
        }
        
      }
    }
  }
  
  public void generate(){
    Stack<Cell> path = new Stack();
    grid[0][0].walls[0] = true;
    grid[0][0].visited = true;
    path.push(grid[0][0]);
    while(!path.empty()){
      Cell c = path.peek();
      
      boolean[] av = Arrays.copyOf(c.checkWalls(), c.checkWalls().length);
      System.out.println("debug "+av);
      int[] index = getCellIndex(c);
      //remove cell index at edges
      //and visited cells
      
      System.out.println(av.length + " before index " + av);
      if(index[0] == 0)  av[1] = false;
      System.out.println(av.length + "index 1");
      if(index[0] == row - 1) av[3] = false;
      
      System.out.println(av.size + "index 2");
      if(index[1] == 0) av[0]= false;
      
      System.out.println(av.length + "index 3");
      if(index[1] == column - 1) av[2]=false;
      
      System.out.println(av.length + "index 4");
      
      System.out.println(av.length);
      
      if(av.contains(0)){
        if(grid[index[0]][index[1]-1].visited) av.remove(av.indexOf(0));
       }
       
       if(av.contains(1)){
        if(grid[index[0]-1][index[1]].visited) av.remove(av.indexOf(1));
       }
       
       if(av.contains(2)){
        if(grid[index[0]][index[1]+1].visited) av.remove(av.indexOf(2));
       }
       
       if(av.contains(3)){
        if(grid[index[0]+1][index[1]].visited) av.remove(av.indexOf(3));
       }
      
      
      // check availble 
      if(!av.isEmpty()){
        //randomize
        int rand = (int)(Math.random() * av.size());
        int nextCellIndexI=-1, nextCellIndexJ=-1;
        
        if(rand == 0){
          nextCellIndexI = index[0]-1;
          nextCellIndexJ = index[1];
          c.walls[0] = true;
          grid[nextCellIndexI][nextCellIndexJ].walls[2] = true;
        }
        if(rand == 2){
          nextCellIndexI = index[0]+1;
          nextCellIndexJ = index[1];
          c.walls[2] = true;
          grid[nextCellIndexI][nextCellIndexJ].walls[0] = true;
        }
        if(rand == 1){
          nextCellIndexJ = index[1]-1;
          nextCellIndexI = index[0];
          c.walls[1] = true;
          grid[nextCellIndexI][nextCellIndexJ].walls[3] = true;
        }
        if(rand == 3){
          nextCellIndexJ = index[1]+1;
          nextCellIndexI = index[0];
          c.walls[3] = true;
          grid[nextCellIndexI][nextCellIndexJ].walls[1] = true;
        }
        path.push(grid[nextCellIndexI][nextCellIndexJ]);
        grid[nextCellIndexI][nextCellIndexJ].visited=true;
      } else {
        path.pop();
      }
      // debug
      break;
      // if true :
      //       mark cell as visited
      //       push next cell
      //       break walls
      // else   
      //       pop from stack
    }
  }
  
  public int[] getCellIndex(Cell c){
    
    for(int i=0; i<row; i++){
      for(int j=0; j<column; j++){
        if(c == grid[i][j]) return new int[]{i, j};
      }
    }
    return null;
  }
  
}
