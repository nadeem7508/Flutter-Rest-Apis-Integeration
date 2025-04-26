import 'package:http/http.dart' as http;
import 'package:api_integeration/models/post.dart';

class ApiService {
  Future<List<Post>?> getPosts() async {
    try {
      var client = http.Client();
      var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var json = response.body;
        return postFromJson(json);
      } else {
        print('Failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }
}
