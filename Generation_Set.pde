//Computes and sets the next generation.
void nextGen() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      nextCells[i][j] = new Cell(cells[i][j]); //Perform a deep copy of cells[][] (The normal overwrite method as seen in copyGen() performs a shallow copy).
    }
  }

  for (int k=0; k<n; k++) {
    for (int l=0; l<n; l++) {
      growth(k, l);
    }
  }
}

//Overwrites the current generation with the computed next generation through a shallow copy.
void copyGen() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j] = nextCells[i][j];
    }
  }
}
