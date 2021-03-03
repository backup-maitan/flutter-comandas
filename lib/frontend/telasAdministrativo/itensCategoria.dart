import 'package:flutter/material.dart';

class ItensCaterogia extends StatefulWidget {

  List<dynamic> categorias;
  ItensCaterogia(this.categorias);

  @override
  _ItensCaterogiaState createState() => _ItensCaterogiaState();
}

class _ItensCaterogiaState extends State<ItensCaterogia> {

  List<DropdownMenuItem<String>> _listaItensDrop = List();
  String hint = 'Categoria';

  carregarItensDrop(){
    _listaItensDrop.add(DropdownMenuItem(
      child: Text('lanches'),
      value: 'lanches'
    ));
    _listaItensDrop.add(DropdownMenuItem(
      child: Text('bebidas'),
      value: 'bebidas'
    ));
  }

  @override
  void initState() {
    super.initState();
    carregarItensDrop();
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
             child: DropdownButtonFormField(
              hint: Text(hint),
              items: _listaItensDrop,
              onChanged: (valor){
                setState(() {
                  hint = valor;
                });
              }
            ),
          ),
        ],
      ),
    );
  }
}