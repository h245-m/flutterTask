
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/setting_screen.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void login(String email , password) async {
    try {
      Response response = await post(
          Uri.parse('https://my-safe-space.alacrity.technology/api/auth/login'),
          body: {
            'email': email,
            'password': password
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login Successfully');
      }
      else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool check = false;
  bool isPasswordObscure = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>()  ;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey ,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffF5F5FA),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 141),
                    const Text("Welcome Back!",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff283335),

                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text("Login to continue Radio App",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff283335),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Container(
                      margin: const EdgeInsets.all(5),

                      child: TextFormField(
                          decoration: const InputDecoration (
                            hintText: ' Email Address',
                            prefixIcon: Icon(
                                Icons.email
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xff7477A0),
                            ),
                              border: OutlineInputBorder(
                          ),
                          ),
                          controller: emailController,

                          validator: (String? text){
                            if(text!.isEmpty){
                              return 'Your Email Cannot be empty ';
                            }
                            else if(!text.contains('@') || !text.contains('.') ){
                              return 'Your email is incorrect!';
                            }
                          }
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),

                      child: TextFormField(
                        obscureText:isPasswordObscure ,
                        decoration: InputDecoration (
                          hintText: ' Password',

                          prefixIcon: const Icon(
                              Icons.lock
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPasswordObscure = !isPasswordObscure;
                              });

                            },
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff7477A0),
                          ) ,
                          border: const OutlineInputBorder(
                          ),

                        ),
                        controller: passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (val){
                            setState((){
                              check= val!;
                            });
                          },
                          checkColor: Colors.red,
                          activeColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        const Text("Remember me",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff000000),

                            )),
                        const SizedBox(
                          width: 120,
                        ),
                        TextButton(
                            onPressed: () {},

                            child: const Text("Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color:  Color(0xff5C5E6F),
                              ),)
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 13,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7A5FC9),
                          shadowColor: Colors.grey.withOpacity(0.6),
                          minimumSize: const Size(368, 56),
                      ),
                      onPressed: () {
                        login(emailController.text.toString(), passwordController.text.toString());
                        formKey.currentState!.validate();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SettingPage() ));

                      },
                      child: const Text('Log In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('OR',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff000000) ,
                            fontWeight: FontWeight.w500,
                          ),),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),

                    ElevatedButton.icon(onPressed: () async {
                      await signInWithGoogle();

                      setState(() {

                      });
                    },
                        style: ElevatedButton.styleFrom(
                         shadowColor:Colors.grey.withOpacity(0.6),
                          backgroundColor: const Color(0xffFFFFFF),
                          minimumSize: const Size(368, 56),

                        ),
                        icon:  Image.asset( //
                          'assets/icons/google-icon.png',
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                        label: const Text("Continue With Google",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000)
                          ),)
                    ),


                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey,
                          backgroundColor: const Color(0xff000000),
                          minimumSize: const Size(368, 56),
                        ),
                        icon: const Icon(Icons.apple, size: 40,),
                        label: const Text("Sign In With Apple ID",
                          style: TextStyle(
                              fontSize: 14,
                              color:Color(0xffFFFFFF)
                          ),)
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(onPressed: (){
                    },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey,
                          backgroundColor: const Color(0xff39579A),
                          minimumSize: const Size(368, 56),
                        ),
                        icon: const Icon(Icons.facebook, size: 40),
                        label: const Text("Continue With Facebook",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFFFFF)
                          ),)
                    ),
                    const SizedBox(
                      height: 46,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color:  Color(0xff6D4DC6),
                              ),)
                        ),
                      ],
                    ),
                    const SizedBox(height:32),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("By signing up you indicate that you have read and agreed to the Patch ",
                            style: TextStyle(
                              fontSize: 9,
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Terms of Service",
                              style: TextStyle(
                                fontSize: 9,
                                color:  Color(0xff6D4DC6),
                              ),)
                        ),
                      ],
                    ),







                  ],
                ),
              ),
            ),
          ),
        )

    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
