import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : Colors.teal,
        centerTitle: true,
        title: Text(
          'Developed By',
          style: TextStyle(
            fontFamily: "Signatra",
            fontSize: 35.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 12),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Md.Asikuzzaman',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '16204060',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'asik.zaman.bauetbd@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'BAUET',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Nowrin Jahan Joyee',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '16204022',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'njjoyee19980@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'BAUET',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Md.Barhanul Karim',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '16204062',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'barhanul62@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'BAUET',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Shila Rahman',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '16204034',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'shilarahman5659@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'BAUET',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
