// componentes/lista_despesas.dart
import 'package:flutter/material.dart';
import '../modelos/despesa.dart';
import 'package:intl/intl.dart'; // Importação do pacote intl para formatação de data

// Função que constrói a lista de despesas
Widget construirListaDespesas(List<Despesa> despesas, Function removerDespesa) {
  return ListView.builder(
    itemCount: despesas.length, // Número total de despesas
    itemBuilder: (context, index) {
      final despesa = despesas[index]; // Obtém a despesa atual pelo índice
      final formatadorData =
          DateFormat('dd/MM/yyyy'); // Cria um formatador de data

      return Card(
        margin: EdgeInsets.symmetric(
            vertical: 8, horizontal: 16), // Espaçamento ao redor do cartão
        elevation: 5, // Sombra do cartão
        child: ListTile(
          title: Text(
            despesa.descricao, // Exibe a descrição da despesa
            style: TextStyle(fontWeight: FontWeight.bold), // Estilo em negrito
          ),
          subtitle: Text(
            'Data: ${formatadorData.format(despesa.data)}\nValor: R\$${despesa.valor.toStringAsFixed(2)}', // Exibe a data formatada e o valor
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red), // Ícone de deletar
            onPressed: () {
              removerDespesa(
                  index); // Remove a despesa ao pressionar o botão de excluir
            },
          ),
        ),
      );
    },
  );
}
