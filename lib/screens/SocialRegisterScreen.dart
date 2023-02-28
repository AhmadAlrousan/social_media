import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/cons.dart';

import '../bloc/SocialRegisterCubit.dart';
import '../bloc/SocialRegisterState.dart';
import '../models/social_user_model.dart';
import 'Layout_Screen.dart';
import 'social_Login_Screen.dart';

class SocialRegisterScreen extends StatefulWidget {
  const SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SocialRegisterScreen> createState() => _SocialRegisterScreen();
}

class _SocialRegisterScreen extends State<SocialRegisterScreen> {
  var fromKey = GlobalKey<FormState>();
  var nameC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();
  var passwordC = TextEditingController();

  bool isv = true;
  bool isv2 = false;

  SocialUserModel? model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
        if(state is SocialCreateUserSuccessState)
          {
          //  uId=model!.uId;
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SocialLayout();
            }));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                  child:
                      Text("Register", style: TextStyle(color: Colors.blue))),
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
                          "Register",
                          style: TextStyle(fontSize: 30, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFormField(context, "email"),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "name"),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "password"),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField(context, "phone"),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          // When the button is pressed, the Loading sign appears
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) =>

                              ElevatedButton(
                            onPressed: () {
                              print(nameC.text);
                              if (fromKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    email: emailC.text,
                                    password: passwordC.text,
                                    name: nameC.text,
                                    phone: phoneC.text
                                );
                              }
                            },
                            child: Text("Register"),
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
                            Text("do have an account? "),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return SocialLoginScreen();
                                  }));
                                },
                                child: Text("Login Now"))
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
      controller: name == "name"
          ? nameC
          : name == "email"
              ? emailC
              : name == "password"
                  ? passwordC
                  : phoneC,
      decoration: InputDecoration(
          label: Text(name),
          prefixIcon: Icon(name == "password"
              ? Icons.lock
              : name == "name"
                  ? Icons.drive_file_rename_outline
                  : name == 'email'
                      ? Icons.email
                      : Icons.phone),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.8),
          )),
      obscureText: name == "password" ? isv : isv2,

      // onFieldSubmitted: (value) {
      //   if (fromKey.currentState!.validate()) {
      //     SocialRegisterCubit.get(context).userRegister(
      //       email: emailC.text,
      //       password: passwordC.text,
      //       name: nameC.text,
      //       phone: phoneC.text
      //     );
      //   }
      // },
      validator: (val) {
        if (val!.isEmpty) {
          return "$name is Empty";
        }
      },
    );
  }
}
