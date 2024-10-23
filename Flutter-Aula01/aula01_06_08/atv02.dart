void main() {
  cadastrarLivro("Livro Teste",
      genero: "Suspense",
      autor: "JH",
      editora: "Editora Teste",
      dataPublicacao: "13/08/2024");
}

//Função cadastrar livro
void cadastrarLivro(String titulo, //
    {String? genero, //Valor opcional, tendo como valor padrão "Null"
    String? autor =
        "Autor não informado", //Valor opcional, tendo como valor padrão "Null"
    String? editora =
        "Editora não informada", //Valor opcional, tendo como valor padrão "Null"
    String? dataPublicacao}) {
  //Inicializa variaveis que iram controlar quais informações serão exibidas
  bool mostrarGenero = false, mostrarData = false;

  //Verifica se o genero foi informado
  if (genero != null) {
    mostrarGenero = true;
  }
  //Verifica se a data de publicação foi informada
  if (dataPublicacao != null) {
    mostrarData = true;
  }

  //Imprime o titulo do livro
  print("Título: ${titulo}");
  //Imprime o autor do livro, se tiver sido informado
  print("Autor: ${autor ?? "Autor não informado"}");
  //Imprime a editora, se tiver sido informada
  print("Editora: ${editora ?? "Editora não informada"}");
  //Verifica se o genero foi informado e imprime
  if (mostrarGenero) {
    print("Genero: ${genero ?? "Genero não informado"}");
  }
  //Verifica se a data de publicacao foi informada e imprime
  if (mostrarData) {
    print("Data de publicação: ${dataPublicacao ?? "Data não informada"}");
  }
}
