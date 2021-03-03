import 'package:comandas/backend/objetos/pedidoObjeto.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CardPedido extends StatefulWidget {

  PedidoObjeto pedidoObjeto;
  bool mostrarIcone;
  Icon icone;
  BuildContext context;
  Color corLetra;
  Color corLetraDestaque;
  Color corCard;
  Function funcao;
  CardPedido({@required this.pedidoObjeto, @required this.context, @required this.mostrarIcone, @required this.corCard, @required this.corLetra, @required this.corLetraDestaque, this.icone, this.funcao});

  @override
  _CardPedidoState createState() => _CardPedidoState();
}

class _CardPedidoState extends State<CardPedido> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          color: widget.corCard,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.pedidoObjeto.pedido,
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.corLetra
                        ),
                      ),

                    widget.pedidoObjeto.observacao != '' ?
                      Column(
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),

                          Text('Observação: ' + widget.pedidoObjeto.observacao,
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.corLetra
                            ),
                          )
                        ],
                      ) : Container(),

                      SizedBox(
                        height: 8.0,
                      ),

                      Text(widget.pedidoObjeto.detalhe,
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.corLetraDestaque
                        ),
                      ),

                      SizedBox(
                        height: 8.0,
                      ),

                      Text('R\$: ' + widget.pedidoObjeto.valor.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.corLetraDestaque
                        ),
                      ),

                      SizedBox(
                        height: 8.0,
                      ),

                      Row(
                        children: [   
                          Text('Cliente: ' + widget.pedidoObjeto.cliente,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.corLetraDestaque
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(widget.pedidoObjeto.origem,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.corLetraDestaque
                                ),
                              ),                      
                          widget.pedidoObjeto.origem == 'mesa' ?
                              Text(' ' + widget.pedidoObjeto.mesa.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.corLetraDestaque
                              ),
                            ) : Container(),
                        ],
                      ),

                      SizedBox(
                          height: 8.0,
                        ),

                       Row(
                        children: [  
                          Text(widget.pedidoObjeto.situacao,
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.corLetraDestaque
                           ),
                          ),

                          Text(' ' + widget.pedidoObjeto.local,
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.corLetraDestaque
                            ),
                          ),               
                        ],
                      ),
                    ],
                  ),
                ),

                Text('QTD: ' + widget.pedidoObjeto.quantidade.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.corLetra
                  ),
                ),

                widget.mostrarIcone ?
                  IconButton(
                    icon: widget.icone,
                    onPressed: widget.funcao
                ) : Container()

              ],
            ),
          ),
        ),
      );
    });
  }
}