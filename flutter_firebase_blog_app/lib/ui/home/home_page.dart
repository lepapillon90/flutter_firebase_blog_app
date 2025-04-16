import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_page.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLOG')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WritePage();
              },
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('최근글', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return item();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage();
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    child: Image.network(
                      'https://picsum.photos/200/300',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  margin: EdgeInsets.only(right: 100),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today I Learned',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Flutter 그리드뷰를 배웠습니다.Flutter 그리드뷰를 배웠습니다.Flutter 그리드뷰를 배웠습니다.',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2025.04.16 15:57',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
