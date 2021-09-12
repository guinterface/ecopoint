import 'package:ecpoint/CadLog/CriarProposta.dart';
import 'package:ecpoint/CadLog/Login.dart';
import 'package:ecpoint/CadLog/Novo.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.white
  ),
  debugShowCheckedModeBanner: false,
  home: Login(),


));