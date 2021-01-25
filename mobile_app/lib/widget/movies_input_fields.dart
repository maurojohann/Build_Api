import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubit/movies_cubit.dart';

class MoviesInputFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          onSubmitted: (value) => submitMovieName(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Busque um Filme",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      );
    });
  }

  submitMovieName(BuildContext context, String movieName) {
    final moviesCubit = context.read<MoviesCubit>();
    moviesCubit.getMovies(movieName);
  }
}
