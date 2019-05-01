Cell[][] cellArray;
int cellSize = 10;
int numx, numy;

void setup() {
  size(800, 800);
  numx = floor(width/cellSize);
  numy = floor(height/cellSize);
  restart();
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
  background(200);

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
}

void mousePressed() {
  restart();
}

class Cell {
  float x, y;
  float state;
  float nextState;
  float lastState = 0;
  Cell[] neighbors;

  Cell(float ex, float why) {
    x = ex * cellSize;
    y = why * cellSize;

    nextState = ((x/500) + (y/300)) * 14;
    state = nextState;
    neighbors = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbors = (Cell[])append(neighbors, cell);
  }

  void calcNextState() {
    float total = 0;
    for (int i = 0; i < neighbors.length; i++) {
      total += neighbors[i].state;
    }
    float average = int(total/8);

    if (average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
      nextState = state + average;
      if (lastState > 0) { nextState -= lastState; }
      if (nextState > 255) { nextState = 255; }
      else if (nextState < 0) { nextState = 0; }
    }
    lastState = state;
  }

  

  void drawMe() {
    state = nextState;
    stroke(0);
    fill(state);
    ellipse(x, y, cellSize, cellSize);
  }
}