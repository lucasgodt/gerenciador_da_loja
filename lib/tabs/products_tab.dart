import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_da_loja/widgets/category_tile.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    //Necessário para utilizar o AutomaticKeepAliveClientMixin
    super.build(context);

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center( child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),);
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return CategoryTile(snapshot.data.documents[index]);
              }
          );
        }
      },
    );
  }

  //Para manter o widget vivo mesmo mudando de tabs (AutomaticKeepAliveClientMixin)
  @override
  bool get wantKeepAlive => true;
}

