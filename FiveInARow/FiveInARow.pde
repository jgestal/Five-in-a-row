// Game:     Five in a Row 
// Created:  2019/11/26 creation date]
// Author:   Juan Gestal (juan@gestal.es)
//

int w = 20;
int h = 20;
int bs = 30;
int player = 1;
int state = 0;

int [][] board = new int[w][h];

void setup() {
  size(601, 601);
  ellipseMode(CORNER);
  textAlign(CENTER, CENTER);
  textSize(16);
}

void draw() {

  for (int r=0; r<h; r++) for (int c=0; c<w; c++) {

    fill(255);
    rect(c*bs, r*bs, bs, bs);

    if (board[c][r] > 0) {
      fill(board[c][r]==1?255:0, board[c][r]==2?255:0, 0);
      ellipse(c*bs, r*bs, bs, bs);
    }
  }

  if (state != 0) {

    fill(0);
    rect(width/2 - 5*bs, height/2 - bs, 10*bs, 2*bs);
    
    fill(255);
    if (state > 0) {
      text("Player "+state+" wins. Press click to restart.", width/2, height/2);
    } else {
      text("Draw game. Press click to restart.", width/2, height/2);
    }
  }
}


int f(int c, int r) {
  return (c<0 || r<0 || c>=w || r>=h) ? 0 : board[c][r];
}

void mousePressed() {

  if (state == 0) {

    int c = int(mouseX / bs);
    int r = int(mouseY / bs);
    
    c = c < w*bs ? c : w*bs;
    r = r < h*bs ? r : h*bs;

    if (board[c][r] == 0) {
      board[c][r] = player;
      player = player == 1 ? 2 : 1;
      state = getState();
    }
  } else {
    restart();
  }
}

void restart() {
  for (int r=0; r<h; r++) for (int c=0; c<w; c++) board[c][r] = 0; 
  player = 1;
  state = 0;
}

// 1: Player 1 wins
// 2: Player 2 wins
// -1: Draw
// 0: No winner

int getState() {

  int emptyFields = 0;

  for (int r=0; r<h; r++) for (int c=0; c<w; c++) {

    int v = board[c][r];

    if (v > 0) {
      if (v == f(c, r+1) && v == f(c, r+2) && v == f(c, r+3) && v == f(c, r+4)) return v; 
      if (v == f(c+1, r) && v == f(c+2, r) && v == f(c+3, r) && v == f(c+4, r)) return v;
      if (v == f(c+1, r+1) && v == f(c+2, r+2) && v == f(c+3, r+3) && v == f(c+4, r+4)) return v;
      if (v == f(c+1, r-1) && v == f(c+2, r-2) && v == f(c+3, r-3) && v == f(c+4, r-4)) return v;
    } else {
      emptyFields++;
    }
  }
  return emptyFields > 0 ? 0 : -1;
}
