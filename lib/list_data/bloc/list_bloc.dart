import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapi/list_data/bloc/list_event.dart';
import 'package:loginapi/list_data/bloc/list_state.dart';
import 'package:http/http.dart' as http;

import '../model.dart';
class ListBloc extends Bloc<ListEvent,ListState>{
  int page = 1;
  final int limit = 10;
  List<Post> allPosts = [];
  bool loadMore=false;

  ListBloc(): super(ListLoadingState()){
    apiCalling();
  }


  Future<void> apiCalling() async {
    print("<<object>>   apiCalling....");
 //   if (state is ListLoadingState) return;
//https://jsonplaceholder.typicode.com/posts?_page=1&_limit=10
    if(!loadMore) {
      loadMore = true;
      print("<<object>>   apiCalling....1");
String
//baseurl="https://api.thecatapi.com/v1/breeds?limit=$limit&page=$page";
     baseurl= 'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit';
      final response = await http.get(
        Uri.parse(baseurl
          ),
        headers: {
          "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
          "Accept": "application/json, text/javascript, */*; q=0.01",
          "Accept-Language": "en-US,en;q=0.9",
        },
      );
      print("<<object>>   apiCalling....2");
      print("<<object>>   apiCalling....2 ${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        print("${jsonDecode(response.body)}");


        List<Post> posts = (jsonDecode(response.body) as List)
            .map((data) {
          return Post.fromJson(data);
        })
            .toList();
        if (posts.isEmpty) {
          emit(SuccessDataGet(posts: allPosts, hasReachedEnd: true));
        } else {
          print(posts.first.title);
          allPosts.addAll(posts);
          loadMore = false;
          page++;
          emit(SuccessDataGet(posts: allPosts, hasReachedEnd: false));
        }

        // returns List of maps
      } else {
        emit(ErrorState());
        throw Exception('Failed to load posts');
      }
    }

}

}