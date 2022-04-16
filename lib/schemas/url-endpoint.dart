import 'package:flutter/material.dart';
import 'package:flutter_graphql/utils/url.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink(endPointUrl),
      cache: GraphQLCache(store: HiveStore()),
    ));

    return _client;
  }
}
