import 'package:flutter/cupertino.dart';
import 'package:instagram_ghost/service/api_service.dart';

class ApiProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  String? ppLink;
  String? name;
  bool isLoading = false;

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> fetch({required String userName}) async {
    _changeLoading();
    ppLink = (await apiService.fetchProfilPage(userName: userName)).toString();
    name = userName;
    notifyListeners();
    _changeLoading();
  }
}
