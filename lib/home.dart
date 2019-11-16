import 'package:flutter/material.dart';
import 'package:flutter_go_setstate/home_event.dart';
import 'package:flutter_go_setstate/home_module.dart';
import 'package:flutter_go_setstate/home_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final model = HomeModel();

  @override
  void initState() {
    model.dispatch(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.dispatch(FetchData());
        },
      ),
      backgroundColor: Colors.grey[900],
      body: StreamBuilder(
        stream: model.homeState,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var homeState = snapshot.data;

          if (snapshot.hasError) {
            return _getInformationMessage(snapshot.error);
          } else if (!snapshot.hasData || homeState is BusyHomeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (homeState is DataFechtedHomeState) {
            if (!homeState.hasData) {
              return _getInformationMessage(
                  'No data found for your account. Add something and check back.');
            }
          }

          return ListView.builder(
            itemCount: homeState.data.length,
            itemBuilder: (BuildContext context, int index) =>
                _getListItemUi(index, homeState.data),
          );
        },
      ),
    );
  }

  Widget _getListItemUi(int index, List<String> listItems) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[600],
      ),
      child: Center(
        child: Text(
          listItems[index],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _getInformationMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
