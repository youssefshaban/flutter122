part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}
class Loading extends PostsState{}
class Loaded extends PostsState{}
class Error extends PostsState{}

