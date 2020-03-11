part of Dartris;

class Tetromino {
    // Each tetromino will contain a list of for square blocks.
    List<Square_Block> tetromino = List<Square_Block>(4);
    // Specify a rotational block.
    // One of the blocks in the tetromino will be the block that we rotate.
    Square_Block temp;
    String color;

    // Set up a method to move our tetromino around.
    void move_block(String dir) {
        // Move the list of blocks in tetromino around based on their x and y values.
        // It will iterate through our four blocks.
        // For example ==> Move left:
        // Each of our blocks will be pushed along the x by negative one.
        switch (dir) {
          case 'left': 
            tetromino.forEach((t) => t.x -= 1);
            break;
          case 'right':
            tetromino.forEach((t) => t.x += 1);
            break;
          case 'up':
            tetromino.forEach((t) => t.y -= 1);
            break;
          case 'down':
            tetromino.forEach((t) => t.y += 1);
            break;
        }
    }


    rotate_right() {
        tetromino.forEach((block) {
            int x = block.x;
            block.x = temp.x - block.y + temp.y;
            block.y = temp.y + x - temp.x;
        });
    }


    rotate_left() {
        tetromino.forEach((block) {
            int x = block.x;
            block.x = temp.x + block.y - temp.y;
            block.y = temp.y - x + temp.x;
        });
    }
}


class Line_Shape extends Tetromino {
    // Passing in the board_width of our canvas.
    Line_Shape (int board_width) {
        // All of the y values will be negative one to be horizontal.
        tetromino[0] = Square_Block((board_width / 2 - 2).floor(), -1);
        tetromino[1] = Square_Block((board_width / 2 - 1).floor(), -1);
        tetromino[2] = Square_Block((board_width / 2).floor(), -1);
        tetromino[3] = Square_Block((board_width / 2 + 1).floor(), -1);
        temp = tetromino[1];
        color = 'cyan';
    }
}


class Square_Shape extends Tetromino {
    Square_Shape (int board_width) {
        tetromino[0] = Square_Block((board_width / 2).floor(), -1);
        tetromino[1] = Square_Block((board_width / 2 + 1).floor(), -1);
        tetromino[2] = Square_Block((board_width / 2).floor(), 0);
        tetromino[3] = Square_Block((board_width / 2 + 1).floor(), 0);
        temp = tetromino[1];
        color = 'yellow';
    }
}


// J block and the L block are mirror images of one another.
class J_Shape extends Tetromino {
    J_Shape(int board_width) {
        tetromino[0] = Square_Block((board_width / 2 - 1).floor(), 0);
        tetromino[1] = Square_Block((board_width / 2).floor(), 0);
        tetromino[2] = Square_Block((board_width / 2 + 1).floor(), 0);
        tetromino[3] = Square_Block((board_width / 2 - 1).floor(), -1);
        temp = tetromino[1];
        color = 'blue';
    }
}


class L_Shape extends Tetromino {
    L_Shape(int board_width) {
        tetromino[0] = Square_Block((board_width / 2 - 1).floor(), 0);
        tetromino[1] = Square_Block((board_width / 2).floor(), 0);
        tetromino[2] = Square_Block((board_width / 2 + 1).floor(), 0);
        tetromino[3] = Square_Block((board_width / 2 + 1).floor(), -1);
        temp = tetromino[1];
        color = 'orange';
    }
}


class T_Shape extends Tetromino {
    T_Shape(int board_width) {
        tetromino[0] = Square_Block((board_width / 2 - 1).floor(), 0);
        tetromino[1] = Square_Block((board_width / 2).floor(), 0);
        tetromino[2] = Square_Block((board_width / 2 + 1).floor(), 0);
        tetromino[3] = Square_Block((board_width / 2).floor(), -1);
        temp = tetromino[1];
        color = 'purple';
    }
}


// Z block and the S block are mirror images of one another.
class Z_Shape extends Tetromino {
    Z_Shape(int board_width) {
        tetromino[0] = Square_Block((board_width / 2 - 1).floor(), 0);
        tetromino[1] = Square_Block((board_width / 2).floor(), 0);
        tetromino[2] = Square_Block((board_width / 2).floor(), -1);
        tetromino[3] = Square_Block((board_width / 2 + 1).floor(), -1);
        temp = tetromino[1];
        color = 'red';
    }
}


class S_Shape extends Tetromino {
    S_Shape(int board_width) {
        tetromino[0] = Square_Block((board_width / 2 - 1).floor(), -1);
        tetromino[1] = Square_Block((board_width / 2).floor(), -1);
        tetromino[2] = Square_Block((board_width / 2).floor(), 0);
        tetromino[3] = Square_Block((board_width / 2 + 1).floor(), 0);
        temp = tetromino[1];
        color = 'pink';
    }
}