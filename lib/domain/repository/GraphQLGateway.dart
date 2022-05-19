import 'package:graphql/client.dart';

class GraphQLGateway {
  static GraphQLClient getClient() {
    return GraphQLClient(
      link: HttpLink(
        'https://api-gateway-y6bebo7xta-uc.a.run.app',
      ),
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    );
  }
}
