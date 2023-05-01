import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  const Resultado(this.pontuacao, {super.key});

  String get fraseResultado {
    if (pontuacao <= 8) {
      return "Parabens sua pontuacao foi ${pontuacao}";
    } else if (pontuacao < 12) {
      return "Voce é bom, sua pontuacao foi ${pontuacao}";
    } else {
      return "Execelente, sua pontuacao foi ${pontuacao}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        fraseResultado,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
