import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoObjeto {

  String cliente;
  Timestamp data;
  String detalhe;
  String local;
  int mesa;
  String observacao;
  String origem;
  String pedido;
  int quantidade;
  String situacao;
  double valor;
  String idPedido;

  PedidoObjeto(this.cliente, this.data, this.detalhe, this.local, this.mesa, this.observacao, this.origem, this.pedido, this.quantidade, this.situacao, this.valor, this.idPedido);

}