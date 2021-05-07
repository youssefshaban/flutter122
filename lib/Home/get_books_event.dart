part of 'get_books_bloc.dart';
@immutable
abstract class GetBooksEvent  {
  }
class getUser extends GetBooksEvent{


}
class userLoaded extends GetBooksEvent{


}

class userError extends GetBooksEvent{
  String ErrorMsg ;
  userError({this.ErrorMsg});
}