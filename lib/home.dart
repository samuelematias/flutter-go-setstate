import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _pageData;

  bool get _fecthingData => _pageData == null;

  @override
  void initState() {
    _getListData(hasData: false)
        .then((data) => setState(() {
              if (data.length == 0) {
                data.add(
                    'No data found for your account. Add something and check back.');
              }
              _pageData = data;
            }))
        .catchError((error) => setState(() {
              _pageData = [error];
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: _fecthingData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _pageData.length,
              itemBuilder: (BuildContext context, int index) =>
                  _getListItemUi(index),
            ),
    );
  }

  Future<List<String>> _getListData({
    bool hasError = false,
    bool hasData = true,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    if (hasError) {
      return Future.error(
          'An error occurred while fetching the data. Please try agagin later.');
    } else if (!hasData) {
      return List<String>();
    }
    return List<String>.generate(10, (index) => '$index title');
  }

  Widget _getListItemUi(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[600],
      ),
      child: Center(
        child: Text(
          _pageData[index],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
