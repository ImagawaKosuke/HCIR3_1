import jp.nyatla.nyar4psg.*; 

class CreateCube{
    float x,y,z;
    int size;
    
    public CreateCube(float x, float y, float z, int size){
        this.x = x;
        this.y = y;
        this.z = z;
        this.size = size;
    }
    
   public void draw(int size){
       box(size);
   }
}
