// 1. 상태 클래스 만들기
//post 객체 사용할거라 만들지 않음

// 2. 뷰모델 만들기
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  @override
  Post build(Post arg) {
    listenStream();
    // arg는 Post 객체
    // arg는 부모에서 넘겨준 Post 객체
    // 부모에서 넘겨준 Post 객체를 사용하여 초기화
    // arg는 부모에서 넘겨준 Post 객체를 사용하여 초기화
    // 부모에서 넘겨준 Post 객체를 사용하여 초기화
    return arg;
  }

  final postRepository = PostRepository();

  Future<bool> deletePost() async {
    return await postRepository.delete(arg.id);
  }

  void listenStream() {
    //
    final stream = postRepository.postStream(arg.id);
    final streamSub = stream.listen((data){
      if (data != null) {
        state = data;
      }
    });

    ref.onDispose((){
      streamSub.cancel();
      });
  }
}

// 3. 뷰모델 관리자 만들기
final detailViewModelProvider = NotifierProvider.autoDispose
    .family<DetailViewModel, Post, Post>(() {
      return DetailViewModel();
    });
