import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubit/movies_cubit.dart';
import 'package:mobile_app/models/movies.dart';
import 'package:mobile_app/widget/movies_input_fields.dart';

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
            return SingleChildScrollView(
                child: buildMoviesLoaded(context, state.movies));
          } else if (state is MoviesError) {
            return buildError(state.message);
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

  Widget buildError(error) {
    return Center(child: Text(error));
  }

  Widget buildMoviesLoaded(BuildContext context, Movies movies) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 15)),
        Text('Total de Filmes Encontrados: ' + movies.total.toString()),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height - 215,
          child: ListView.builder(
            itemCount: movies.moviesByYear.length,
            itemBuilder: (context, index) {
              var year = movies.moviesByYear.map((e) => e.year).toList();
              var cont = movies.moviesByYear.map((e) => e.movies).toList();
              return ListTile(
                leading: Text(year[index]),
                title: Text('Encontrados:'),
                subtitle: Text(cont[index].toString()),
              );
            },
          ),
        ),
        Divider(),
        MoviesInputFields(),
      ],
    );
  }
}
