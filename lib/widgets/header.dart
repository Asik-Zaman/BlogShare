import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? "BlogShare" : titleText,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.white,
        fontFamily: isAppTitle ? "Signatra" : "",
        fontSize: isAppTitle ? 50.0 : 22.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.black12
        : Colors.teal,
    actions: <Widget>[
      IconButton(
          icon: Icon(Theme.of(context).brightness == Brightness.light
              ? Icons.lightbulb_outline
              : Icons.highlight),
          onPressed: () {
            DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light);
          })
    ],
  );
}
