import 'package:aliman_app/UIScale/sizeconfig.dart';
import 'package:aliman_app/layout/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool visible = false;
  bool isAsync = false;
  DateTime currentBackPressTime;
  bool _obsecureText = true;

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

  String _jkValue;
  String _jk;

  //method Polymorfism
  void radioButtonChanges(String value) {
    setState(() {
      _jkValue = value;
      switch (value) {
        case 'Pria':
          _jk = value;
          break;
        case 'Wanita':
          _jk = value;
          break;
        default:
          _jk = null;
      }
      debugPrint(_jk);
    });
  }

  void toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  var selectedPendidikan;
  final _pendidikan = ["SD", "SMP", "SMA", "SMK", "D3", "S1"];
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login())),
              color: Colors.black,
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: isAsync,
            child: WillPopScope(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Registrasi Pengguna Baru',
                            style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: 22,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                        ),
                        Text(
                          'Nama Lengkap',
                          style: TextStyle(
                              fontFamily: 'NunitoSans-Regular', fontSize: 14),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'nama tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: 'masukkan nama lengkap anda',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'NunitoSans-Regular', fontSize: 14),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'email tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'masukkan email',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                        ),
                        Text(
                          'Kata Sandi',
                          style: TextStyle(
                              fontFamily: 'NunitoSans-Regular', fontSize: 14),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'kata sandi tidak boleh kosong';
                            }
                            return null;
                          },
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                            hintText: 'masukkan kata sandi',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                toggle();
                              },
                              child: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:
                                    _obsecureText ? Colors.grey : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                        ),
                        Text(
                          'Ketik Ulang Kata Sandi',
                          style: TextStyle(
                              fontFamily: 'NunitoSans-Regular', fontSize: 14),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Ulang Kata Sandi tidak boleh kosong';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                            hintText: 'masukkan kata sandi',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                toggle();
                              },
                              child: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:
                                    _obsecureText ? Colors.grey : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: exitApp,
            ),
          ),
          bottomNavigationBar: ButtonTheme(
            minWidth: 400,
            height: 50,
            buttonColor: Colors.pink,
            child: new RaisedButton(
                child: Text('Register',
                    style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        color: Colors.white,
                        fontSize: 16)),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0)),
                onPressed: () {}),
          ),
        ),
      ],
    );
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    bool backButton = currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2);

    if (backButton) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tekan dua kali untuk keluar dari aplikasi',
          textColor: Colors.white);
      return false;
    }
    return true;
  }
}
