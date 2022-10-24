//Cell class
public class Cell {
  //Every cell has 3 properties
  //Type: The state of a cell
  //isHead: Determines whether a cell is the head of a chain of axons. If a cell is the head, distance calculations can be performed based on the position of the cell.
  //Group: Numerical values assigned to each cells. Neurons and their structures share the same group number.
  public color type;
  public boolean isHead;
  public int group;

  //Initializing the cell class through a blank constructor
  public Cell() {}

  //Copy constructor for deep copies
  public Cell(Cell cell){
    this.type = cell.type;
    this.isHead = cell.isHead;
    this.group = cell.group;
  }
}
