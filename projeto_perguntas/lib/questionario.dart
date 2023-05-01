import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final void Function(int) responder;
  final int perguntaSelecionada;

  const Questionario(
      {super.key,
      required this.perguntaSelecionada,
      required this.perguntas,
      required this.responder});

  bool get temPerguntaSelecionadas {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionadas
        ? perguntas[perguntaSelecionada].cast()['respostas']
        : [];

    List<Widget> widgets = respostas
        .map((item) => Resposta(
              item['texto'].toString(),
              () => responder(int.parse(item['pontuacao'].toString())),
            ))
        .toList();

    return Column(
      children: [
        Questao(perguntas[perguntaSelecionada]['texto'].toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [...widgets],
        ),
      ],
    );
  }
}
