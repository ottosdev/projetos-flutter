import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() handleSelection;

  const Resposta(this.texto, this.handleSelection, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
        child: Text(texto),
        onPressed: handleSelection,
      ),
    );
  }
}
