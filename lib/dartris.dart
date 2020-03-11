library Dartris;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'square_block.dart';
part 'tetromino.dart';

// This class will hold all the states for the actual game.
class Dart_Game {
  CanvasElement board;
  CanvasRenderingContext2D canvas;
  int board_width = 15;
  int board_height = 20;
  int cell = 30;
  // This grid will be filled with zeros.
  // As a piece is dropped down in the grid that piece will exist in a
  // space in this list. 
  List<List<int>> State_Board;
  // It will track how many blocks are in each of the rows.
  // If we have 15 blocks in the row, we will delete that row.
  // It means that the user has completely filled up that row with tetrominos.
  List<int> State_Row;

  // Current block
  Tetromino Shape;
  
  Dart_Game() {
    State_Row = List<int>.filled(board_height, 0);
    State_Board = List<int>(board_width).map((_) => List<int>.filled(board_height, 0),).toList();
  }

  // Generate random pieces
  Tetromino random_tetromino() {
    // We have 7 pieces.
    int rand = Random().nextInt(7);
    // Based on the switch statement we'll return a new tetromino.
    switch (rand) {
      case 0:
        return Line_Shape(board_width);
      case 1:
        return Square_Shape(board_width);
      case 2:
        return J_Shape(board_width);
      case 3:
        return T_Shape(board_width);
      case 4:
        return L_Shape(board_width);
      case 5:
        return Z_Shape(board_width);
      case 6:
        return S_Shape(board_width);
    }
    return Tetromino();
  }

  // Check all of our rows and see if
  // they have 15 tetrominos inside of them and then clear those rows.
  void clear_rows() {
    for (int index = 0; index < State_Row.length; index++) {
      int row = State_Row[index];
      if (row == board_width) {
        // We can remove it visually from our board.
        // So we can use what's called an image data object. 
        // We use our context to get this image data.
        ImageData imageData = canvas.getImageData(0, 0, cell * board_width, cell * index);
        canvas.putImageData(imageData, 0, cell);
        for (int y = index; y > 0; y--) {
          for (int x = 0; x < board_width; x++) {
            // Move all of the numbers in our board State down by y minus 1
            State_Board[x][y] = State_Board[x][y - 1];
          }
          State_Row[y] = State_Row[y - 1];
        }
        State_Row[0] = 0;
        State_Board.forEach((c) => c[0] = 0);
      }
    }
  }

  bool valid() {
    for (Square_Block block in Shape.tetromino) {
      if (block.x >= board_width || block.x < 0 ||
          block.y >= board_height ||block.y < 0 ||
          State_Board[block.x][block.y] == 1) {
            return false;
      }
    }
    return true;
  }

  // We will draw the piece then delete it then draw it in a new position and keep going.
  bool draw_tetromino(String s) {
    bool right_move = true;
    canvas.fillStyle = 'black';
    
    Shape.tetromino.forEach((Square_Block block) {
      canvas.fillRect(block.x * cell, block.y * cell, cell, cell,);
    });

    // The user is rotating our current piece.
    if (s == 'rotate') {
      Shape.rotate_right();
    } else {
      // Otherwise we want the current block to move in the direction.
      Shape.move_block(s);
    }

    if (!(right_move = valid())) {
      if (s == 'rotate') Shape.rotate_left();
      if (s == 'left') Shape.move_block('right');
      if (s == 'right') Shape.move_block('left');
      if (s == 'down') Shape.move_block('up');
      if (s == 'up') Shape.move_block('down');
    }

    canvas.fillStyle = Shape.color;
    
    Shape.tetromino.forEach((block) {
      canvas.fillRect(block.x * cell, block.y * cell, cell, cell,);
    });
    return right_move;
  }

  // The timer will determine when our screen refreshes.
  void update(Timer timer) {
    window.console.log(State_Board);
    window.console.log(State_Row);

    if (!draw_tetromino('down')) {
      Shape.tetromino.forEach((t) {
        State_Board[t.x][t.y] = 1;
        State_Row[t.y]++;
      });
      clear_rows();
      Shape = random_tetromino();
      // If we've crashed the game then we want to call timer cancel.
      // It will stop the game entirely.
      if (!draw_tetromino('down')) {
        timer.cancel();
      }
    }
  }

  // Initialize our HTML canvas
  void init() {
    board = Element.html('<canvas/>');
    board.width = board_width * cell;
    board.height = board_height * cell;
    canvas = board.context2D;
    canvas.fillStyle = 'black';
    canvas.fillRect(0, 0, board.width, board.height);
  }

  // Capture keyboard events
  void keyboard(Timer timer) {
    document.onKeyDown.listen((event) {
      if (timer.isActive) {
        // Check key codes
        if (event.keyCode == 37) 
          draw_tetromino('left');
        if (event.keyCode == 38) 
          draw_tetromino('rotate');
        if (event.keyCode == 39) 
          draw_tetromino('right');
        if (event.keyCode == 40) 
          draw_tetromino('down');
        // If the user has hit the spacebar and then we can execute a while loop which 
        // will just loop while the piece can move down.
        if (event.keyCode == 32) 
          while (draw_tetromino('down')) {}
      }
    });
  }

  void play() {
    // Setup the actual canvas on our HTML
    init();
    // In index.html we have a div with an ID of output.
    // So we can just use our query selector to grab that div.
    Element entryPoint = querySelector('#output');
    entryPoint.nodes.add(board);
    // The block will move downwards once every 500 milliseconds.
    Timer timer = Timer.periodic(Duration(milliseconds: 500),update,);
    Shape = random_tetromino();
    keyboard(timer);
   }
}