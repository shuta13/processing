boolean saveMode = false;

Cell[][] cellArray;
int cellSize = 12;
int numx, numy;

void setup() {
  size(800, 800, P3D);
  strokeWeight(1);
  numx = floor(width/cellSize);
  numy = floor(height/cellSize);
  restart();
  noLoop();
}

void restart() {
  cellArray = new Cell[numx][numy];
  for (int x = 0; x < numx; x++) {
    for (int y = 0; y < numy; y++) {
      Cell newCell = new Cell(x, y);
      cellArray[x][y] = newCell;
    }
  }

  for (int x = 0; x < numx; x++) {
    for (int y = 0; y < numy; y++) {
      int above = y - 1;
      int below = y + 1;
      int left = x - 1;
      int right = x + 1;

      if (above < 0)  above = numy - 1;
      if (below == numy) below = 0;
      if (left < 0) left = numx - 1;
      if (right == numx) right = 0;

      cellArray[x][y].addNeighbour(cellArray[left][above]);
      cellArray[x][y].addNeighbour(cellArray[left][y]);
      cellArray[x][y].addNeighbour(cellArray[left][below]);
      cellArray[x][y].addNeighbour(cellArray[x][below]);
      cellArray[x][y].addNeighbour(cellArray[right][below]);
      cellArray[x][y].addNeighbour(cellArray[right][y]);
      cellArray[x][y].addNeighbour(cellArray[right][above]);
      cellArray[x][y].addNeighbour(cellArray[x][above]);
    }
  }
}

void draw() {
  background(15);

  for (int x = 0; x < numx; x++) {
    for (int y = 0; y < numy; y++) {
      cellArray[x][y].calcNextState();
    }
  }

  translate(cellSize/2, cellSize/2);

  for (int x = 0; x < numx; x++) {
    for (int y = 0; y < numy; y++) {
      cellArray[x][y].drawMe();
    }
  }

  if (saveMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void mousePressed() {
  restart();
}

void keyPressed() {
  redraw();
  if (key == 's') saveMode = true;
}

class Cell {
  float x, y;
  boolean state;
  boolean nextState;
  Cell[] neighbors;

  Cell(float ex, float why) {
    x = ex * cellSize;
    y = why * cellSize;
    if (random(2) > 1) {
      nextState = true;
    } else {
      nextState = false;
    }
    state = nextState;
    neighbors = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbors = (Cell[])append(neighbors, cell);
  }

  void calcNextState() {
    int liveCount = 0;
    for (int i = 0; i < neighbors.length; i++) {
      if (neighbors[i].state == true) liveCount++;
    }

    if (state == true) {
      if ((liveCount == 2) || (liveCount == 3)) {
        nextState = true;
      } else {
        nextState = false;
      }
    } else {
      if (liveCount == 3) {
        nextState = true;
      } else {
        nextState = false;
      }
    }
  }

  

  void drawMe() {
    state = nextState;
    stroke(200, 2);
    // noStroke();
    if (state == true) {
      fill((neighbors.length*random(0, 1000))%255%120, (neighbors.length)*cellSize%255, (neighbors.length*random(10))%255, 80);
    } else {
      fill((neighbors.length*random(0, 1000))%255%120, neighbors.length, neighbors.length%255, 80);
    }
    triangle(neighbors.length + x, neighbors.length + y, width/2, height/2, x, y);
  }
}