import 'package:blogshare/pages/home.dart';
import 'package:blogshare/widgets/post.dart';
import 'package:blogshare/widgets/progress.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;

  PostScreen({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef
          .document(userId)
          .collection('userPosts')
          .document(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black12
                : Colors.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black12
                  : Colors.teal,
              centerTitle: true,
              title: Text(
                post.description,
                style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 35.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.white,
                ),
              ),
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
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
