import jp.nyatla.nyar4psg.*; 

class CreateSphere{
    float x,y,z;
    int size;
    
    public CreateSphere(float x, float y, float z, int size){
        this.x = x;
        this.y = y;
        this.z = z;
        this.size = size;
    }
    
    
   public void draw(int size){
       sphere(size);
   }
}
