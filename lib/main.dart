import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Compras {
  String nome;
  String categoria;
  String preco;

  Compras({required this.nome, required this.categoria, required this.preco});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Lista de Compras',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      backgroundColor: Color.fromARGB(255, 181, 181, 181),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'images/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),

                // Adiciona a segunda imagem acima do logo
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: 'Insira "Paola" como valor de usuário:'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Insira "Paola123" como valor da senha:'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'Paola' &&
                    _passwordController.text == 'Paola123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login feito com sucesso')),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Cadastrar-se'),
            ),
            Text('Paola Oliveira N°26')
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Compras> students = [
    Compras(nome: 'Arroz', categoria: 'Comida', preco: "10.00"),
    Compras(nome: 'Pepsi', categoria: 'Bebida', preco: "8.50"),
    Compras(nome: 'Sabão em Pó', categoria: 'Produto de limpeza', preco: "5.0"),
    Compras(nome: 'Batata palito', categoria: 'Comida', preco: "9.50"),
    Compras(
        nome: 'Ypê 5 litros', categoria: 'Produto de limpeza', preco: "6.20"),
    Compras(nome: 'Energético', categoria: 'Bebida', preco: "5.90"),
    Compras(nome: 'Acetona', categoria: 'Produto de beleza', preco: "3.00"),
    Compras(nome: 'Marmita', categoria: 'Comida', preco: "15.90"),
    Compras(nome: 'Pão', categoria: 'Comida', preco: "4.00"),
    Compras(
        nome: 'Kit Maquiagem', categoria: 'Produto de beleza', preco: "130.50"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      backgroundColor: Color.fromARGB(255, 181, 181, 181),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].nome),
            subtitle: Text(students[index].categoria +
                ', Preço: ' +
                students[index].preco),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir aluno
                students.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produto removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o aluno
              Compras updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: students[index].categoria);
                  TextEditingController _precoController =
                      TextEditingController(text: students[index].preco);

                  return AlertDialog(
                    title: Text('Novo Produto'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration:
                              InputDecoration(labelText: 'Nome do Produto'),
                        ),
                        TextField(
                          controller: _categoriaController,
                          decoration: InputDecoration(labelText: 'Categoria'),
                        ),
                        TextField(
                          controller: _precoController,
                          decoration: InputDecoration(labelText: 'Preço'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _precoController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Compras(
                                nome: _nomeController.text.trim(),
                                categoria: _categoriaController.text.trim(),
                                preco: _precoController.text.trim(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Pedidio alterado com sucesso')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o aluno na lista
                students[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo aluno
          Compras newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precoController = TextEditingController();

              // Adicionar novo aluno
              return AlertDialog(
                title: Text('Novo Produto'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome do Produto'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                    TextField(
                      controller: _precoController,
                      decoration: InputDecoration(labelText: 'Preço'),
                    ),
                  ],
                ),

                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),

                  // Validar e adicionar o novo aluno
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _precoController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Compras(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            preco: _precoController.text.trim(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Pedido adicionado com sucesso ')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar Produto'),
                  ),
                ],
              );
            },
          );

          // Verificar espaço a ser alocado para a adição do novo aluno
          if (newStudent != null) {
            // Adicionar o novo aluno à lista
            students.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
