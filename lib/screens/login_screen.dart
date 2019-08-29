import 'package:flutter/material.dart';
import 'package:gerenciador_da_loja/blocs/login_bloc.dart';
import 'package:gerenciador_da_loja/screens/home_screen.dart';
import 'package:gerenciador_da_loja/widgets/input_field.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context) => AlertDialog(
              title: Text("Erro"),
              content: Text("Você não possui os privilégios necessários"),
          ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: StreamBuilder<LoginState>(
          initialData: LoginState.LOADING,
          stream: _loginBloc.outState,
          builder: (context, snapshot) {

            switch(snapshot.data){

              case LoginState.LOADING:
                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),),);
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Icon(
                                Icons.store_mall_directory,
                                color: Theme.of(context).primaryColor,
                                size: 160.0,
                              ),
                              InputField(
                                icon: Icons.person_outline,
                                hint: "Usuário",
                                obscure: false,
                                stream: _loginBloc.outEmail,
                                onChanged: _loginBloc.changeEmail,
                              ),
                              InputField(
                                icon: Icons.lock_outline,
                                hint: "Senha",
                                obscure: true,
                                stream: _loginBloc.outPassword,
                                onChanged: _loginBloc.changePassword,
                              ),
                              SizedBox(
                                height: 32.0,
                              ),
                              StreamBuilder<bool>(
                                  stream: _loginBloc.outSubmitValid,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      height: 50.0,
                                      child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text("Entrar"),
                                        onPressed: snapshot.hasData ?
                                        _loginBloc.submit : null,
                                        textColor: Colors.white,
                                        disabledColor: Colors.pinkAccent.withAlpha(140),
                                      ),
                                    );
                                  }
                              )
                            ])),
                  ),
                );


            }


          }
        ));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }


}
