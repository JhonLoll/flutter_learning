class Usuario {
  String? nome;
  String? email;
  String? senha;
  String? ultima_atividade;

  void exibir_informacoes() {
    print(
        "Nome: ${nome}, Email: ${email}, Ultima Atividade: ${ultima_atividade}");
  }
}

void main() {
  Usuario pessoa1 = Usuario();

  pessoa1.nome = 'Joao';
  pessoa1.email = 'joao@email.com';
  pessoa1.senha = '1234';
  pessoa1.ultima_atividade = 'comer';
  pessoa1.exibir_informacoes();

  Usuario pessoa2 = Usuario();

  pessoa1.nome = 'Maria';
  pessoa1.email = 'Maria@email.com';
  pessoa1.senha = '4321';
}
