import processing.video.*;               // video ライブラリを使う
import jp.nyatla.nyar4psg.*;             // nyar4psg ライブラリを使う
import java.util.List;

 
Capture cam;                             // Capture オブジェクトの宣言
MultiMarker mm[] = new MultiMarker[2];                          // MultiMarker オブジェクトの宣言
int x[] = new int[2];
int y[] = new int[2];
int size[] = new int[2];
float distance=0;
int c=0;
int j=0;

CreateCube normalc;
CreateSphere normals;

import java.util.Iterator;

void setup() {
  // ウィンドウとカメラの設定
  size(640, 480, P3D);                   // ウィンドウのサイズ設定（P3Dモード）
  cam = new Capture(this, 640,480,"Intel(R) RealSense(TM) Depth Camera 415  RGB", 60);  
  cam.start();   // カメラをスタート
  colorMode(HSB, 300, 100, 100 ); 
  for(int i=0;i<2;i++){
      // NyARToolkit の設定
      mm[i] = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
      mm[i].addNyIdMarker(i, 80);               // 認識するマーカを登録する (ID, マーカの幅[mm])
      size[i] = 60;
  }
}
 
void draw() {
  // ビデオキャプチャ
  if(cam.available() == false) {         // カメラが利用可能な状態でなければ
    return;                              // 何もせず処理を終える
  }

  cam.read();                            // 映像をキャプチャする
  for(int i=0;i<2;i++){
      // AR 処理の開始
      mm[i].detect(cam);                        // キャプチャした画像内でマーカを探す
      mm[i].drawBackground(cam);                // ウィンドウの背景にキャプチャした画像を設定
      if(mm[i].isExist(0) == false) {           // マーカ[0] が存在しなければ
        return;                              // 何もせず処理を終える
      }
      mm[i].beginTransform(0);                  // マーカ[0] の位置にもとづいて座標の投射（変換）を始める
        
        produce3D(i);
        x[i] = (int)screenX(0, 0, 0);
        y[i] = (int)screenY(0,0,0);
        if(y[i]>240 && y[i]<=300){size[i] = 60 + (-240+y[i]);}
        else if(y[i]<=160){size[i]=60;}
        if(size[i]<60){size[i]=60;}
        mm[i].endTransform();                     // 座標の投射（変換）を終了
      // AR 処理の終了
      
  }
  distance = dist(x[0],y[0],x[1],y[1]);
  println(dist(x[0],y[0],x[1],y[1]));
  line(x[0],y[0],x[1],y[1]);
  c++;
  fill(0,0,0);
  text("Distance:" + str(distance),500,400);
}

void produce3D(int i){
    translate(0, 0, 30);                 // 原点の位置の調整（原点をZ軸方向に 40mm 移動）
    fill(screenX(0, 0, 0)%300, 100, 100, 240-(screenY(0, 0, 0))%240);              // CG の塗りつぶしの設定 (R, G, B, 不透明度)
    if(distance>400){rotate(0);}
    else if(distance<=400 && distance>300){rotate(30*c);}
    else if(distance<=300 && distance>200){rotate(50*c);}
    else if(distance<=200 && distance>100){rotate(70*c);}
    else if(distance<=100){rotate(90*c);}
        if(i==0){
            translate(0,0,0);
            normalc = new CreateCube(0,0,0,size[0]);
            normalc.draw(size[0]);// 60mm 四方の箱の CG を描く
        }                             
        else if(i==1){
            translate(0,0,0);
             rotateX(radians(90));
             normals = new CreateSphere(0,0,0,size[1]);
             normals.draw(size[1]);
        }
}
