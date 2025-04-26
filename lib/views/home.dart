import 'package:api_integeration/models/post.dart';
import 'package:api_integeration/services/api_service.dart';
import 'package:api_integeration/views/CategoryTag.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  //variables
  List<Post>? posts;
  var isLoaded = false;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    getData();
  }
//getdata
  getData() async {
    posts = await ApiService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
//filter the categores
  List<Post> get filteredPosts {
    if (selectedCategory == 'All') return posts ?? [];
    return posts
            ?.where(
              (post) => post.title.toLowerCase().contains(
                selectedCategory.toLowerCase(),
              ),
            )
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'API Integeration',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.amber,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Latest Blogs",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    ['All', 'sunt', 'qui', 'ea', 'molestiae'].map((category) {
                      return CategoryTag(
                        title: category,
                        isSelected: selectedCategory == category,
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Visibility(
                visible: isLoaded,
                //listview builder
                child: ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(width: 16),
                          //title and body
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredPosts[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  posts![index].body ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                replacement: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
