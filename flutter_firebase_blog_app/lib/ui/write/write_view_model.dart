
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// 1. 상태 클래스 만들기
class WriteState {
  bool isWriting;
  String? imageUrl;
  WriteState(this.isWriting, this.imageUrl);
}

// 2. 뷰모델 만들기
class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  @override
  WriteState build(Post? arg) {
    return WriteState(false, arg?.imageUrl);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {

    if(state.imageUrl == null) {
      return false;
    }

    final postRepository = PostRepository();

    state = WriteState(true, state.imageUrl);
    if (arg == null) {
      // post 객체가 null이면 : 새로작성
      final result = await postRepository.insert(
        title: title,
        content: content,
        writer: writer,
        imageUrl: state.imageUrl!,
      );
      state = WriteState(false, state.imageUrl);
      await Future.delayed(Duration(milliseconds: 500));
      return result;
    } else {
      //null이 아니면 : 수정
      final result = await postRepository.update(
        id: arg!.id,
        writer: writer,
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);
      return result;
    }
  }

  void uplodeImage(XFile xFile) async {
    try {
      //Firebase Storag사용법
      // 1. Firebase Storage에 객체 가지고 오기
      final storage = FirebaseStorage.instance;
      // 2. Firebase Storage 참조 만들기
      Reference ref = storage.ref();
      // 3. 파일 참조 만들기
      Reference fileRef = ref.child(
        '${DateTime.now().millisecondsSinceEpoch}_${xFile.name}',
      );
      // 4. 쓰기
      await fileRef.putFile(File(xFile.path));
      // 5. 파일에 접근 할 수있는 URL 받기
      String imageUrl = await fileRef.getDownloadURL();
      state = WriteState(state.isWriting, imageUrl);
    } catch (e) {
      print(e);
    }
  }
}

// 3. 뷰모델 관리자 만들기
final writeViewModelProvider = NotifierProvider.autoDispose
    .family<WriteViewModel, WriteState, Post?>(() {
      return WriteViewModel();
    });
