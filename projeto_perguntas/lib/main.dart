import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resposta.dart';
import 'package:projeto_perguntas/resultado.dart';
import './questao.dart';

main() {
  runApp(new PerguntaApp());
}

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final List<Map<String, Object>> _perguntas = [
    {
      'texto': 'Qual sua cor favorita?',
      'respostas': [
        {'texto': 'Vermelho', 'pontuacao': 10},
        {'texto': 'Branco', 'pontuacao': 4},
        {'texto': 'Preto', 'pontuacao': 8},
      ]
    },
    {
      'texto': 'Qual seu animal favorito?',
      'respostas': [
        {'texto': 'Gato', 'pontuacao': 10},
        {'texto': 'Cachorro', 'pontuacao': 4},
        {'texto': 'Coelho', 'pontuacao': 8},
      ]
    },
    {
      'texto': 'Qual seu instrutor favorito?',
      'respostas': [
        {'texto': 'Leo', 'pontuacao': 10},
        {'texto': 'Bruno', 'pontuacao': 0},
        {'texto': 'Joao', 'pontuacao': 6},
      ]
    },
  ];

  bool get temPerguntaSelecionadas {
    return _perguntaSelecionada < _perguntas.length;
  }

  void _responder(int pontuacao) {
    if (temPerguntaSelecionadas) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
      print(_pontuacaoTotal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Perguntas'),
          ),
          body: temPerguntaSelecionadas
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Questionario(
                          perguntaSelecionada: _perguntaSelecionada,
                          perguntas: _perguntas,
                          responder: _responder
                          
                          ),
                    ],
                  ),
                )
              : Resultado(_pontuacaoTotal)),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
