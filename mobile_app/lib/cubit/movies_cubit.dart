import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/models/movies.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());

  Future<void> getMovies(String movieName) async {
    var url = 'http://192.168.53.106:55555/?name=$movieName';
    try {
      emit(MoviesLoading());
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      final _movies = Movies.fromJson(jsonResponse as Map);
      emit(MoviesLoaded(_movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
