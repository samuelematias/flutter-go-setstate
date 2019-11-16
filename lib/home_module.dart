import 'dart:async';
import 'home_state.dart';

class HomeModel {
  final StreamController<HomeState> _stateController =
      StreamController<HomeState>();

  List<String> _listItems;

  //Stream that broadcasts the home state
  Stream<HomeState> get homeState => _stateController.stream;

  Future getListData({
    bool hasError = false,
    bool hasData = true,
  }) async {
    _stateController.add(BusyHomeState());
    await Future.delayed(Duration(seconds: 2));
    if (hasError) {
      return _stateController.addError(
          'An error occurred while fetching the data. Please try agagin later.');
    } else if (!hasData) {
      return _stateController.add(DataFechtedHomeState(data: List<String>()));
    }
    _listItems = List<String>.generate(10, (index) => '$index title');
    _stateController.add(DataFechtedHomeState(data: _listItems));
  }
}
