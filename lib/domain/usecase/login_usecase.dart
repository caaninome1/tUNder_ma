import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:stores/data/network/failure.dart';
import 'package:stores/data/network/requests.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/repository/GraphQLGateway.dart';

class LoginUseCase {
  LoginUseCase();

  final loginMutation = """
        mutation login(\$user: NewUser!) {
          login(user: \$user) {
            token,
            userID
          }
        }
    """;

  Future<Either<Failure, Token>> execute(
    LoginUseCaseInput input,
  ) async {
    QueryResult ans = await GraphQLGateway.getClient().mutate(MutationOptions(
      document: gql(loginMutation),
      variables: <String, dynamic>{
        'user': {
          "email": input.email,
          "password": input.password,
        },
      },
    ));
    print(ans.data);
    return Either.cond(
        () => !ans.hasException,
        () => Token(ans.data?["login"]["token"], ans.data?["login"]["userID"]),
        () => Failure(1, "Credenciales incorrectas"));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
