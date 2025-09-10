import 'dart:math';

import 'package:agentic/agentic.dart';
import 'package:expressions/expressions.dart';

class ToolExpression extends Tool {
  ToolExpression({
    super.name = "expression",
    super.description = """
Can be used to evaluate math or logic expressions. i.e. sin(pow(4/3, 2.5)), or even 4 * 12 < sin(4). The following functions are available: 
sin(radians),
pow(a, b),
min(a, b),
max(a, b),
abs(a),
sqrt(a),
log(a),
exp(a),
tan(radians),
cos(radians),
asin(radians),
acos(radians),
atan(radians),
atan2(aradians, bradians),
ceil(a),
floor(a),
round(a),
deg2rad(degrees),
rad2deg(radians),
lerp(a,b,f),
pi, e, ln10, ln2, log2e 

Please remember that if the user is talking in degrees you will need to convert to radians when using trig functions!
      """,
  });

  @override
  Future<String> call({
    required Agent agent,
    required Map<String, dynamic> arguments,
  }) async {
    print("Expression! Args: $arguments");
    try {
      return const ExpressionEvaluator().eval(
        Expression.parse(arguments["expression"]),
        {
          "sin": sin,
          "pow": pow,
          "min": min,
          "max": max,
          "abs": (num a) => a.abs(),
          "sqrt": sqrt,
          "log": log,
          "exp": exp,
          "tan": tan,
          "cos": cos,
          "asin": asin,
          "acos": acos,
          "atan": atan,
          "atan2": atan2,
          "ceil": (num a) => a.ceil(),
          "floor": (num a) => a.floor(),
          "round": (num a) => a.round(),
          "deg2rad": (num a) => a * (pi / 180),
          "rad2deg": (num a) => a * (180 / pi),
          "lerp": (num a, num b, num f) => a + (b - a) * f,
          "pi": pi,
          "e": e,
          "ln10": ln10,
          "ln2": ln2,
          "log2e": log2e,
        },
      ).toString();
    } catch (e) {
      return "EXPRESSION ERROR: $e";
    }
  }

  @override
  Map<String, dynamic> get schema => {
    "type": "object",
    "additionalProperties": false,
    "required": ["expression"],
    "properties": {
      "expression": {
        "type": "string",
        "description":
            "The expression to evaluate. Supports parentheses, PEMDAS, trig functions, pow(a,b), min, max, etc.",
      },
    },
  };
}
