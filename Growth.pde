//Adjacency checker.
boolean isAdjacent(int x1, int y1, int x2, int y2) {
  int diffX = abs(x2-x1);
  int diffY = abs(y2-y1);

  //If distance is defined as the amount of frames it takes to grow to the position of another cell, adjacency is reached when a cell is within 1 distance of another cell.
  if ((diffX == 0 && diffY == 1) || (diffX == 1 && diffY == 0) || (diffX == 1 && diffY == 1)) {
    return true;
  } else {
    return false;
  }
}

//Distance calcualtor
int calculateDistance(int x1, int y1, int x2, int y2) { //For the purposes of commenting, let the "source cell" have components x1, y1. Let the "target cell" have components x2, y2.
  int xVal = x1; //Storing the initial x-value of the source cell.
  int yVal = y1; //Storing the initial y-value of the target cell.
  int distance = 0; //Distance variable.
  boolean isAdj = isAdjacent(xVal, yVal, x2, y2); //Continuous adjacency checker.

  //The distance calculator works as follows.
  //Depending on how far the target is from the source, and in what direction the target compares to the source, xVal and yVal are either incremented or decremented. Distance is always incremented.
  //This will continue until either isAdj evaluates as true, or the source is horizontally/vertically adjacent with the target.
  //Horizontal adjacency is reached when xVal = x2. Likewise, vertical adjacency is reached when yVal = y2.
  //When horizontal adjacency is reached, the remaining growth the source must undergo to reach the target is vertical. yVal is thereby incremented or decremented depending on how y2 compares to yVal.
  //When vertical adjacency is reached, the remaining growth the source must undergo to reach the target is horizontal. xVal is thereby incremented or decremented depending on how x2 compares to xVal.

  if ((x2 > x1) && (y2 > y1)) {
    while (isAdj == false && xVal != x2 && yVal != y2) {
      xVal += 1;
      yVal += 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((x2 > x1) && (y2 < y1)) {
    while (isAdj == false && xVal != x2 && yVal != y2) {
      xVal += 1;
      yVal -= 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((x2 < x1) && (y2 > y1)) {
    while (isAdj == false && xVal != x2 && yVal != y2) {
      xVal -= 1;
      yVal += 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((x2 < x1) && (y2 < y1)) {
    while (isAdj == false && xVal != x2 && yVal != y2) {
      xVal -= 1;
      yVal -= 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  }

  if ((xVal == x2) && yVal < y2) {

    while (isAdj == false) {
      yVal += 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((xVal == x2) && yVal > y2) {
    while (isAdj == false) {
      yVal -= 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((yVal == y2) && xVal < x2) {
    while (isAdj == false) {
      xVal += 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  } else if ((yVal == y2) && xVal > x2) {

    while (isAdj == false) {
      xVal -= 1;
      distance += 1;
      isAdj = isAdjacent(xVal, yVal, x2, y2);
    }
  }


  if (isAdj == true) {
    return distance;
  }

  return -1;
}

//Dendrite growth function, also randomly decided.
//New dendritic cells inherit the group of the dendrite they branch from.
void dendriteGrowth(int i, int j) {
  if (count == 3) {
    for (int k=-1; k<=1; k++) {
      for (int l=-1; l<=1; l++) {
        try {
          if (cells[i][j].type == somaColour) {
            if (cells[i+k][j+l].type != axonColour) {
              if (k == 0 && l == -1) {

                if (random(0, 1) <= 0.5) {
                  cells[i+k+1][j+l-1].type = dendriteColour;
                  cells[i+k+1][j+l-1].group = cells[i][j].group;
                } else {
                  cells[i+k-1][j+l-1].type = dendriteColour;
                  cells[i+k-1][j+l-1].group = cells[i][j].group;
                }
              } else if (k == -1 && l == 0) {

                if (random(0, 1) <= 0.5) {
                  cells[i+k-1][j+l+1].type = dendriteColour;
                  cells[i+k-1][j+l+1].group = cells[i][j].group;
                } else {
                  cells[i+k-1][j+l-1].type = dendriteColour;
                  cells[i+k-1][j+l-1].group = cells[i][j].group;
                }
              } else if (k == 1 && l == 0) {

                if (random(0, 1) <= 0.5) {
                  cells[i+k+1][j+l+1].type = dendriteColour;
                  cells[i+k+1][j+l+1].group = cells[i][j].group;
                } else {
                  cells[i+k+1][j+l-1].type = dendriteColour;
                  cells[i+k+1][j+l-1].group = cells[i][j].group;
                }
              } else if (k == 0 && l == 1) {

                if (random(0, 1) <= 0.5) {
                  cells[i+k+1][j+l+1].type = dendriteColour;
                  cells[i+k+1][j+l+1].group = cells[i][j].group;
                } else {

                  cells[i+k-1][j+l+1].type = dendriteColour;
                  cells[i+k-1][j+l+1].group = cells[i][j].group;
                }
              }
            }
          }
        }
        catch (ArrayIndexOutOfBoundsException e) {}
      }
    }
  }
}

//Axon growth calculation.
void growth(int i, int j) {
  int closestX = 0; //The closest dendrite's x-position.
  int closestY = 0; //The closest dendrite's y-position.
  int xSpeed = 0; 
  int ySpeed = 0;
  int currDistance; //The current distance evaluated between some dendrite and a source axon.

  //If the fourth generation (where all structures have been initialized) has not been reached, exit the function.
  if (count < 4) {
    return;
  }

  //If the current cell being searched is both not an axon and not the head of an axon chain, exit the function.
  if (cells[i][j].type != axonColour && cells[i][j].isHead == false) {
    return;
  }

  //The growth function can be entered if the current cell being searched is an axon and the head of its chain
  //The growth function can also be entered if the current cell is not an axon but is the head of it's chain.
  //This is done to prevent 'overlap'; where an axon draws over a dendrite that is part of the same neuron.
  if ((cells[i][j].type == axonColour && cells[i][j].isHead == true) || (cells[i][j].type != axonColour && cells[i][j].isHead == true)) {
    int minimumDistance = n*n; //The minimum distance is initialized as the grid size, so it can be decreased as distances are calculated

    //Iterate's through the whole grid for each axon, which is guaranteed to return the closest dendrite.
    for (int row = 0; row < n; row ++) {
      for (int col = 0; col < n; col ++) {

        //If the cell you are searching is not a dendrite or is in the same group as the cell you started the search from, move onto the next cell.
        if (cells[row][col].type != dendriteColour || cells[row][col].group == cells[i][j].group) {
          continue;
        } else {
          //Distance calculation between the source axon and the current dendrite.
          currDistance = calculateDistance(i, j, row, col);


          if (currDistance < minimumDistance) {
            minimumDistance = currDistance; //Set's minimumDistance as the distance to the current dendrite.
            closestX = row; //Set's the current dendrite's x-position as closestX.
            closestY = col; //Set's the current dendrite's y-position as closestY.
          }
        }
      }
    }

    boolean isAdj = isAdjacent(i, j, closestX, closestY); //Continuous adjacency checker that is evaluated in each of the following conditions.

    //If the axon and dendrite are not adjacent, and the dendrite has greater x/y values than the axon, grow diagonally down right.
    if ((isAdj == false) && (closestX > i) && (closestY > j)) {
      xSpeed = 1;
      ySpeed = 1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the axon and dendrite are not adjacent, and the dendrite has greater x values than the axon, but lower y values, grow diagonally down left.
    else if ((isAdj == false) && (closestX > i) && (closestY < j)) {
      xSpeed = 1;
      ySpeed = -1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the axon and dendrite are not adjacent, and the dendrite has lower x values than the axon, but greater y values, grow diagonally up right.
    else if ((isAdj == false) && (closestX < i) && (closestY > j)) {
      xSpeed = -1;
      ySpeed = 1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the axon and dendrite are not adjacent, and the dendrite has lower x/y values than the axon, grow diagonally up left.
    else if ((isAdj == false) && (closestX < i) && (closestY < j)) {
      xSpeed = -1;
      ySpeed = -1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the x values of the axon and dendrite are the same, but the dendrite's y value is greater than the axon's, grow downwards.
    if ((isAdj == false) && (closestX == i) && (closestY > j)) {
      xSpeed = 0;
      ySpeed = 1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the x values of the axon and dendrite are the same, but the dendrite's y value is lower than the axon's, grow upwards.
    if ((isAdj == false) && (closestX == i) && (closestY < j)) {
      xSpeed = 0;
      ySpeed = -1;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the y values of the axon and dendrite are the same, but the dendrite's x value is greater than the axon's, grow right.
    if ((isAdj == false) && (closestY == j) && (closestX > i)) {
      xSpeed = 1;
      ySpeed = 0;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the y values of the axon and dendrite are the same, but the dendrite's x value is lower than the axon's, grow left.
    if ((isAdj == false) && (closestY == j) && (closestX < i)) {
      xSpeed = -1;
      ySpeed = 0;
      isAdj = isAdjacent(i, j, closestX, closestY);
    }

    //If the axon has grown to be adjacent to the dendrite, stop growth, and initialize the head of the chain with random synaptic weight.
    if (isAdj == true) {
      xSpeed = 0;
      ySpeed = 0;
      nextCells[i+xSpeed][j+ySpeed].type = synapseColour[int(random(0, synapseColour.length-1))];
    }
    
    //If the next cell is nervous tissue, overwrite it's type.
    if (nextCells[i+xSpeed][j+ySpeed].type == tissueColour) {
      nextCells[i+xSpeed][j+ySpeed].type = axonColour;
    }
    nextCells[i+xSpeed][j+ySpeed].group = cells[i][j].group;
    nextCells[i+xSpeed][j+ySpeed].isHead = true;
    cells[i][j].isHead = false;
  }
}
