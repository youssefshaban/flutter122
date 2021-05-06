part of 'get_books_bloc.dart';

@immutable
abstract class GetBooksState {}

class GetBooksInitial extends GetBooksState {

}
class Loading extends GetBooksState {

}
class DataLoadedSuccessfully extends GetBooksState {

}

class Error extends GetBooksState {

}
