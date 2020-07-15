import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class key_controll extends PApplet {

class KeyController {
  Key upKey, downKey, leftKey, rightKey, shiftKey,ctrlKey,spcKey; // 使用するキー
  Key[] keys; // キーを入れる配列
  int keyWidth, keyHeight; // キーの描画サイズ
  PFont keyFont; // キーの描画フォント
  int fontSize; // キーの描画フォントのサイズ

  KeyController() {
    // キーの描画の設定
    keyWidth = 50;
    keyHeight = 50;
    fontSize = 10;
    keyFont = createFont("MS Gothic", fontSize);

    // 上下左右スペースキーを作る
    upKey    = new Key("UP",    (char)CODED, UP);
    downKey  = new Key("DOWN",  (char)CODED, DOWN);
    leftKey  = new Key("LEFT",  (char)CODED, LEFT);
    rightKey = new Key("RIGHT", (char)CODED, RIGHT);
    shiftKey   = new Key("SHIFT",   (char)CODED, SHIFT);
    ctrlKey   = new Key("CTRL",   (char)CODED, CONTROL);
    spcKey   = new Key("SPC",   ' ',         0);

    // 作ったキーを登録する
    keys = new Key[7];
    keys[0] = upKey;
    keys[1] = downKey;
    keys[2] = leftKey;
    keys[3] = rightKey;
    keys[4] = shiftKey;
    keys[5] = ctrlKey;
    keys[6] = spcKey;
  }

  // 引数で指定されたキーが押された
  public void pressed(char tempKey, int tempKeyCode) {
    // 全キーに引数で指定されたキーが押されたことを通知
    for (int i = 0; i < keys.length; i++) {
      keys[i].pressed(tempKey, tempKeyCode);
    }
  }

  // 引数で指定されたキーが押された
  public void released(char tempKey, int tempKeyCode) {
    // 全キーに引数で指定されたキーが離されたことを通知
    for (int i = 0; i < keys.length; i++) {
      keys[i].released(tempKey, tempKeyCode);
    }
  }

  // キーの状態を描画する
  public void draw(int left, int top) {
    /*
                  -------
                  | UP  |
      -------------------------
      | SPC |LEFT |DOWN |RIGHT|
      -------------------------
    */
    upKey.draw(   2 * keyWidth + left,             top, keyWidth, keyHeight, keyFont, fontSize);
    downKey.draw( 2 * keyWidth + left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
    leftKey.draw(     keyWidth + left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
    rightKey.draw(3 * keyWidth + left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
    shiftKey.draw(                 left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
    ctrlKey.draw(4*keyWidth+left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
    spcKey.draw(5*keyWidth+left, keyHeight + top, keyWidth, keyHeight, keyFont, fontSize);
  }
}

// ゲームに使うキーのコントローラーのオブジェクト
KeyController keyController;

public void setup() {
  
  keyController = new KeyController();
}

public void draw() {
  keyController.draw(100, 100);
}

public void keyPressed() {
  keyController.pressed(key, keyCode);
}

public void keyReleased() {
  keyController.released(key, keyCode);
}
class Key {
  String name; // キーの名前
  char key; // keyの値
  int keyCode; // keyCodeの値
  boolean isPressed; // 押されているか否か

  // コンストラクタ
  Key(String tempName, char tempKey, int tempKeyCode) {
    name = tempName;
    key = tempKey;
    keyCode = tempKeyCode;
    isPressed = false;
  }

  // 引数で指定されたキーと一致するかどうかを判定
  public boolean equals(char tempKey, int tempKeyCode) {
    if (tempKey != CODED) {
      if (key == tempKey) {
        return true;
      } else {
        return false;
      }
    } else {
      if (keyCode == tempKeyCode) {
        return true;
      } else {
        return false;
      }
    }
  }

  // 引数で指定されたキーが押された
  public void pressed(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = true;
    }
  }

  // 引数で指定されたキーが離された
  public void released(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = false;
    }
  }

  // キーの絵を描画する
  public void draw(int xOffset, int yOffset, int width, int height, PFont font, int fontSize) {
    int textColor, backgroundColor;

    if (isPressed == true) {
      textColor = 255;
      backgroundColor = 0;
    } else {
      textColor = 0;
      backgroundColor = 255;
    }

    stroke(0);

    fill(backgroundColor);
    rect(xOffset, yOffset, width, height);

    textAlign(CENTER);
    textFont(font);
    fill(textColor);
    text(name, xOffset + width / 2, yOffset + height / 2 + fontSize / 2);
  }
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "key_controll" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
