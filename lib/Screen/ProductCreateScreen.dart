import 'package:crud_with_rest_api/RestClient/RestClient.dart';
import 'package:crud_with_rest_api/style/Style.dart';
import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {

  Map <String,String> FormValue = {
    "Img":"",
    "ProductCode":"",
    "ProductName":"",
    "Qty":"",
    "TotalPrice":"",
    "UnitPrice":""
  };
  InputOnChange(Mapkey,Textvalue){
    setState(() {
      FormValue.update(Mapkey, (value) => Textvalue);
    });

  }


  FormOnSubmit() async{
    if (FormValue['Img']!.length==0){
      ErrorToast('Image Link Required !');

    }
    else if (FormValue['ProductCode']!.length==0){
      ErrorToast('ProductCode Link Required !');

    }
    else if (FormValue['ProductName']!.length==0){
      ErrorToast('ProductName Link Required !');

    }
    else if (FormValue['Qty']!.length==0){
      ErrorToast('Qty Link Required !');

    }
    else if (FormValue['TotalPrice']!.length==0){
      ErrorToast('TotalPrice Link Required !');

    }
    else if (FormValue['UnitPrice']!.length==0){
      ErrorToast('UnitPrice Link Required !');

    }
    else{
    await  ProductCreateRequest(FormValue);


    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Product"),),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: AppInputDecoration("Product Name"),
                  onChanged: (Textvalue){
                    InputOnChange("ProductName", Textvalue);

                },),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: AppInputDecoration("Product Code"),
                  onChanged: (Textvalue){
                    InputOnChange("ProductCode", Textvalue);

                },),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: AppInputDecoration("Product Image"),
                  onChanged: (Textvalue){
                    InputOnChange("Img", Textvalue);

                },),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: AppInputDecoration("Unit Price"),
                  onChanged: (Textvalue){
                    InputOnChange("UnitPrice", Textvalue);

                },),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: AppInputDecoration("Total Price"),
                  onChanged: (Textvalue){
                    InputOnChange("TotalPrice", Textvalue);

                },),
                SizedBox(height: 20,),
                AppDropDownStyle(
                   DropdownButton(
                      value: FormValue['Qty'],
                      items: [
                        DropdownMenuItem(child:Text('Select Qt') , value: '',),
                        DropdownMenuItem(child:Text('1 pcs') , value: '1 pcs',),
                        DropdownMenuItem(child:Text('2 pcs') , value: '2 pcs',),
                        DropdownMenuItem(child:Text('3 pcs') , value: '3 pcs',),
                        DropdownMenuItem(child:Text('4 pcs') , value: '4 pcs',),
                      ],

                     isExpanded: true,
                      underline: Container(),
                      onChanged: (Textvalue){
                        InputOnChange("Qty", Textvalue);
                      },

                   ),
                ),
                SizedBox(height: 20,),

                Container(
                    child: ElevatedButton(
                      style: AppButtonStyle(),
                      onPressed: (){
                       FormOnSubmit();
                      },

                      child:SuccessButtonChild("Submit"),),),






              ],
            ),

          ),),
        ],

      ),


    );
  }
}
