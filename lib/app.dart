import 'package:refresh/model.dart';
import 'package:refresh/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post>? post;
  bool loading = true;
  bool _showBackToTopButton = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller.addListener(() {
      setState(() {
        if (_controller.offset >= 400) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose the controller
    super.dispose();
  }

  void fetchData() async {
    setState(() {
      loading = true;
    });
    post = await getPosts();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refresh"),
        backgroundColor: Colors.pink,
      ),
      body: (!loading)
          ? RefreshIndicator(
              onRefresh: () async {
                post = await getPosts();
                setState(() {});
              },
              child: Scrollbar(
                thickness: 5,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: post?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('Id: ${post![index].id}'),
                        title: Text(post![index].title),
                        subtitle: Text('User id ${post![index].userId}'),
                        onTap: () {},
                      );
                    }),
              ),
            )
          : Center(child: Loading()),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: () {
                _controller.animateTo(0,
                    duration: Duration(seconds: 1), curve: Curves.linear);
              },
              child: Icon(Icons.arrow_upward),
            ),
    );
  }
}
