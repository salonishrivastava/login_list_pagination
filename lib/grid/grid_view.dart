import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapi/list_data/bloc/list_state.dart';
import '../list_data/bloc/list_bloc.dart';


class ListGRID extends StatefulWidget {
  const ListGRID({super.key});

  @override
  State<ListGRID> createState() => _ListOfGridState();
}

class _ListOfGridState extends State<ListGRID> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body:

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) {
            return ListBloc();
          },
          child:
          BlocBuilder<ListBloc,ListState>(
            builder: (context, state) {
              if(state is ListLoadingState){
                return CircularProgressIndicator();
              }
              if(state is ErrorState){
                return Text("Error ");
              }
              if(state is SuccessDataGet) {
                return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {

                      if (!state.hasReachedEnd &&
                          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {

                        context.read<ListBloc>().apiCalling();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,crossAxisSpacing: 7,mainAxisSpacing: 7),
                      itemCount: state.hasReachedEnd
                          ? state.posts.length
                          : state.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.posts.length) {
                          final post = state.posts[index];
                          return Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                       color: Colors.redAccent,boxShadow: [
                         BoxShadow(blurRadius: 1)
                         ]),


                            child: Column(children: [
                              Text(post.id.toString()),
                              Text(post.title)
                            ],),

                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                );
              }
              return SizedBox();
            },

          ),
        ),
      ),),
    );
  }
}
