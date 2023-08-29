import 'package:flutter/material.dart';
import 'package:test_app/api/api.dart';

import 'package:test_app/view/info_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final APIservice apIservice = APIservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('បញ្ចីតំបន់ទេសចរណ៍')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FutureBuilder(
                future: apIservice.fetchSocials(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                     //   final post = posts[index];
                        return Column(children: [
                          Stack(
                            children: [
                              Container(
                                height: 130,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      height: double.infinity,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          // child: Text(
                                          //   post.title!,
                                          //   overflow: TextOverflow.clip,
                                          // ),
                                        ),
                                        //Text('descriptions'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: Icon(Icons.more_vert_outlined)))
                            ],
                          ),
                        ]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoScreen())),
                child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
