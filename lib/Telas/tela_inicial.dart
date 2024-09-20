// tela_inicial.dart
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'adicionar_despesa_tela.dart';
import '../modelos/despesa.dart';
import '../componentes/lista_despesas.dart';

// Tela inicial do aplicativo
class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  // Lista para armazenar as despesas adicionadas
  List<Despesa> despesas = [];
  bool isHelloWorld = false; // Controla o estado do texto

  // Função para adicionar uma nova despesa
  void adicionarDespesa(Despesa despesa) {
    setState(() {
      despesas.add(despesa); // Adiciona a despesa à lista
    });
  }

  // Função para remover uma despesa com base no índice
  void removerDespesa(int index) {
    setState(() {
      despesas.removeAt(index); // Remove a despesa da lista
    });
  }

  // Função para calcular o total das despesas
  double calcularTotal() {
    return despesas.fold(0, (total, despesa) => total + despesa.valor); // Soma todos os valores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas'), // Título da barra superior
        actions: [
          // Botão para adicionar uma nova despesa
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navega para a tela de adicionar despesa
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AdicionarDespesaTela(adicionarDespesa: adicionarDespesa),
                ),
              );
            },
          ),
          // Botão para alternar o tema (claro/escuro)
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Alterna entre tema claro e escuro
              ThemeMode currentTheme = Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              MeuAplicativo.of(context)?.changeTheme(currentTheme); // Chama a função para mudar o tema
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Botão que alterna entre o texto original e "Hello World"
          GestureDetector(
            onTap: () {
              setState(() {
                isHelloWorld = !isHelloWorld; // Alterna o estado
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espaçamento lateral e vertical
              margin: EdgeInsets.symmetric(horizontal: 16.0), // Margem lateral
              decoration: BoxDecoration(
                color: Colors.blue, // Cor de fundo do botão
                borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
              ),
              child: Text(
                isHelloWorld ? 'Hello World!' : 'Aonde meu salário vai, e eu nem vejo...?', // Texto alternado
                style: TextStyle(
                  fontSize: 24, // Tamanho da fonte
                  fontWeight: FontWeight.bold, // Estilo em negrito
                  color: Colors.white, // Cor do texto
                ),
                textAlign: TextAlign.center, // Alinhamento centralizado
              ),
            ),
          ),
          // Exibe o total das despesas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$${calcularTotal().toStringAsFixed(2)}', // Formata o total em duas casas decimais
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Estilo do texto
            ),
          ),
          // Exibe a lista de despesas
          Expanded(
            child: construirListaDespesas(despesas, removerDespesa),
          ),
        ],
      ),
    );
  }
}
