import 'dart:math';

const choicesCount = 3;
const interactionsCount = 1000000;

final rnd = Random(DateTime.now().microsecondsSinceEpoch);
final winnings = List.filled(2, 0);
final losses = List.filled(2, 0);

int nextInt() {
  assert(choicesCount >= 3);
  return rnd.nextInt(choicesCount);
}

int chooseThePriseBox() => nextInt();

int chooseThePlayerBox() => nextInt();

int showTheEmptyBox(int prise, int player) {
  var result = nextInt();
  while (result == prise || result == player) {
    result = nextInt();
  }
  return result;
}

void countKeepOriginalGuess(int prise, int player) {
  if (player == prise) {
    ++winnings[0];
  } else {
    ++losses[0];
  }
}

void countChangeTheGuess(int prise, int player, int program) {
  for (var j = 0; j < choicesCount; j++) {
    if (player != j && program != j) {
      if (prise == j) {
        ++winnings[1];
      } else {
        ++losses[1];
      }
      break;
    }
  }
}

void calculateProbabilities() {
  for (var i = 0; i < interactionsCount; ++i) {
    final prise = chooseThePriseBox();
    final player = chooseThePlayerBox();
    final program = showTheEmptyBox(prise, player);

    countKeepOriginalGuess(prise, player);
    countChangeTheGuess(prise, player, program);
  }
}

void printResults() {
  final w1 = winnings[0];
  final wp1 = w1.toDouble() / interactionsCount * 100;
  final wps1 = wp1.toStringAsFixed(1);
  final l1 = losses[0];
  final lp1 = (l1.toDouble() / interactionsCount * 100).toStringAsFixed(1);

  final w2 = winnings[1];
  final wp2 = w2.toDouble() / interactionsCount * 100;
  final wps2 = wp2.toStringAsFixed(1);
  final l2 = losses[1];
  final lp2 = (l2.toDouble() / interactionsCount * 100).toStringAsFixed(1);

  print(
    "This program ran $interactionsCount times on $choicesCount possible "
    "choices that a player could have.",
  );
  print("Related to the player's choices, if the player...");
  print(
    "kept the choice:\nWinning count: $w1 - $wps1%\nLoss count: $l1 - $lp1%\n\n",
  );
  print(
    "changed the choice:\nWinnings: $w2 - $wps2%\nLosses: $l2 - $lp2%\n\n",
  );
  print("So the conclusion should be:");
  if ((w1 > l1 && w2 < l2) || w1 > w2) {
    print("It would be best you keep your choice.");
  } else {
    print("It would be best you change your choice.");
  }
}

void main() {
  calculateProbabilities();
  printResults();
}
