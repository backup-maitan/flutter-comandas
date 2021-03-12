import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/frontend/telas/login.dart';
import 'package:comandas/frontend/telas_drawer/administrativo.dart';
import 'package:comandas/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class UsuarioModel extends Model {

  String uid = '';
  final observacao = TextEditingController();
  final quantidade = TextEditingController();
  bool estaCarregando = false;
  bool erroLogin = false;
  bool erroCadastro = false;

  bool logado(){
     User user = FirebaseAuth.instance.currentUser;
     if(user == null){
       return false;
     }else{
       uid = user.uid;      
       return true;
     }
  }
  cadastrarUsuario({@required String email, @required String senha, @required BuildContext context, @required String nome}){
    estaCarregando = true;
    notifyListeners();
    print('login iniciado');
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: senha
    ).then((value){
      erroCadastro = false;
      notifyListeners();
      uid = value.user.uid;
       FirebaseFirestore.instance.collection('restaurantes').doc(uid).set({
        'nome' : nome,
        'mesas' : 1,
        'conta' : 'ativa',
        'dataCadastro' : DateTime.now(),
        'ultimoPagamento' : DateTime.now()
      });
      FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('mesas').doc('1').set({
        'clientes' : List(),
        'situacao' : 'livre',
        'mesa' : 1
      });
      FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('balcao').doc('balcao').set({
        'clientes' : List(),
      });
      FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('categoria').doc('categoria').set({
        'categorias' : List(),
      });
      estaCarregando = false;
      notifyListeners();
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Administrativo()),
        (_)=> false,
      );
    }).catchError((error){
       estaCarregando = false;
       notifyListeners();
       erroCadastro = true;
       notifyListeners();
    });
  }

  
  loginUsuario({@required String email, @required String senha, @required BuildContext context}){
    estaCarregando = true;
    notifyListeners();
    print('login iniciado');
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: senha
    ).then((value){
      uid = value.user.uid;
      estaCarregando = false;
      notifyListeners();
      erroLogin = false;
      notifyListeners();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ContaAtiva()));
    }).catchError((error){
      print('erro encontrado');
      estaCarregando = false;
      notifyListeners();
      erroLogin = true;
      notifyListeners();
    });
  }

  logoutUsuario({@required BuildContext context}) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
    FirebaseAuth.instance.signOut().then((_){
      //uid = '';
      //notifyListeners();
    });
  }

  inserirNomeCliente({@required BuildContext context, @required int mesa, @required List clientes, @required GlobalKey globalKey}){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){            
              return Form(
                key: globalKey,
                child: Container(
                child: SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xff262626),                                 
                width: MediaQuery.of(context).size.width,
                child: Padding(padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.text,              
                    decoration: InputDecoration(                   
                      labelText: 'nome ',
                      labelStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                    // ignore: missing_return
                    validator: (value){
                      if(value.isEmpty){
                        return 'insira o nome do cliente';
                      }
                    },
                  onFieldSubmitted: (text){
                   if(text.isNotEmpty)
                      novoCliente(mesa: mesa, novoCliente: text, clientes: clientes);
                      text = '';
                      Navigator.of(context).pop();
                   },
                  ),
                ),
              ),
              ),
              ),
            );
          },
        );
      }
    );
  }

   inserirNomeClienteBalcao({@required BuildContext context, @required List clientes, @required GlobalKey globalKey}){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){            
              return Form(
                key: globalKey,
                child: Container(
                child: SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xff262626),                                 
                width: MediaQuery.of(context).size.width,
                child: Padding(padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.text,              
                    decoration: InputDecoration(                   
                      labelText: 'nome ',
                      labelStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                    // ignore: missing_return
                    validator: (value){
                      if(value.isEmpty){
                        return 'insira o nome do cliente';
                      }
                    },
                  onFieldSubmitted: (text){
                   if(text.isNotEmpty)
                      novoClienteBalcao(novoCliente: text, clientes: clientes);
                      text = '';
                      Navigator.of(context).pop();
                   },
                  ),
                ),
              ),
              ),
              ),
            );
          },
        );
      }
    );
  }

  novoClienteBalcao({@required String novoCliente, @required List clientes}){
    clientes.add(novoCliente);
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('balcao').doc('balcao').update({
      'clientes' : clientes,
    });
  }

  novoCliente({@required int mesa, @required String novoCliente, @required List clientes}) async {
    print(novoCliente);
    clientes.add(novoCliente);
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('mesas').doc(mesa.toString()).update({
      'clientes' : clientes,
      'situacao' : 'ocupada'
    });
    
  }

  deletarClienteBalcao({@required String cliente, @required BuildContext context, @required List clientes}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').get();
    for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
      if(documentSnapshot.data()['cliente'] == cliente && documentSnapshot.data()['origem'] == 'balcao' && documentSnapshot.data()['local'] == 'cozinha'){
        FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(documentSnapshot.id).update({
          'situacao' : 'cancelado'
        });
      }else if(documentSnapshot.data()['cliente'] == cliente && documentSnapshot.data()['origem'] == 'balcao'){
         FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(documentSnapshot.id).delete();
      }
    }
    clientes.remove(cliente);
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('balcao').doc('balcao').update({
      'clientes' : clientes,
    });
  }

  deletarCliente({@required int mesa, @required String cliente, @required BuildContext context, @required List clientes}) async {
    String situacao = 'ocupada';
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').get();
    for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
      if(documentSnapshot.data()['cliente'] == cliente && documentSnapshot.data()['mesa'] == mesa && documentSnapshot.data()['local'] == 'cozinha'){
        FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(documentSnapshot.id).update({
          'situacao' : 'cancelado'
        });
      }else if(documentSnapshot.data()['cliente'] == cliente && documentSnapshot.data()['mesa'] == mesa){
         FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(documentSnapshot.id).delete();
      }
    }
    clientes.remove(cliente);
    if(clientes.length == 0){
      situacao = 'livre';
    }
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('mesas').doc(mesa.toString()).update({
      'clientes' : clientes,
      'situacao' : situacao
    });
  }

  cancelarPedido({@required BuildContext context, @required String idPedido}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(idPedido).update({
      'situacao' : 'cancelado'
    });
  }


  deletarPedido({@required BuildContext context, @required String idPedido}){
      FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(idPedido).delete();
  }

  novoPedido({@required BuildContext context , @required String cliente, @required int mesa, @required int quantidade, @required String pedido, @required String detalhe, @required String observacao, @required double valor}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').add({
      'cliente' : cliente,
      'mesa' : mesa,
      'quantidade' : quantidade,
      'pedido' : pedido,
      'detalhe' : detalhe,
      'observacao' : observacao,
      'origem' : 'mesa',
      'local' : 'cozinha',
      'data' : DateTime.now(),
      'situacao' : 'enviado',
      'valor' : valor
    });
    Navigator.of(context).pop();
    salvarEstatistica(pedido: pedido, quantidade: quantidade);
  }

  novoPedidoBalcao({@required BuildContext context , @required String cliente, @required int quantidade, @required String pedido, @required String detalhe, @required String observacao, @required double valor}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').add({
      'cliente' : cliente,
      'mesa' : 0,
      'quantidade' : quantidade,
      'pedido' : pedido,
      'detalhe' : detalhe,
      'observacao' : observacao,
      'origem' : 'balcao',
      'local' : 'cozinha',
      'data' : DateTime.now(),
      'situacao' : 'enviado',
      'valor' : valor
    });
    Navigator.of(context).pop();
    salvarEstatistica(pedido: pedido, quantidade: quantidade);
  }

  inserirDetalhePedido({@required BuildContext context , @required String cliente, @required int mesa, @required String pedido, @required String detalhe, @required double valor, @required GlobalKey globalKey}){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){            
              return Form(
                 key: globalKey,
                 child: Container(
                  child: SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.all(8),
                  color: Color(0xff262626),                                 
                  width: MediaQuery.of(context).size.width,
                  child: Padding(padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: quantidade,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.number,              
                          decoration: InputDecoration(                   
                            labelText: 'quantidade ',
                            labelStyle: TextStyle(
                              color: Colors.grey
                            )
                          ),
                        onFieldSubmitted: (text){
                         if(text.isNotEmpty){
                            int quantidadeInteiro = int.parse(quantidade.text);                     
                            novoPedido(context: context, cliente: cliente, mesa: mesa, quantidade: quantidadeInteiro, pedido: pedido, observacao: observacao.text, detalhe: detalhe, valor: valor);
                            observacao.clear();
                            quantidade.clear();
                            Navigator.of(context).pop();
                            }
                          },
                        ),
                        TextFormField(
                          controller: observacao,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.text,              
                          decoration: InputDecoration(                   
                            labelText: 'observação ',
                            labelStyle: TextStyle(
                              color: Colors.grey
                            )
                          ),
                          onFieldSubmitted: (_){
                            if(quantidade.text.isNotEmpty){
                              int quantidadeInteiro = int.parse(quantidade.text);                     
                              novoPedido(context: context, cliente: cliente, mesa: mesa, quantidade: quantidadeInteiro, pedido: pedido, observacao: observacao.text, detalhe: detalhe, valor: valor);
                              observacao.clear();
                              quantidade.clear();
                              Navigator.of(context).pop();
                            }
                        },                   
                        ),
                     ],
                    ),
                  ),
                ),
                ),
                ),
              );
          },
        );
      }
    );
  }

  inserirDetalhePedidoBalcao({@required BuildContext context , @required String cliente, @required String pedido, @required String detalhe, @required double valor, @required GlobalKey globalKey}){
    quantidade.clear();
    observacao.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){            
              return Form(
                 key: globalKey,
                 child: Container(
                  child: SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.all(8),
                  color: Color(0xff262626),                                 
                  width: MediaQuery.of(context).size.width,
                  child: Padding(padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: quantidade,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.number,              
                          decoration: InputDecoration(                   
                            labelText: 'quantidade ',
                            labelStyle: TextStyle(
                              color: Colors.grey
                            )
                          ),
                        onFieldSubmitted: (text){
                         if(text.isNotEmpty){
                            int quantidadeInteiro = int.parse(quantidade.text);                     
                            novoPedidoBalcao(context: context, cliente: cliente, quantidade: quantidadeInteiro, pedido: pedido, observacao: observacao.text, detalhe: detalhe, valor: valor);
                            observacao.clear();
                            quantidade.clear();
                            Navigator.of(context).pop();
                            }
                          },
                        ),
                        TextFormField(
                          controller: observacao,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.text,              
                          decoration: InputDecoration(                   
                            labelText: 'observação ',
                            labelStyle: TextStyle(
                              color: Colors.grey
                            )
                          ),
                          onFieldSubmitted: (_){
                            if(quantidade.text.isNotEmpty){
                              int quantidadeInteiro = int.parse(quantidade.text);                     
                              novoPedidoBalcao(context: context, cliente: cliente, quantidade: quantidadeInteiro, pedido: pedido, observacao: observacao.text, detalhe: detalhe, valor: valor);
                              observacao.clear();
                              quantidade.clear();
                              Navigator.of(context).pop();
                            }
                        },                   
                        ),
                     ],
                    ),
                  ),
                ),
                ),
                ),
              );
          },
        );
      }
    );
  }

  vistoCozinha({@required String uidPedido})async{
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(uidPedido).update({
      'situacao' : 'em preparo'
    });
  }

   prontoCozinha({@required String uidPedido})async{
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(uidPedido).update({
      'situacao' : 'pronto',
    });
  }

  vistoMesas({@required String uidPedido})async{
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(uidPedido).update({
      'situacao' : 'indo buscar',
      'local' : 'cozinha'
    });
  }

  entregue({@required String uidPedido, @required String origem})async{
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(uidPedido).update({
      'situacao' : 'entregue',
      'local' : origem
    });
  }

  fecharMesa({@required BuildContext context, @required int mesa}) async {  
    var db = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot = await db.collection('restaurantes').doc(uid).collection('mesas').doc(mesa.toString()).get();
   
    List<dynamic> clientes;
    clientes = documentSnapshot.data()['clientes'];
    QuerySnapshot pedidosCliente = await db.collection('restaurantes').doc(uid).collection('pedidos').where('mesa', isEqualTo: mesa).get();

    db.collection('restaurantes').doc(uid).collection('mesas').doc(mesa.toString()).update({
      'clientes': List(),
      'situacao' : 'livre'
    });
    for(var cliente in clientes){ 
       FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').add({
         'cliente' : cliente,
         'origem' : 'mesa',
         'mesa' : mesa,
         'data' : DateTime.now() 
       }).then((value) async {

         for(DocumentSnapshot pedido in pedidosCliente.docs){
           if(pedido.data()['mesa'] == mesa && pedido.data()['cliente'] == cliente){
             if(pedido.data()['situacao'] == 'cancelado' && pedido.data()['local'] != 'cozinha'){

               db.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).delete();

             }else if(pedido.data()['local'] == 'cozinha'){
               
                FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).update({
                  'situacao' : 'cancelado'
                });

               }else{
               FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).collection('pedidos').add({
              'data' : pedido.data()['data'],
              'detalhe' : pedido.data()['detalhe'], 
              'local' : pedido.data()['local'], 
              'mesa' : pedido.data()['mesa'], 
              'observacao' : pedido.data()['observacao'], 
              'origem' : pedido.data()['origem'], 
              'pedido' : pedido.data()['pedido'], 
              'quantidade' : pedido.data()['quantidade'], 
              'situacao' : pedido.data()['situacao'],
              'cliente' : pedido.data()['cliente'],
              'valor' : pedido.data()['valor'],

            }).then((_) => db.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).delete());
             }
           }
         }
      QuerySnapshot pedidosCaixa = await  FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).collection('pedidos').get();
      if(pedidosCaixa.docs.length < 1){
        FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).delete();
       }
       });        
     }
  }

  fecharContaBalcao({@required BuildContext context, @required String cliente, @required List clientes})async{

    var db = FirebaseFirestore.instance;

    clientes.remove(cliente);

    QuerySnapshot pedidosCliente = await db.collection('restaurantes').doc(uid).collection('pedidos').where('origem', isEqualTo: 'balcao').get();

    db.collection('restaurantes').doc(uid).collection('balcao').doc('balcao').update({
      'clientes': clientes,
    });

   FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').add({
         'cliente' : cliente,
         'origem' : 'balcao',
         'mesa' : 0,
         'data' : DateTime.now() 
       }).then((value) async {

         for(DocumentSnapshot pedido in pedidosCliente.docs){

           if(pedido.data()['origem'] == 'balcao' && pedido.data()['cliente'] == cliente){

             if(pedido.data()['situacao'] == 'cancelado' && pedido.data()['local'] != 'cozinha'){

               db.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).delete();

             }else if(pedido.data()['local'] == 'cozinha'){
               
                FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).update({
                  'situacao' : 'cancelado'
                });

               }else{

               FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).collection('pedidos').add({
              'data' : pedido.data()['data'],
              'detalhe' : pedido.data()['detalhe'], 
              'local' : pedido.data()['local'], 
              'mesa' : pedido.data()['mesa'], 
              'observacao' : pedido.data()['observacao'], 
              'origem' : pedido.data()['origem'], 
              'pedido' : pedido.data()['pedido'], 
              'quantidade' : pedido.data()['quantidade'], 
              'situacao' : pedido.data()['situacao'],
              'cliente' : pedido.data()['cliente'],
              'valor' : pedido.data()['valor'],

            }).then((_) => db.collection('restaurantes').doc(uid).collection('pedidos').doc(pedido.id).delete());
          }
        }
      }

    QuerySnapshot pedidosCaixa = await  FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).collection('pedidos').get();
      if(pedidosCaixa.docs.length < 1){
        FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(value.id).delete();
     }
    });        
  }
  

  fecharConta({@required String idCliente, @required BuildContext context}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(idCliente).collection('pedidos').get();
           for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
             FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(idCliente).collection('pedidos').doc(documentSnapshot.id).delete();
           }
            FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(idCliente).delete();
            Navigator.of(context).pop();
  }

  alterarNumeroDeMesas({@required int numero, @required BuildContext context}) async {
    bool ocupada = false;
    var db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('restaurantes').doc(uid).collection('mesas').get();
    int mesas = querySnapshot.docs.length;
    for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
      if(documentSnapshot.data()['situacao'] == 'ocupada'){
        ocupada = true;
      }
    }
    db.collection('restaurantes').doc(uid).update({
      'mesas' : numero
    }).then((_){
      if(numero > mesas){
        for(int i = mesas; i <= numero; i++ ){
          if(i > mesas){
            List<String> clientes = [];
            db.collection('restaurantes').doc(uid).collection('mesas').doc(i.toString()).set({
              'clientes': clientes,
              'situacao' : 'livre',
              'mesa' : i
            });
          }
         }
      }else{
        if(ocupada){
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('mesa não pode ser deletada pois esta ocupada'))
          );
        }else{
          for(int i = numero + 1; i <= mesas; i++ ){
          db.collection('restaurantes').doc(uid).collection('mesas').doc(i.toString()).delete();
          
        }
        }
      }
    });
  }

  deletarCategoria({@required BuildContext context, @required List categorias ,@required String categoria}) async {
    categorias.remove(categoria);
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('categoria').doc('categoria').update({
      'categorias' : categorias
    });
   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('cardapio').get();
   for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
     if(documentSnapshot.data()['categoria'] == categoria){
       FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('cardapio').doc(documentSnapshot.id).delete();
     }
   }
  }

  novaCategoria({@required BuildContext context, @required List categorias ,@required String categoria}){
    categorias.add(categoria);
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('categoria').doc('categoria').update({
      'categorias' : categorias
    }).then((_) => Navigator.of(context).pop());

  }

  deletarItemCardapio({@required BuildContext context, @required String idItem}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('cardapio').doc(idItem).delete();

  }

  salvarNovoItemCardapio({@required BuildContext context, @required String nome, @required String categoria, @required String detalhe, @required String valor}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('cardapio').add({
      'nome' : nome,
      'categoria' : categoria,
      'detalhe' : detalhe,
      'valor' : double.parse(valor),
    });
    Navigator.of(context).pop();

  }

  deletarItemCaixa({@required String idCliente, @required String idPedido}){
    FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('caixa').doc(idCliente).collection('pedidos').doc(idPedido).delete();
  }

  salvarEstatistica({@required String pedido, @required int quantidade}) async {

      bool pedidoExiste = false;
      int quantidadeExiste = 0;
      int valor = 0;
      int index = 0;
      int indexRemover; 
      List<dynamic> pedidos = List<dynamic>();

      initializeDateFormatting('pt_BR');
      var formatadorData = DateFormat('dd-MM-y');
      String dataFormatada = formatadorData.format(DateTime.now());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').orderBy('data').get();
      for(DocumentSnapshot snapshot in querySnapshot.docs){
        print(snapshot.id);
      }

      if(querySnapshot.docs.length >= 30){
        FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').doc(querySnapshot.docs[querySnapshot.docs.length - 1].id).delete();     
      }

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').doc(dataFormatada).get();

      if(documentSnapshot.exists){
          pedidos = documentSnapshot.data()['pedidos'];

          for(Map maps in pedidos){            
            if( maps.keys.contains(pedido)){
              print('pedido encontrado');
              pedidoExiste = true;
              quantidadeExiste = maps[pedido];
              print('---' + quantidadeExiste.toString());
              print('---' + index.toString());
              indexRemover = index;
             
            }
            else{
              print('pedido não encontrado');
            }
            index = index +1;  
          }

          if(pedidoExiste == true){
            print('contem o pedido na lista');
            pedidos.removeAt(indexRemover);
            valor = quantidadeExiste + quantidade;
            pedidos.add({
              pedido : valor
            });

            FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').doc(dataFormatada).set({
              'data' : DateTime.now(),
              'pedidos' : pedidos
            });

          }else{
            print('não contem o pedido na lista');
            pedidos.add({
              pedido : quantidade
            });
            FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').doc(dataFormatada).set({
              'data' : DateTime.now(),
              'pedidos' : pedidos
            });
          }
      }else{
        print('+++ ' + 'igual a nulo');
        print('não contem o pedido na lista');     
         pedidos.add({
          pedido : quantidade
        });
         FirebaseFirestore.instance.collection('restaurantes').doc(uid).collection('estatistica').doc(dataFormatada).set({
          'data' : DateTime.now(),
          'pedidos' : pedidos
        });
      } 
  }
}