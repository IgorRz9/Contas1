// adicionar_despesa_tela.dart
import 'package:flutter/material.dart';
import '../modelos/despesa.dart';
import 'package:intl/intl.dart'; // Importa o pacote para formatação de data

class AdicionarDespesaTela extends StatefulWidget {
  final Function adicionarDespesa; // Função para adicionar despesa recebida como argumento

  AdicionarDespesaTela({required this.adicionarDespesa}); // Construtor

  @override
  _AdicionarDespesaTelaState createState() => _AdicionarDespesaTelaState();
}

class _AdicionarDespesaTelaState extends State<AdicionarDespesaTela> {
  final _formKey = GlobalKey<FormState>(); // Chave para identificar o formulário
  String _descricao = ''; // Variável para armazenar a descrição da despesa
  DateTime _dataSelecionada = DateTime.now(); // Data selecionada, inicia com a data atual
  double _valor = 0.0; // Valor da despesa

  // Função para submeter o formulário
  void _submitForm() {
    if (_formKey.currentState!.validate()) { // Valida o formulário
      _formKey.currentState!.save(); // Salva os dados do formulário

      final novaDespesa = Despesa( // Cria uma nova despesa
        descricao: _descricao,
        data: _dataSelecionada,
        valor: _valor,
      );

      widget.adicionarDespesa(novaDespesa); // Chama a função para adicionar a despesa
      Navigator.of(context).pop(); // Volta para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatadorData = DateFormat('dd/MM/yyyy'); // Formata a data

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Despesa'), // Título da tela
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Espaçamento interno
        child: Form(
          key: _formKey, // Atribui a chave ao formulário
          child: Column(
            children: [
              // Campo para descrição da despesa
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição.'; // Validação do campo
                  }
                  return null; // Retorna nulo se a validação passar
                },
                onSaved: (value) {
                  _descricao = value!; // Salva a descrição
                },
              ),
              // Campo para valor da despesa
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number, // Teclado numérico
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido.'; // Validação do valor
                  }
                  return null; // Retorna nulo se a validação passar
                },
                onSaved: (value) {
                  _valor = double.parse(value!); // Salva o valor como double
                },
              ),
              SizedBox(height: 20), // Espaçamento entre campos
              // Campo para seleção de data
              TextFormField(
                readOnly: true, // Campo somente leitura
                decoration: InputDecoration(labelText: 'Data'),
                onTap: () {
                  _selecionarData(context); // Abre o seletor de data ao tocar
                },
                controller: TextEditingController(text: formatadorData.format(_dataSelecionada)), // Controlador para mostrar a data formatada
              ),
              SizedBox(height: 20), // Espaçamento entre campos
              // Botão para adicionar a despesa
              ElevatedButton(
                onPressed: _submitForm, // Chama a função de submissão
                child: Text('Adicionar Despesa'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para selecionar a data
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada, // Data inicial no seletor
      firstDate: DateTime(2000), // Data mínima
      lastDate: DateTime(2101), // Data máxima
    );
    if (dataEscolhida != null && dataEscolhida != _dataSelecionada) {
      setState(() {
        _dataSelecionada = dataEscolhida; // Atualiza a data selecionada
      });
    }
  }
}
