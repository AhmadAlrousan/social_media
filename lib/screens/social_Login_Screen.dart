import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/SocialLoginState.dart';
import '../bloc/socialLoginCubit.dart';
import '../component/cons.dart';
import '../models/social_user_model.dart';
import '../shared/cache_Helper.dart';
import 'Layout_Screen.dart';
import 'SocialRegisterScreen.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var fromKey = GlobalKey<FormState>();
  var passwordC = TextEditingController();
  var emailC = TextEditingController();
  bool isv = true;
  bool isv2 = false;
  SocialUserModel? model;

  @override

  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),

      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
          listener: (context, state){
            if(state is SocialLoginSuccessState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SocialLayout();
              }));
            }
            if(state is SocialLoginSuccessState){
              CacheHelper.saveData(
                  key: 'uID',
                  value: state.uId)
                  .then((value) {
              //  uId=model!.uId;

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return SocialLayout();}));
              });
            }
          },
        builder: (context, state){
            return   Scaffold(
              //       Login page created
              appBar: AppBar(
                title: Center(child: Text("login" ,style: TextStyle(color: Colors.blue))),
                backgroundColor: Colors.white,
              ),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    // SingleChildScrollView protects against overflow in the app
                    child: Form(
                      key: fromKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextFormField(context, "email"),
                          // Here call method to create a TextFormField
                          SizedBox(
                            height: 10,
                          ),
                          buildTextFormField(context, "password"),

                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            // When the button is pressed, the Loading sign appears
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) =>
                          ElevatedButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailC.text,
                                    password: passwordC.text);
                            //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>SocialLayout()));
                              }
                            },
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              fixedSize: Size(double.maxFinite, 50),
                            ),

                          ),
                            fallback: (context) => CircularProgressIndicator(),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("dont have an account? "),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return SocialRegisterScreen();

                                        }));
                                  },
                                  child: Text("Register Now"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },

      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context, String name) {
    return TextFormField(
      controller: name == "password" ? passwordC : emailC,
      // Here each TextField controller gives its own
      decoration: InputDecoration(
          label: Text(name),
          prefixIcon: Icon(name == "password" ? Icons.lock : Icons.email),
          // Here the icon changes according to the name of the TextField

          suffixIcon: name == "password"
              ? IconButton(
            onPressed: () {
              setState(() {
                isv = !isv;
              });
            },
            icon: Icon(isv ? Icons.visibility : Icons.visibility_off),
          )
              : null,
          // Change the icon according to the show of the Password
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.8),
          )),
      obscureText: name == "password" ? isv : isv2,
      // Here to show or hide the password
      onFieldSubmitted: (value){
        // if (fromKey.currentState!.validate()) {
        //   ShopLoginCubit.get(context).userLogin(
        //       email: emailC.text,
        //       password: passwordC.text);
        // }
      },
      validator: (val) {
        // validator Shows some notifications under the TextFormField
        if (val!.isEmpty) {
          // Here, if the TextFormField is empty, it gives an alert
          return "$name is Empty";
        }
      },
    );
  }

}

