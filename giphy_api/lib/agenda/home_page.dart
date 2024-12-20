import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _search = "";

  // Função para buscar os gifs
  Future<Map> _getGifs() async {
    http.Response response;
    if (_search.isEmpty)
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=dikHl1BW8NXYtcLsCDWLXZoQnw6QSWMB&limit=25&offset=26&rating=g&bundle=messaging_non_clips"));
    else
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=dikHl1BW8NXYtcLsCDWLXZoQnw6QSWMB&q=$_search&limit=26&offset=25&rating=g&lang=en&bundle=messaging_non_clips"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  // Função para buscar gifs quando pressionado Enter
  void _onSearchSubmit() {
    setState(() {
      _search = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Pesquise Aqui",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (value) => _onSearchSubmit(), // Ação de pesquisa
            ),
          ),
          // Exibindo o progresso enquanto carrega
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container();
                        else
                          return _createGifGrid(context, snapshot);
                    }
                  }))
        ],
      ),
    );
  }

  // Função que cria a grid de gifs
  Widget _createGifGrid(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
        var gifUrl =
            snapshot.data["data"][index]["images"]["fixed_height"]["url"];
        return GestureDetector(
          onTap: () {
            // Navega para uma nova página com o gif selecionado
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GifPage(gifUrl: gifUrl),
              ),
            );
          },
          child: Image.network(gifUrl),
        );
      },
    );
  }
}

// Nova tela para exibir o gif em tamanho maior e permitir o compartilhamento
class GifPage extends StatelessWidget {
  final String gifUrl;
  const GifPage({super.key, required this.gifUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Gif"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(gifUrl),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Compartilha o gif
                Share.share(gifUrl);
              },
              child: Text(
                'Compartilhar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
