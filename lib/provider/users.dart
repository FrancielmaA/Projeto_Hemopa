import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hemopa_app/data/dummy_Users.dart';
import 'package:hemopa_app/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  //static const _baseUrl = 'https://hemopa-app-default-rtdb.firebaseio.com/';
  static const _baseUrl = 'https://hemopa-app1-default-rtdb.firebaseio.com/';
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

//verifica se o usuario existe
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }
// Aletra cadastro
    if (user.cpf != null &&
        // ignore: prefer_is_not_empty
        !user.cpf.trim().isEmpty &&
        _items.containsKey(user.cpf)) {
      _items.update(
        user.cpf,
        // ignore: missing_required_param
        (_) => User(
          //id: user.id,
          cpf: user.cpf,
          nome: user.nome,
          email: user.email,
          telefone: user.telefone,
          endereco: user.endereco,
          senha: user.senha,
          datanasc: user.datanasc,
          rg: user.rg,
          cep: user.cep,
          cidade: user.cidade,
          uf: user.uf,
          numero: user.numero,
          bairro: user.bairro,
          sexo: user.sexo,
          celular: user.celular,
        ),
      );
    } else {
      final response = await http.post(
        "$_baseUrl/user.json",
        body: json.encode({
          'cpf': user.cpf,
          'nome': user.nome,
          'email': user.email,
          //'id': user.id,
          'telefone': user.telefone,
          'endereco': user.endereco,
          'senha': user.senha,
          'datanasc': user.datanasc,
          'rg': user.rg,
          'cep': user.cep,
          'cidade': user.cidade,
          'uf': user.uf,
          'numero': user.numero,
          'bairro': user.bairro,
          'sexo': user.sexo,
          'celular': user.celular,
        }),
      );

      final id = json.decode(response.body)['nome'];
      // adicionar
      _items.putIfAbsent(
        id,
        // ignore: missing_required_param
        () => User(
          //id: id,
          cpf: user.cpf,
          nome: user.nome,
          email: user.email,
          telefone: user.telefone,
          endereco: user.endereco,
          senha: user.senha,
          datanasc: user.datanasc,
          rg: user.rg,
          cep: user.cep,
          cidade: user.cidade,
          uf: user.uf,
          numero: user.numero,
          bairro: user.bairro,
          sexo: user.sexo,
          celular: user.celular,

        ),
      );
    }
    // ou alterar

    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.cpf != null) {
      _items.remove(user.cpf);
      notifyListeners();
    }
  }
}
