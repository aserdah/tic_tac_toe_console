import 'dart:io';

void main() {
  print("Welcome to Tic-Tac-Toe!\n");

  bool playAgain = true;

  while (playAgain) {
    // Initialize board
    List<String> board = List.generate(9, (i) => (i + 1).toString());

    // Ask player to choose X or O
    String player1 = '', player2 = '', currentPlayer = '';
    while (true) {
      stdout.write("Player 1, choose X or O: ");
      var choice = stdin.readLineSync();
      if (choice != null) {
        choice = choice.toUpperCase();
        if (choice == 'X' || choice == 'O') {
          player1 = choice;
          player2 = (player1 == 'X') ? 'O' : 'X';
          currentPlayer = player1;
          break;
        }
      }
      print("Please enter a valid choice.");
    }

    // Start the game loop
    int moveCount = 0;
    bool gameWon = false;

    while (true) {
      printBoard(board);
      stdout.write("Player '$currentPlayer', enter your move (1-9): ");
      String? input = stdin.readLineSync();

      if (input == null || int.tryParse(input) == null) {
        print("Invalid input. Try again.");
        continue;
      }

      int pos = int.parse(input);
      if (pos < 1 || pos > 9 || board[pos - 1] == 'X' || board[pos - 1] == 'O') {
        print("Invalid move. That cell is taken.");
        continue;
      }

      board[pos - 1] = currentPlayer;
      moveCount++;

      if (checkWin(board, currentPlayer)) {
        printBoard(board);
        print("Player '$currentPlayer' wins!");
        gameWon = true;
        break;
      }

      if (moveCount == 9) {
        printBoard(board);
        print("It's a draw!");
        break;
      }

      currentPlayer = (currentPlayer == player1) ? player2 : player1;
    }

    // Play again?
    stdout.write("Play again? (y/n): ");
    var again = stdin.readLineSync();
    if (again == null || again.toLowerCase() != 'y') {
      playAgain = false;
    }
  }

  print("Thanks for playing!");
}

void printBoard(List<String> b) {
  print("\n ${b[0]} | ${b[1]} | ${b[2]}");
  print("---+---+---");
  print(" ${b[3]} | ${b[4]} | ${b[5]}");
  print("---+---+---");
  print(" ${b[6]} | ${b[7]} | ${b[8]}\n");
}

bool checkWin(List<String> b, String p) {
  List<List<int>> wins = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var line in wins) {
    if (b[line[0]] == p && b[line[1]] == p && b[line[2]] == p) {
      return true;
    }
  }

  return false;
}
