public class Cell{
   public boolean walls[] = {false, false, false, false};
   public boolean visited = false;
   
   public Cell(){
   
   }
   
   public ArrayList<Integer> checkAvailable(){
     ArrayList<Integer> list = new ArrayList<Integer>();
     for(int i=0; i<4; i++){
       if(walls[i]) list.add(i);
     }
     return list;
   }
   
   public boolean[] checkWalls(){
     return walls;
   }
   
   
}
