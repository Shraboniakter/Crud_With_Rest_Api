import 'package:crud_with_rest_api/Screen/ProductUpdateScreen.dart';
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

  DeleteItem(id) async{
   showDialog(
    context:context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Delete !"),
        content: Text("Once delete, you can't get it back"),
        actions: [
          OutlinedButton(onPressed: ()async {

            Navigator.pop(context);
            setState(() {

              Loading=true;
            });
           await ProductDeleteRequest(id);
          await CallData();



          }, child: Text("Yes"),
          ),
          OutlinedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("No"),
          ),
        ],
      );
    }
   );
  }

  GotoUpdate(context,productItem){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder)=> ProductUpdateScreen(productItem),
      ),
    );

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
                        ProductList[index]['Img'],
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ProductList[index]['ProductName']),
                          SizedBox(height: 2),
                          Text("Price ${ProductList[index]['UnitPrice']}"),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {

                                 GotoUpdate(context,ProductList[index]);
                                },
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
                                onPressed: (){
                                  DeleteItem( ProductList[index]['_id'],);
                                },
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
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder)=> ProductCreateScreen(),
            ),
        );
      },
        backgroundColor: colorGreen,
        foregroundColor: colorWhite,
      child: Icon(Icons.add),
      ),

    );
  }
}

