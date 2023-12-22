 import 'dart:io';

List<String> board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = ['012', '048', '036', '147', '246', '258', '345', '678'];
bool winner = false;
bool isXTurn = true;
int moveCount = 0;

void main() {
  printBoard();
  getMove();
}

void printBoard() {
  print('|${board[0]}  | ${board[1]} | ${board[2]}');
  print('|_|_|_');
  print('|${board[3]}  | ${board[4]} | ${board[5]}');
  print('|_|_|_');
  print('|${board[6]}  | ${board[7]} | ${board[8]}');
  print('|   |   |');
}

void getMove() {
  print("Choose a number for ${isXTurn ? 'X' : 'O'}");
  int number = int.parse(stdin.readLineSync()!);

  if (number < 1 || number > 9 || board[number - 1] == 'X' || board[number - 1] == 'O') {
    print('Invalid move! Choose again.');
    getMove();
    return;
  }

  board[number - 1] = isXTurn ? 'X' : 'O';
  isXTurn = !isXTurn;
  moveCount++;

  if (moveCount == 9) {
    winner = true;
    print('Draw !!');
    askForReplay();
  } else {
    printBoard();
    checkWinner('X');
    checkWinner('O');
    if (!winner) {
      getMove();
    }
  }
}

bool checkCombination(String combination, String check) {
  List<int> numbers = combination.split('').map((item) => int.parse(item)).toList();

  bool match = numbers.every((item) => board[item] == check);

  return match;
}

void checkWinner(String player) {
  for (final item in combinations) {
    bool combinationValidity = checkCombination(item, player);
    if (combinationValidity) {
      print('$player WON !!');
      askForReplay();
    }
  }
}

void askForReplay() {
  print('Do you want to Replay the game? (yes/no)');
  String ans = stdin.readLineSync()!.toLowerCase();
  if (ans == 'yes') {
    winner = false;
    isXTurn = true;
    moveCount = 0;
    board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    main();
  } else {
    exit(0);
  }
}