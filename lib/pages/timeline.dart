import 'package:blogshare/pages/developer.dart';
import 'package:blogshare/pages/profile.dart';
import 'package:blogshare/pages/search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blogshare/models/user.dart';
import 'package:blogshare/pages/home.dart';
import 'package:blogshare/widgets/header.dart';
import 'package:blogshare/widgets/post.dart';
import 'package:blogshare/widgets/progress.dart';

final userRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User currentUser;
  Timeline({this.currentUser});
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post> posts;
  List<String> followingList = [];
  @override
  void initState() {
    super.initState();
    getTimeLine();
    getFollowing();
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  getTimeLine() async {
    QuerySnapshot snapshot = await timelineRef
        .document(widget.currentUser.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  buildTimeLine() {
    if (posts == null) {
      return circularProgress();
    } else if (posts.isEmpty) {
      return buildUserToFollow();
    }
    return ListView(children: posts);
  }

  buildUserToFollow() {
    return StreamBuilder(
      stream:
          userRef.orderBy('timestamp', descending: true).limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          final bool isFollowingUser = followingList.contains(user.id);
          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(user);
            userResults.add(userResult);
          }
        });
        return Container(
          color: Theme.of(context).accentColor.withOpacity(0.2),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Users to Follow',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
              Column(
                children: userResults,
              )
            ],
          ),
        );
      },
    );
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  profile() {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  profileId: widget.currentUser.id,
                )));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text(
                widget.currentUser.displayName,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(widget.currentUser.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: widget.currentUser.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () => profile(),
              trailing: Icon(Icons.account_circle),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Developer"),
              trailing: Icon(Icons.developer_mode),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DeveloperScreen()));
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () => logout(),
              trailing: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getTimeLine(),
        child: buildTimeLine(),
      ),
    );
  }
}
