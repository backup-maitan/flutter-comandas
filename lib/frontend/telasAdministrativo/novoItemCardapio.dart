import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class NovoItemCardapio extends StatefulWidget {

  List<dynamic> categorias;
  NovoItemCardapio(this.categorias);

  @override
  _NovoItemCardapioState createState() => _NovoItemCardapioState();
}

class _NovoItemCardapioState extends State<NovoItemCardapio> {

  final categoria = TextEditingController();
  final detalhe = TextEditingController();
  final nome = TextEditingController();
  final valor = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> _listaItensDrop = List();
  String hint = 'Categoria';

  carregarItensDrop(){
    for(dynamic categoria in widget.categorias){
      setState(() {
        _listaItensDrop.add(
          DropdownMenuItem(
            child: Text(categoria.toString()),
            value: categoria.toString()
       ));
     });
    }
  }

  @override
  void initState() {
    super.initState();
    carregarItensDrop();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
     builder: (context, child, model){
       return Scaffold(
          appBar: AppBar(
            title: Text('Novo item do cardapio'),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _globalKey,
                child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        controller: nome,               
                        decoration: InputDecoration(                   
                          labelText: 'nome',
                        ),
                       // ignore: missing_return
                       validator: (value){
                         if(value.isEmpty)
                          return 'insira o nome do item';
                       },
                      ),
                    ),
                    Container(
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
                                  categoria.text = valor;
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                    ),                 
                  Container(
                    padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        controller: detalhe,               
                        decoration: InputDecoration(                   
                          labelText: 'detalhe',
                        ),
                       // ignore: missing_return
                       validator: (value){
                         if(value.isEmpty)
                          return 'insira o detalhe do item';
                       },
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: valor,               
                        decoration: InputDecoration(                   
                          labelText: 'valor',
                        ),
                       // ignore: missing_return
                       validator: (value){
                         if(value.isEmpty){
                          return 'insira o valor do item';
                         }else if(value.contains(',')){
                          return 'use ponto no lugar da virgula';
                         }
                       },
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text('Salvar item',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        onPressed: (){
                          if(_globalKey.currentState.validate())
                           model.salvarNovoItemCardapio(context: context, nome: nome.text, categoria: categoria.text, detalhe: detalhe.text, valor: valor.text);
                        }
                      )
                    ],
                  )  
                ],
              ),
              )
            ),
          )
        );
       },
    );
  }
}