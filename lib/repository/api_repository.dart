import '../models/users_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<UserModel> fetchUserList() {
    return _provider.fetchUserList();
  }
}

class NetworkError extends Error {}