part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  final Movies movies;
  const MoviesLoaded(this.movies);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MoviesLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MoviesError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
