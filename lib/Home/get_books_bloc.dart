import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_books_event.dart';
part 'get_books_state.dart';

class GetBooksBloc extends Bloc<GetBooksEvent, GetBooksState> {
  GetBooksBloc() : super(GetBooksInitial());

  @override
  Stream<GetBooksState> mapEventToState(
    GetBooksEvent event,
  ) async* {
    // ignore: unrelated_type_equality_checks
    if (event is getUser)
      yield Loading();
    if (event is userLoaded)
      yield DataLoadedSuccessfully();
    if (event is userError)
      yield Error();

    }
  @override
  GetBooksState get initialState => GetBooksInitial();
  }



