import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});
}

Future getPosts() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  var response = await http.get(Uri.parse(url));
  List<dynamic> data = jsonDecode(response.body);

  List<Post> arr = [];
  for (int i = 0; i < data.length; i++) {
    var item = data[i];
    arr.add(Post(
      id: item["id"],
      userId: item["userId"],
      title: item["title"],
      body: item["body"],
    ));
  }
  return arr;
}
