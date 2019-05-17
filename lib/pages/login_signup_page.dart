import 'package:flutter/material.dart';
import 'package:login_fb/services/authentication.dart';
import 'package:login_fb/widgets/login_signup_widgets.dart';
import 'package:login_fb/enum/login_signup_enum.dart';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final Auth auth;
  final VoidCallback onSignedIn;

  @override 
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: _showBody(),),
        ],
      ),
    );
  }

  Widget _showBody() {
    return new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            LoginSignUpWidgets.showLogo(),
            LoginSignUpWidgets.showEmailInput(email: _email),
            LoginSignUpWidgets.showPasswordInput(password: _password),
            LoginSignUpWidgets.showPrimaryButton(formMode: _formMode, validateAndSubmit: _validateAndSubmit, isLoading: _isLoading),
            LoginSignUpWidgets.showSecondaryButton(formMode: _formMode, changeFormToLogin: _changeFormToLogin, changeFormToSignUp: _changeFormToSignUp),
            LoginSignUpWidgets.showErrorMessage(errorMessage: _errorMessage),
          ],
        ),
      );
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState( () {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState( () {
      _formMode = FormMode.LOGIN;
    });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;    
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if(_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId ');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up: $userId');
        }
        if (userId != null && userId.length > 0) {
          widget.onSignedIn();
        }
      } catch (error) {
        print('Error Sign In/Up: $error');
        setState(() {
          _isLoading = false;
          if(_isIos) {
            _errorMessage = error.details;
          } else {
            _errorMessage = error.toString();
            // _errorMessage = error.message ? error.message : error.toString();
          }
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

}