// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_graphql/schemas/get_task_schema.dart';
import 'package:flutter_graphql/schemas/url-endpoint.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  dynamic _list = [];

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  // add task method
  void getTask(bool isLocal) async {
    _status = true;
    _response = 'Please wait...';
    notifyListeners();
    
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(
      QueryOptions(
        document: gql(GetTaskSchema.getTaskJson),
        fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = 'No internet connection';
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _list = result.data;
      notifyListeners();
    }
  }

  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;

      print(data['getTodos']);

      return data["getTodos"] ?? {};
    } else {
      return {};
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
