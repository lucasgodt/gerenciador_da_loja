import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_da_loja/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot order;

  OrderHeader(this.order);

  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.of<UserBloc>(context);

    final _userData = _userBloc.getUser(order.data["clientId"]);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${_userData["name"]}"),
              Text("${_userData["address"]}")
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Produtos: R\$${order.data["productsPrice"].toStringAsFixed(2)}", style: TextStyle(fontWeight:  FontWeight.w500),),
            Text("Total: R\$${order.data["totalPrice"].toStringAsFixed(2)}", style: TextStyle(fontWeight:  FontWeight.w500))
          ],
        )
      ],
    );
  }
}
