import '../model.dart';

abstract class ListState{

}

class ListLoadingState extends ListState{

}

class ErrorState extends ListState{

}

class SuccessDataGet  extends ListState{
  List<Post> posts;
  final bool hasReachedEnd;
  SuccessDataGet({required this.posts, this.hasReachedEnd = false});
}