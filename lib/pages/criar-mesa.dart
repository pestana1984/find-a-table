// import 'dart:convert';
// import 'dart:io' as IO;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:finda_a_table/apis/api-mesa.dart';
import 'package:finda_a_table/pages/bottomNavigationBar.dart';
import 'package:finda_a_table/reciclagem/label.dart';
import 'package:flutter/material.dart';

class CriarMesa extends StatefulWidget {
  @override
  _CriarMesaState createState() => _CriarMesaState();
}

class _CriarMesaState extends State<CriarMesa> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _numController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _sistemaController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _validate = false;
  String nome, sistema, num, tags, desc;
  File _imageFile;

  // final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      autovalidate: _validate,
      child: Container(
          padding: EdgeInsets.only(top: 20, left: 25, right: 25),
          child: ListView(
            children: <Widget>[
              Text(
                "Uma nova aventura está para começar!!!",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF002B32),
                ),
                textAlign: TextAlign.center,
              ),
              labelComum("Nome"),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: _validarNome,
                controller: _nomeController,
                decoration: InputDecoration(
                    hintText: "Fogo no parquinho",
                    labelStyle: TextStyle(
                      color: Color(0xFF002B32),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002B32)),
                    )),
                style: TextStyle(
                  fontSize: 15,
                ),
                onSaved: (String val) {
                  nome = val;
                },
              ),
              labelComum("Sistema"),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: _validarSistema,
                controller: _sistemaController,
                decoration: InputDecoration(
                    hintText: "D&D",
                    labelStyle: TextStyle(
                      color: Color(0xFF002B32),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002B32)),
                    )),
                style: TextStyle(
                  fontSize: 15,
                ),
                onSaved: (String val) {
                  sistema = val;
                },
              ),
              labelComum("Nº de Participantes"),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: _validarNum,
                controller: _numController,
                decoration: InputDecoration(
                    hintText: "5",
                    labelStyle: TextStyle(
                      color: Color(0xFF002B32),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002B32)),
                    )),
                style: TextStyle(
                  fontSize: 15,
                ),
                onSaved: (String val) {
                  num = val;
                },
              ),
              labelComum("Link"),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: _validarLink,
                controller: _linkController,
                decoration: InputDecoration(
                    hintText: "www.discord.com",
                    labelStyle: TextStyle(
                      color: Color(0xFF002B32),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002B32)),
                    )),
                style: TextStyle(
                  fontSize: 15,
                ),
                onSaved: (String val) {
                  desc = val;
                },
              ),
              labelComum("Descrição"),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: _validarDesc,
                controller: _descController,
                decoration: InputDecoration(
                    hintText: "O dragão ficou maluco!",
                    labelStyle: TextStyle(
                      color: Color(0xFF002B32),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002B32)),
                    )),
                style: TextStyle(
                  fontSize: 15,
                ),
                onSaved: (String val) {
                  desc = val;
                },
              ),
              labelComum("Capa"),
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: _imageFile == null
                      ? Image.asset("assets/images/paisagem.jpg")
                      : Image.file(_imageFile),
                ),
                onTap: _modalAviso,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF002B32),
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox.expand(
                    child: FlatButton(
                      onPressed: _sendForm,
                      child: Text(
                        "Começar aventura!!!",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    ));
  }

  String _validarNome(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe o Nome";
    } else if (!regExp.hasMatch(value)) {
      return "Nome Inválido";
    }
    return null;
  }

  String _validarSistema(String value) {
    String pattern = r'(^[:alpha:][:punct:][:blank:]{1,20}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe o Sistema";
    } else if (regExp.hasMatch(value)) {
      return "Sistema Inválido";
    }
    return null;
  }

  String _validarLink(String value) {
    String pattern =
        r'^((http)|(https)|(ftp)):\/\/([\- \w]+\.)+\w{2,3}(\/ [%\-\w]+(\.\w{2,})?)*$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe um link";
    } else if (regExp.hasMatch(value)) {
      return "Link Inválida";
    }
    return null;
  }

  String _validarNum(String value) {
    String pattern = r'(^[:digit:]{1,20}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe o N° de Participantes";
    } else if (regExp.hasMatch(value)) {
      return "N° de Participantes Inválido";
    }
    return null;
  }

  // String _validarLink(String value) {
  //   String pattern = r'^((http)|(https)|(ftp)):\/\/([\- \w]+\.)+\w{2,3}(\/ [%\-\w]+(\.\w{2,})?)*$';
  //   RegExp regExp = RegExp(pattern);
  //   if (value.isEmpty) {
  //     return "Informe a Descrição";
  //   } else if (regExp.hasMatch(value)) {
  //     return "Descrição Inválida";
  //   }
  //   return null;
  // }

  String _validarDesc(String value) {
    String pattern = r'(^[:word:][:blank:]{1,20}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Informe a Descrição";
    } else if (regExp.hasMatch(value)) {
      return "Descrição Inválida";
    }
    return null;
  }

  _modalAviso() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Atualizações Futuras"),
            content: Text(
                "Para Trocar sua thumbnail da mesa, será necessário\nesperar pelas proximas\natualizações"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//  Future _getImage() async {
//    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
//    if (image != null) {
//      setState(() {
//        _imageFile = IO.File(image.path);
//      });
//    }
//  }

  // String _convertImageToBase64() {
  //   var _pathImage = _imageFile.path;
  //   final bytes = IO.File("$_pathImage").readAsBytesSync();
  //   String img64 = base64Encode(bytes);
  //   return img64;
  // }

  _sendForm() async {
    print("alou");
    if (_formKey.currentState.validate()) {
      print("alou if");
      //sem erros de validação
      _formKey.currentState.save();

      String name, description, sistema, link;
      // thumbnail;
      int maxofparticipants;

      name = _nomeController.text;
      sistema = _sistemaController.text;
      description = _descController.text;
      maxofparticipants = int.parse(_numController.text);
      link = _linkController.text;
      //thumbnail = _convertImageToBase64();

      // print(thumbnail);

      print("$name, $sistema, $maxofparticipants, $description");

      bool estaCriada = await MesaAPI.createTable(
          name, description, maxofparticipants, sistema, link);

      if (estaCriada != false) {
        print("Mesa criada");
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Criar mesa"),
                content: Text("Mesa Criada!"),
                actions: <Widget>[
                  FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeBar(),
                          ),
                        );
                      }),
                ],
              );
            });
        //foi
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfigMesa(),
          ),
        );*/
      } else {
        print("Erro ao criar mesa");
        //erro
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
