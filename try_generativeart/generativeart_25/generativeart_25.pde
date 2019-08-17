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
    if (state) { liveCount++; }
    for (int i = 0; i < neighbors.length; i++) {
      if (neighbors[i].state == true) liveCount++;
    }

    if (liveCount <= 4) {
      nextState = false;
    } else {
      nextState = true;
    }

    if ((liveCount == 4) || (liveCount == 5)) {
      nextState = !nextState;
    }
  }

  

  void drawMe() {
    state = nextState;
    stroke(0);
    if (state == true) {
      fill(0);
    } else {
      fill(255);
    }
    ellipse(x, y, cellSize, cellSize);
  }
}