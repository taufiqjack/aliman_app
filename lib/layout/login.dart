import 'package:aliman_app/UIScale/sizeconfig.dart';
import 'package:aliman_app/layout/menu.dart';
import 'package:aliman_app/layout/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _obsecureText = true;
  bool isHidden = true;
  bool isAsync = false;
  DateTime currentBackPressTime;
  bool _isEnabled = true;
  final focus = FocusNode();
  var value;
  var usernameAPI;
  var namaAPI;
  var id;
  var level;
  String email = '';

  void toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Future<bool> exitApp() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Keluar"),
          content: Text("Apa anda yakin ingin keluar dari aplikasi ini?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Ya"),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isAsync,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.5,
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.green[300],
                      Colors.green,
                      Colors.green[600]
                    ])),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40 / 1.2, vertical: 100 / 1.5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Image.asset(
                          'assets/images/alimanboga.png',
                          height: 200,
                          width: 300,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        Text(
                          'Selamat Datang di Aplikasi Pemesan Aliman Boga',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(color: Colors.blueGrey[300]),
                              height: 60,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(focus);
                                },
                                //controller: control.emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'masukkan email anda',
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.white),
                                ),
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'email tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            Text(
                              'Password',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(color: Colors.blueGrey[300]),
                              height: 60,
                              child: TextFormField(
                                focusNode: focus,
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      toggle();
                                    },
                                    child: Icon(
                                      _obsecureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _obsecureText
                                          ? Colors.white
                                          : Colors.greenAccent,
                                    ),
                                  ),
                                  enabled: _isEnabled,
                                  isDense: true,
                                  hintText: 'masukkan password anda',
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.white),
                                ),
                                obscureText: _obsecureText,
                                //controller: control.passwordController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'kata sandi tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  'Lupa Password ?',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            !isLoading
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 30),
                                    width: double.infinity,
                                    child: RaisedButton(
                                      elevation: 5,
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Menu()));
                                      },
                                      color: Colors.white,
                                      child: Text(
                                        'Login',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                  ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '- belum punya akun? -',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: FlatButton(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Text(
                                    'Daftar',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Register()));
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          onWillPop: exitApp,
        ),
      ),
    );
  }
}
