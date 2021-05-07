part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}
class getPosts extends PostsEvent{}
class successful extends PostsEvent{}
class Fail extends PostsEvent{}

