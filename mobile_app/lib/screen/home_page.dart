import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubit/movies_cubit.dart';
import 'package:mobile_app/models/movies.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca Filmes'),
      ),
      body: Container(
        child: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
          if (state is MoviesInitial) {
            return buildInitialInput();
          } else if (state is MoviesLoading) {
            return buildLoading();
          } else if (state is MoviesLoaded) {
            return buildMoviesLoaded(state.movies);
          } else {
            return buildInitialInput();
          }
        }),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(child: MoviesInputFields());
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildMoviesLoaded(Movies movies) {
    for (var item in movies.moviesByYear) {
      print(item.year);
    }

    return Center(child: Text('${movies.moviesByYear}'));
  }
}

class MoviesInputFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitMovieName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a movie",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  submitMovieName(BuildContext context, String movieName) {
    final moviesCubit = context.read<MoviesCubit>();
    moviesCubit.getMovies(movieName);
  }
}
