import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

class TokenCost {
  static final Decimal _million = Decimal.fromInt(1000000);

  static Rational rational(int tokens, double costPerMillion) =>
      Decimal.fromInt(tokens) *
      Decimal.parse(costPerMillion.toString()) /
      _million;

  static double cost(int tokens, double costPerMillion) =>
      rational(tokens, costPerMillion).toDouble();
}
