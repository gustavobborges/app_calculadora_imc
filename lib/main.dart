import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();
  TextEditingController _controllerImc = TextEditingController();

  String peso;
  String altura;
  String imc;

  void refresh() {
    setState(() {
      peso = _controllerPeso.text = "";
      altura = _controllerAltura.text = "";
      imc = _controllerImc.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULADORA IMC'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('DESENVOLVEDORES'),
                    ),
                    body: const Center(
                      child: Text(
                        'Todos os direitos reservados.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'MENU CALCULADORA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('History'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 15),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _controllerPeso,
                  obscureText: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.straighten_rounded),
                      labelText: "Seu peso"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe o peso!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _controllerAltura,
                  obscureText: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.straighten_rounded),
                      labelText: "Sua altura"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informa a altura!";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(color: Colors.deepPurpleAccent))),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 60)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          altura = _controllerAltura.value.text;
                          peso = _controllerPeso.value.text;
                          var alturaInt = int.parse(altura);
                          var pesoint = int.parse(peso);
                          var imcInt = pesoint/((alturaInt * alturaInt)/10000);
                          var imcDouble = imcInt.toStringAsPrecision(4);
                          imc = imcDouble;
                          print('Peso: ${alturaInt} | Altura: ${pesoint} | Imc: ${imcDouble}');
                        });
                      }
                    },
                    child: Text("Calcular IMC!"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: RichText(
                    text: TextSpan(
                      text: imc,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            refresh();
          });
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.purple,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("IMC")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Minha conta")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle),
              title: Text("Configurações")
          ),
        ],
      ),
    );
  }
}
