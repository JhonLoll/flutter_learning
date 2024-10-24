import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> name = ['January','February','March','April','May','June','July','August','September'
    ,'October','November','December'];

  List<String> tempArray = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView With Select" , style: TextStyle(fontStyle: FontStyle.italic,
            fontSize: 30),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Expanded(
               child: ListView.builder(
                   itemCount: name.length,
                   itemBuilder: (context, index) {
                     return InkWell(
                       child: Card(
                         child: ListTile(
                           title: Text(name[index].toString(), style: TextStyle(fontStyle: FontStyle.italic,
                               fontSize: 20)),
                           trailing: Container(
                             height: 50,
                             width: 100,
                             decoration: BoxDecoration(
                               color: tempArray.contains(name[index].toString()) ? Colors.red : Colors.green
                             ),
                             child: Center(
                               child: Text(tempArray.contains(name[index].toString()) ? 'REMOVE' : 'ADD',
                                   style: TextStyle(fontStyle: FontStyle.italic,
                                   fontSize: 20)),
                             ),
                           ),
                         ),
                       ),
                       onTap: () {
                        setState(() {
                          if(tempArray.contains(name[index].toString())) {
                            tempArray.remove(name[index].toString());
                          } else {
                            tempArray.add(name[index].toString());
                          }
                        });
                       },
                     );
                   }),
             )
          ],
        ),
      ),
    );
  }
}