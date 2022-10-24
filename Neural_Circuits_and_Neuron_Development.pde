//ICS4UI | Unit 3 Project: Cellular Automaton
//Guhan Iyer | October 23, 2022
//Neural Circuits and Neuron Development

//Changeable values
int n = 100; //Number of columns and rows.
float padding = 20; //Cell size/indentation.
int neighbouringSoma = 5; //The amount of distance between soma. The lower the value, the more compact the final circuit will be.
float somaProbability = 0.1; //Probability that a cell will be a soma.
float frameSet = 1; //Frame rate.

int count; //DO NOT MODIFY

//Colour definitions.
color somaColour = color(7, 55, 100);
color axonColour = color(118, 165, 174);
color tissueColour = color(234, 153, 153);
color dendriteColour = color(142, 124, 194);

//Possible synapse colours.
color[] synapseColour = {color(166, 250, 147), 
                         color(49, 196, 16), 
                         color(83, 171, 63), 
                         color(38, 84, 28), 
                         color(13, 59, 4),
                         color(214, 255, 225),
                         color(0, 255, 0),
                         color(26, 46, 31),
                         color(3, 89, 24),
                         color(37, 112, 55),
                         color(3, 18, 7),
                         color(29, 209, 77),
                         color(17, 105, 40)};

//Array definitions.
Cell[][] cells = new Cell[n][n];
Cell[][] nextCells = new Cell[n][n];

// Initial setup.
void setup() {
  frameRate(frameSet); //Uses the user defined framerate.
  size(600, 600);
  background(122, 198, 255);
  init();
  initSet();
}

void draw() {
  count += 1;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      initStructures(i, j);
      dendriteGrowth(i, j);
      stroke(cells[i][j].type);
    }
  }
  drawGrid();
  nextGen();
  copyGen();
}

//Function to draw the grid and fill cells according to their determined types
void drawGrid() {
  float cellSize = (width-2*padding)/n;
  float y = padding;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      fill(cells[i][j].type);
      square(x, y, cellSize);
    }
    y += cellSize;
  }
}
