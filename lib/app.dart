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

  @override
  void initState() {
    super.initState();
    fetchData();
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
              child: ListView.builder(
                  itemCount: post?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('Id: ${post![index].id}'),
                      title: Text(post![index].title),
                      subtitle: Text('User id ${post![index].userId}'),
                      onTap: () {},
                    );
                  }),
            )
          : Center(child: Loading()),
    );
  }
}
