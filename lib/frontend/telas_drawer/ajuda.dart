import 'package:flutter/material.dart';

class Ajuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuda'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mesas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se a mesa está ocupada?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, será aberta uma nova tela com todas as mesas cadastradas, as mesas ocupadas estarão com um fundo vermelho enquanto que as mesas livres estarão com um fundo verde.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: quanto um novo cliente é inserido em uma mesa que esta livre ela passa a ser considerada ocupada automaticamente pelo aplicativo, bem como uma mesa ocupada quando é fechada passa a ser considerada livre automaticamente pelo aplicativo.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como inserir um novo cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, depois clique sobre o número da mesa em que o cliente está, será aberta uma nova tela com o nome dos clientes já inseridos na mesa, clique no botão azul na parte inferir da tela, insira o nome do novo cliente e clique no botão inserir do teclado virtual.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: o aplicativo irá considerar dois clientes com o mesmo nome como se fossem a mesma pessoa, por isso caso exista duas pessoas com o mesmo nome na mesma mesa é necessário inserir uma delas junto com um sobrenome.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como excluir um cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, depois clique sobre o número da mesa em que o cliente está, será aberta uma nova tela com o nome dos clientes já inseridos na mesa, clique no ícone de lixeira na frente do nome do cliente que deseja excluir.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao clicar em excluir um cliente todos os pedidos efetuados por ele serão excluídos também, caso existam pedidos que ainda estão na cozinha eles serão cancelados.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como inserir um pedido?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, depois clique sobre o número da mesa em que o cliente está, será aberta uma nova tela com o nome dos clientes já inseridos na mesa, clique no nome do cliente que está fazendo o pedido, será aberta uma nova tela com todos os pedidos efetuados pelo cliente, clique no botão azul na parte inferior da tela, será aberta a tela de cardápio, clique sobre o card do item que o cliente deseja pedir. Informe a quantidade é obrigatório e caso exista insira a observação que é opcional, depois clique sobre a tecla inserir do teclado virtual.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: a quantidade é obrigatória coloque um valor diferente de zero, a observação é opcional, caso não exista não insira nada no espaço.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como excluir um pedido?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, depois clique sobre o número da mesa em que o cliente está, será aberta uma nova tela com o nome dos clientes já inseridos na mesa, clique no nome do cliente que está fazendo o pedido, será aberta uma nova tela com todos os pedidos efetuados pelo cliente, clique no ícone de lixeira na frente do nome do pedido que deseja excluir.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao clicar em excluir um pedido, caso ainda esteja na cozinha ele será cancelado.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se um pedido está pronto?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, na frente do título da tela estará escrito a palavra prontos junto com um número, este número representa a quantidades de pedidos prontos na cozinha, para verificar as informações de cada pedido clique sobre a palavra pronto. Será aberta uma nova tela com todos os pedidos prontos na cozinha e informações como nome do cliente e mesa. Clique no ícone no canto direito para informar a cozinha que o pedido foi visualizado.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: após visualizar o pedido clique no ícone no canto direito para registrar que você está indo busca-lo na cozinha, os pedidos visualizados ficarão com o fundo amarelo para destaca-los dos outros e os garçons saberem quais pedidos estão sendo buscados e quais ainda estão aguardando.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como informo que o pedido foi entregue na mesa?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, na frente do título da tela estará escrito a palavra prontos com um número, clique na palavra prontos, será aberta uma nova tela com todos os pedidos prontos na cozinha, os pedidos que foram visualizados pelos garçons estão com fundo amarelo e com o ícone de uma seta no canto direito, clique sobre o ícone da seta do pedido que você entregou na mesa.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('importante: ao clicar na seta o pedido deixara de ser mostrado na tela de pedidos prontos, para acompanha-lo será necessário entrar na tela da mesa e clicar no nome do cliente que efetuou o pedido, ele aparecera junto com os outros pedidos do cliente.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como fechar uma mesa?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba mesas através do menu lateral, as mesas ocupadas estarão com um fundo vermelho, encontre a que deseja fechar e clique duas vezes sobre o numero da mesa. As informações dos clientes da mesa e seus respectivos consumo serão enviados para a aba caixa e a mesa passara a ser mostrada como livre.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao fechar uma mesa todos os pedidos feitos pelos clientes que não foram entregues na mesa serão cancelados, certifique-se de que todos os pedidos feitos foram entregues antes de fechar a mesa a menos que o cliente não deseja mais recebe-lo, caso não exista nenhum pedido entregue na mesa, as informações serão apagadas e não serão enviadas para a aba caixa.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

               SizedBox(
                height: 8.0,
              ),

              Text('Balcão',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como inserir um novo cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, será aberta uma nova tela com o nome dos clientes já inseridos no balcão, clique no botão azul na parte inferir da tela, insira o nome do novo cliente e clique no botão inserir do teclado virtual.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: o aplicativo irá considerar dois clientes com o mesmo nome como se fossem a mesma pessoa, por isso caso exista duas pessoas com o mesmo nome no balcão é necessário inserir uma delas junto com um sobrenome.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como excluir um cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, será aberta uma nova tela com o nome dos clientes já inseridos no balcão, clique no ícone de lixeira na frente do nome do cliente que deseja excluir.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao clicar em excluir um cliente todos os pedidos efetuados por ele serão excluídos também, caso existam pedidos que ainda estão na cozinha eles serão cancelados.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como inserir um pedido?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, será aberta uma nova tela com o nome dos clientes já inseridos no balcão, clique no nome do cliente que está fazendo o pedido, será aberta uma nova tela com todos os pedidos efetuados pelo cliente, clique no botão azul na parte inferior da tela, será aberta a tela de cardápio, clique sobre o card do item que o cliente deseja pedir. Informe a quantidade é obrigatório e caso exista insira a observação que é opcional, depois clique sobre a tecla inserir do teclado virtual.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: a quantidade é obrigatória coloque um valor diferente de zero, a observação é opcional, caso não exista não insira nada no espaço.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como excluir um pedido?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, será aberta uma nova tela com o nome dos clientes já inseridos no balcão, clique no nome do cliente que está fazendo o pedido, será aberta uma nova tela com todos os pedidos efetuados pelo cliente, clique no ícone de lixeira na frente do nome do pedido que deseja excluir.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao clicar em excluir um pedido, caso ainda esteja na cozinha ele será cancelado.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se um pedido está pronto?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, na frente do título da tela estará escrito a palavra prontos junto com um número, este número representa a quantidades de pedidos prontos na cozinha, para verificar as informações de cada pedido clique sobre a palavra pronto. Será aberta uma nova tela com todos os pedidos prontos na cozinha e informações como nome do cliente. Clique no ícone no canto direito para informar a cozinha que o pedido foi visualizado.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: após visualizar o pedido clique no ícone no canto direito para registrar que você está indo busca-lo na cozinha, os pedidos visualizados ficarão com o fundo amarelo para destaca-los dos outros e os garçons saberem quais pedidos estão sendo buscados e quais ainda estão aguardando.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como informo que o pedido foi entregue para o cliente no balcão?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, na frente do título da tela estará escrito a palavra prontos com um número, clique na palavra prontos, será aberta uma nova tela com todos os pedidos prontos na cozinha, os pedidos que foram visualizados pelos garçons estão com fundo amarelo e com o ícone de uma seta no canto direito, clique sobre o ícone da seta do pedido que você entregou no balcão.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('importante: ao clicar na seta o pedido deixará de ser mostrado na tela de pedidos prontos, para acompanha-lo será necessário entrar na tela do balcão e clicar no nome do cliente que efetuou o pedido, ele aparecera junto com os outros pedidos do cliente.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //

              SizedBox(
                height: 8.0,
              ),
              Text('Como fechar a conta do cliente no balcão?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('entre na aba balcão através do menu lateral, encontre o nome do cliente que deseja fechar a conta e clique duas vezes sobre o nome. As informações do consumo serão enviadas para a aba caixa e o nome do cliente deixará de ser mostrada na tela balcão.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              Text('Importante: ao fechar a conta os pedidos feitos pelo cliente que não foram entregues serão cancelados, certifique-se de que todos os pedidos feitos foram entregues antes de fechar a conta a menos que o cliente não deseja mais recebe-lo, caso não exista nenhum pedido entregue, as informações serão apagadas e não serão enviadas para a aba caixa.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

               SizedBox(
                height: 8.0,
              ),

              Text('Cozinha',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como saber os pedidos dos clientes?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como informo que o pedido está em preparo?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Clique no ícone no canto direito do pedido que a cozinha está preparando, o pedido passara a ter um fundo amarelo para destaca-lo dos outros pedidos.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              

              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como informo que um pedido está pronto?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Clique no ícone de seta no canto direito do pedido que está pronto, o pedido passara a ter um fundo azul para destaca-lo dos outros pedidos.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se o pedido pronto foi visto pelo garçom?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Na parte inferior do card do pedido será exibida a informação sobre a situação do pedido e o local, os pedidos prontos terão a informação: pronto cozinha, após o garçom visualizar que o pedido está pronto a informação mudara para: indo buscar cozinha.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se o pedido foi entregue para o cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Na parte inferior do card do pedido será exibida a informação sobre a situação do pedido e o local. Quando o pedido pronto for retirado da cozinha pelo garçom a informação do card e o local mudara para: entregue mesa ou entregue balcão, com isso o card do pedido deixara de ser exibido na tela cozinha.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como saber se um pedido está cancelado?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Na parte inferior do card do pedido será exibida a informação sobre a situação do pedido e o local, os pedidos cancelados terão a informação:  cancelado cozinha e a cor de fundo mudara para vermelho.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como deletar um pedido cancelado?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba cozinha através do menu lateral, será aberta uma nova tela, todos os pedidos feitos tanto por clientes nas mesas quanto por clientes no balcão serão exibidos nessa tela. Os pedidos cancelados terão um fundo vermelho e um ícone de lixeira na parte lateral direita, clique sobre o ícone de lixeira do pedido que deseja deletar.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),

              
               SizedBox(
                height: 8.0,
              ),

              Text('Caixa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),


              //


              SizedBox(
                height: 8.0,
              ),
              Text('Como saber o consumo de cada cliente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Entre na aba caixa através do menu lateral, será aberta uma nova tela, todos os clientes que já fecharam a conta serão exibidos na tela com o nome e o número da mesa que estava caso tenha ocupado uma mesa ou o nome e a palavra balcão caso tenha consumido sem ocupar uma mesa. Clique em cima do nome do cliente que deseja verificar o consumo, será aberta uma nova tela com todo o consumo do cliente menos os pedidos cancelados ou que não chegaram a ser entregues, insira as informações no sistema de pagamento do local. Depois do cliente efetuar o pagamento clique no botão no canto inferior da tela escrito finalizar conta, todas as informações do cliente serão apagadas e o nome dele deixara de ser exibido na tela caixa.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Importante: não é possível realizar pagamento ou emitir nota fiscal pelo aplicativo, ele também não está integrado a outros sistemas por isso é necessário inserir de forma manual o consumo no sistema de pagamento próprio do local e confirmar o pagamento antes de clicar no botão finalizar conta.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text('outras duvidas entre em contato pelo email: penrose.app.console@gmail.com',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                ),
              ),
              

            ],
          ),
        )
      ),
    );
  }
}