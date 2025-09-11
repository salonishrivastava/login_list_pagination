import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapi/list_data/list_of_data.dart';
import 'package:loginapi/local_db/list_of_students.dart';
import 'package:loginapi/login/bloc/login_event.dart';
import 'package:loginapi/login/bloc/login_state.dart';
import '../dismissble_list_view/dissmissble_onleftswipe_list.dart';
import '../grid/grid_view.dart';
import '../random_color_list.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailEditingController= TextEditingController();
  TextEditingController passEditingController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: BlocProvider(
            create: (context) {
              return LoginBloc();
            },
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white,),

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Text('Login Screen'),
                    SizedBox(height: 12,),
                    TextField(controller: emailEditingController,
                      decoration: InputDecoration( hintText: "email enter here"),),
                    TextField(controller: passEditingController,
                        decoration :InputDecoration(hintText: "passwords here")),
                    SizedBox(height: 12,),
                    BlocListener<LoginBloc,LoginState>(listener: (context, state) {
                      if(state is LoginSuccess){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                           return ListOfData() ;
                         },));
                      }
                    },child: Container(),),
                    BlocBuilder<LoginBloc,LoginState>(
                      builder: (context, state) {
                        print("print Loading State ");
                        if(state is LoadingState){
                          print("print Loading State1");
                          return CircularProgressIndicator();
                        }

                        return     InkResponse(onTap: () {
                        if(emailEditingController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email required")));
                        }else{
                        if(passEditingController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password required")));

                        }else{
                          BlocProvider.of<LoginBloc>(context).add(OnButtonClickEvent());
                        }
                        }



                        },
                        child: Container(width: 200,height: 55,
                        alignment: Alignment.center,
                        child: Text("Login (after api fetch page wise"
                            ")",
                          style: TextStyle(color: Colors.white,
                              fontSize: 14,
                              fontWeight:FontWeight.w600),),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent),),
                        );
                      },

                    ),
                    SizedBox(height: 12,),
                InkResponse(onTap: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const DismissbleList() ;
                      },));


                },
                  child: Container(
                    width: 200,height: 55,
                    alignment: Alignment.center,
                    child: Text("Dismissble List show",
                      style: TextStyle(color: Colors.white,
                          fontSize: 14,
                          fontWeight:FontWeight.w600),),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.redAccent),),
                ),


                    SizedBox(height: 12,),
                    InkResponse(onTap: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const ListOfStudents() ;
                          },));


                    },
                      child: Container(width: 200,height: 55,
                        alignment: Alignment.center,
                        child: Text("Database list add delete",
                          style: TextStyle(color: Colors.white,
                              fontSize: 14,
                              fontWeight:FontWeight.w600),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent),),
                    ),

                    SizedBox(height: 12,),
                    InkResponse(onTap: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const AnimatedListExample() ;
                          },));


                    },
                      child: Container(width: 200,height: 55,
                        alignment: Alignment.center,
                        child: Text("Animated List Example",
                          style: TextStyle(color: Colors.white,
                              fontSize: 14,
                              fontWeight:FontWeight.w600),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent),),
                    )
,

                    SizedBox(height: 12,),
                    InkResponse(onTap: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const ListGRID() ;
                          },));


                    },
                      child: Container(width: 200,height: 55,
                        alignment: Alignment.center,
                        child: Text("Grid List",
                          style: TextStyle(color: Colors.white,
                              fontSize: 14,
                              fontWeight:FontWeight.w600),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent),),
                    )

              ],)


                ,),
            ),
          )

    ));
  }
}
