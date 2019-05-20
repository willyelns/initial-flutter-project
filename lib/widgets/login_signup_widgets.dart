import 'package:flutter/material.dart';
import 'package:login_fb/enum/login_signup_enum.dart';

class LoginSignUpWidgets {
  static Widget showCircularProgress({@required bool isLoading}) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(height: 0.0, width: 0.0);
  }

  static Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logo-mana.png'),
        ),
      ),
    );
  }

  static Widget showEmailInput({@required String email}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          // hintText: 'Email',
          labelText: 'Email',
          // border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          // border: OutlineInputBorder(),
          // focusedBorder: OutlineInputBorder(),
          // icon: new Icon(Icons.mail, color: Colors.grey)
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => email = value,
      ),
    );
  }

  static Widget showPasswordInput({@required String password}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.grey[300],
          // icon: new Icon(Icons.lock, color: Colors.grey)
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => password = value,
      ),
    );
  }

  static Widget showPrimaryButton(
      {@required FormMode formMode,
      @required Function validateAndSubmit,
      @required bool isLoading}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 45.0, 24.0, 0.0),
      child: OutlineButton(
        highlightedBorderColor: Colors.pink[300],
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16.0)), // Adding Border to any widget
        // minWidth: 180.0,
        // height: 32.0,
        color: Colors.pink,
        child: isLoading
            ? _showLoading()
            : _primaryButtonLabel(formMode: formMode),
        onPressed: validateAndSubmit,
      ),
    );
  }

  // static Widget showPrimaryButton(
  //     {@required FormMode formMode,
  //     @required Function validateAndSubmit,
  //     @required bool isLoading}) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(24.0, 45.0, 24.0, 0.0),
  //     child: MaterialButton(
  //       elevation: 5.0,
  //       shape: RoundedRectangleBorder(
  //           borderRadius:
  //               BorderRadius.circular(16.0)), // Adding Border to any widget
  //       minWidth: 180.0,
  //       height: 32.0,
  //       color: Colors.pink,
  //       child: isLoading
  //           ? _showLoading()
  //           : _primaryButtonLabel(formMode: formMode),
  //       onPressed: validateAndSubmit,
  //     ),
  //   );
  // }

  static Widget _showLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
    );
  }

  static Widget showSecondaryButton(
      {@required FormMode formMode,
      @required Function changeFormToSignUp,
      @required Function changeFormToLogin}) {
    return new Padding(
      padding: EdgeInsets.only(top: 48.0),
      child: FlatButton(
        child: _secondaryButtonLabel(formMode: formMode),
        onPressed:
            formMode == FormMode.LOGIN ? changeFormToSignUp : changeFormToLogin,
      ),
    );
  }

  static Widget showErrorMessage({@required String errorMessage}) {
    if (errorMessage != null && errorMessage.length > 0) {
      return new Text(errorMessage,
          style: TextStyle(
              fontSize: 13.0,
              color: Colors.red,
              height: 1.0,
              fontWeight: FontWeight.w300));
    } else {
      return new Container(height: 0.0);
    }
  }

  static Widget _primaryButtonLabel({@required FormMode formMode}) {
    TextStyle textStyle = new TextStyle(fontSize: 20.0, color: Colors.white);
    String textLabel = formMode == FormMode.LOGIN ? 'Login' : 'Create Account';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(textLabel, style: textStyle),
    );
  }

  static Widget _secondaryButtonLabel({@required FormMode formMode}) {
    TextStyle textStyle =
        new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300);
    String textLabel = formMode == FormMode.LOGIN
        ? 'Create an Account'
        : 'Have an Account? Sign in';
    return Text(textLabel, style: textStyle);
  }
}
