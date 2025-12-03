import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../RestClient/RestClient.dart';
import '../style/Style.dart';
import 'ProductCreateScreen.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList=[];

  bool Loading=true;

  @override
  void initState() {
  CallData();
    super.initState();
  }

  CallData( )async{
    Loading = true;
  var data= await ProductGridViewListRequest();
  setState(() {
    ProductList=data;
    Loading=false;
  });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductCreateScreen(),
              ),
            );
          },
        ),
        title: Text(
          "Product List",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),


      body: Stack(
        children: [   ScreenBackground(context),
        Container(child: Loading? (Center(child:  SpinKitWaveSpinner(color: colorGreen,),)):
        RefreshIndicator(
          color: colorGreen,
          onRefresh: () async {
            await CallData();     // আবার API call করবে
          },
          child: GridView.builder(
            gridDelegate: ProductGridViewStyle(),
            itemCount: ProductList.length,
            itemBuilder: (context, index) {
              return Card(
                color: colorWhite,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        ProductList[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ProductList[index]['bookName']),
                          SizedBox(height: 2),
                          Text("author: ${ProductList[index]['author']}"),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.all(6),
                                ),
                                child: Icon(
                                  CupertinoIcons.ellipsis_vertical_circle,
                                  size: 18,
                                  color: colorGreen,
                                ),
                              ),

                              SizedBox(width: 4),

                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.all(6),
                                ),
                                child: Icon(
                                  CupertinoIcons.delete,
                                  size: 18,
                                  color: colorRed,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        )



        ),
        
        
        ],
      ),

    );
  }
}

