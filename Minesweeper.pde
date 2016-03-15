

import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    

   for(int row =0; row< NUM_ROWS; row++)
   {
    for(int collumn =0; collumn < NUM_COLS; collumn++)
    {
        MSButton button1 = new MSButton(row, collumn);
    }
   }
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < 10)
    {
        int ro = (int)(Math.random() * NUM_ROWS);
        int coll = (int)(Math.random() * NUM_COLS);
        if(!bombs.contains(buttons[ro][coll]))
        {
            bombs.add(buttons[ro][coll]);
        }
    }

    
}

public void draw ()
{
    background( 0 );
    if(isWon() && !gameOver)
    {
        displayWinningMessage();
        gameOver = true;
    }
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(!buttons[r][c].isMarked() && !buttons[r][c].isClicked())
                return false;
    return true;
}
public void displayLosingMessage()
{
    /*for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(bombs.contains(buttons[r][c]))
                buttons[r][c].setlabel("M");
            String message = new String("game Over!");
            for(int i = 0; i < message.length(); i++)
            {
                buttons[9][i+5].clicked = true;
                if(!bombs.contains(buttons[9][i+5]))
                    bombs.add(buttons[9][i+5]);
                //buttons[9][i+5].setlabel(message.substring(i,i+1));
            }*/
}
public void displayWinningMessage()
{
    String message = new String("You Win!");
    for(int i = 0; i < message.length(); i++)
    {
        buttons[9][i+6].clicked = true;
        if(!bombs.contains(buttons[9][i+6]))
            bombs.add(buttons[9][i+6]);
        //buttons[9][i+6].setlabel(message.substring(i,i+1));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
        
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(gameOver) return;
        clicked = true;
        if(keyPressed)
            marked = !marked;
        else if(bombs.contains(this))
        {
            displayLosingMessage();
            gameOver = true;
        }
        //else if(counter(r,c) > 0)
           // label = "" + countBombs(r,c);
        else
        {
            if(isValid(r-1,c) && !buttons[r-1][c].clicked)
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].clicked)
                buttons[r+1][c].mousePressed();
            if(isValid(r,c-1) && !buttons[r][c-1].clicked)
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && !buttons[r][c+1].clicked)
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].clicked)
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].clicked)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].clicked)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].clicked)
                buttons[r-1][c+1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //return r>=0 && r < NUM_ROWS && c >= 0 < NUM_COLS;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        return numBombs;
    }
}



