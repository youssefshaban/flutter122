import 'dart:async';

import 'package:Django/Home/model/PostModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if(event is getPosts)
      yield Loading();
    if(event is successful) {
      yield Loaded();
    }
    if(event is Fail)
      yield Error();

  }
  // @override
  // PostsInitial get initialState => PostsInitial();
}
