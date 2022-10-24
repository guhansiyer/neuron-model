//Initializing arrays with Cell instances, setting random group numbers, and defaulting all cells to !isHead.
void init() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j] = new Cell();
      nextCells[i][j] = new Cell();
      cells[i][j].group = int(random(0, n*n)); 
      cells[i][j].isHead = false; 
    }
  }
}

//Set the initial placement of soma.
void initSet() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j].type = tissueColour;
      float x = random(0, 1);

      //If x is lower than or equal to the user picked probability, the current cell will be a soma.
      if (x <= somaProbability) {
        cells[i][j].type = somaColour;
      }

      //If x is greater than the user picked probability, the current cell will be nervous tissue.
      else {
        cells[i][j].type = tissueColour;
      }

      neighbourCheck(i, j);
    }
  }
}

//If any soma's are within 5 cells of another soma, set them to be nervous tissue.
void neighbourCheck(int i, int j) {
  for (int k=-neighbouringSoma; k<=neighbouringSoma; k++) {
    for (int l=-neighbouringSoma; l<=neighbouringSoma; l++) {
      try {
        if (cells[i+k][j+l].type == somaColour && !(k==0 && l==0)) {
          cells[i][j].type = tissueColour;
        }
      }
      catch(ArrayIndexOutOfBoundsException e) {}
    }
  }
}

//Initial axon and dendrite placement. Decided randomly.
//Also assigns each dendrite to the same group as the soma they branch from.
void initStructures(int i, int j) {
  float x = random(0, 1);
  if (count == 2) {
    for (int k=-1; k<=1; k++) {
      for (int l=-1; l<=1; l++) {

        try {
          if (cells[i][j].type == somaColour) {

            if (k == 0 && l == -1) {
              cells[i+k][j+l].group = cells[i][j].group;

              if (x <= 0.25) {
                cells[i+k][j+l].type = axonColour;
                cells[i+k][j+l].isHead = true;
              } else {
                cells[i+k][j+l].type = dendriteColour;
              }
            } else if (k == -1 && l == 0) {
              cells[i+k][j+l].group = cells[i][j].group;

              if (x >= 0.25 && x<= 0.50) {
                cells[i+k][j+l].type = axonColour;
                cells[i+k][j+l].isHead = true;
              } else {
                cells[i+k][j+l].type = dendriteColour;
              }
            } else if (k == 1 && l == 0) {
              cells[i+k][j+l].group = cells[i][j].group;

              if (x >= 0.50 && x <= 0.75) {
                cells[i+k][j+l].type = axonColour;
                cells[i+k][j+l].isHead = true;
              } else {
                cells[i+k][j+l].type = dendriteColour;
              }
            } else if (k == 0 && l == 1) {
              cells[i+k][j+l].group = cells[i][j].group;

              if (x >= 0.75 && x <= 1.0) {
                cells[i+k][j+l].type = axonColour;
                cells[i+k][j+l].isHead = true;
              } else {

                cells[i+k][j+l].type = dendriteColour;
              }
            }
          }
        }
        catch(ArrayIndexOutOfBoundsException e) {}
      }
    }
  }
}
