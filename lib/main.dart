// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms and Textfields',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Forms and TextFields!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  int _counter = 0;
  String newTitle = "";
  String newEmail = "";
  final TextEditingController _emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newTitle = widget.title;
    _emailTextController.addListener(() => setState(() {}));
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _changeTitle(String title) {
    setState(() {
      newTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    newTitle.isEmpty ? _changeTitle(widget.title) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(newTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildEmail(),
                  ),
                  buildSubmitBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter;
          _changeTitle('${_emailTextController.text} xd');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildEmail() => TextFormField(
        // maxLength: 10, //No puede escribir + de 10 letras
        // maxLines: 3, //por default es 1
        controller: _emailTextController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        // obscureText: true, //for password
        validator: (value) {
          // return value!.length < 4 ? 'Enter at leat 4' : null; //Es un ejemplo
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          _changeTitle(value!);
        },
        decoration: const InputDecoration(
            fillColor: Colors.blue,
            helperText: 'Tu sabroso Email!',
            // border: OutlineInputBorder(),
            border: InputBorder.none,
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.amber, fontSize: 30),
            // icon: Icon(Icons.mail_rounded),
            hintText: 'example@example.com',
            hintStyle: TextStyle(color: Colors.blue, fontSize: 22),
            prefixIcon: Icon(Icons.email),
            suffixIcon: Icon(Icons.check)),
      );
  Widget buildSubmitBtn() => MaterialButton(
        onPressed: () {
          final isValid = formKey.currentState!.validate();
          FocusScope.of(context).unfocus();
          if (isValid) {
            formKey.currentState!.save();
            final message = 'Email $newEmail is: \nSaved';
            final snackBar = SnackBar(
              content: Text(
                message,
                style: const TextStyle(fontSize: 20),
              ),
              backgroundColor: const Color.fromARGB(255, 85, 55, 194),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        color: Theme.of(context).primaryColor,
        child: const Text('Submit'),
      );
}
