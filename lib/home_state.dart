class HomeState {}

class InitialzedHomeState extends HomeState {}

class DataFechtedHomeState extends HomeState {
  final List<String> data;

  DataFechtedHomeState({this.data});

  bool get hasData => data.length > 0;
}

class ErrorHomeState extends HomeState {}

class BusyHomeState extends HomeState {}
