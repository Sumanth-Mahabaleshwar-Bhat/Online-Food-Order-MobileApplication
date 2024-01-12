import 'package:flutter/material.dart';
import 'package:online_order_application/menu_item_details_screen.dart';
import 'order_screen.dart';

class MenuItem {
  late String itemName;
  late String rating;
  late double itemPrice;
  late String itemImageUrl;

  MenuItem(this.itemName, this.rating, this.itemPrice, this.itemImageUrl);
}

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem('Coffee', '4.5', 3.5, 'assets/coffee.png'),
    MenuItem('Burger Meal', '4.2', 11.99, 'assets/burger.png'),
    MenuItem('Pizza', '4.9', 14.99, 'assets/pizza.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Good morning User!",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight:FontWeight.bold
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderScreen(cart.items),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      child: Text("Delivering To",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: SizedBox(
                          width: 250,
                          child: DropdownButton(
                            value: "Current Location",
                            items: [
                              DropdownMenuItem(
                                  child: Text("Current Location",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold
                                    ),
                                  ),
                                  value: "Current Location",
                              )
                            ],
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (_) {}),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    SearchBar(
                      hintText: "Search Food",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount:menuItems.length,
                          itemBuilder:(context,index){
                            return Card(
                              elevation:10,
                              margin:const EdgeInsets.all(8),
                              child:Row(
                                children:[
                                  Container(
                                    child:Image.asset(menuItems[index].itemImageUrl,
                                        height: 100,
                                        width: 100,
                                        fit:BoxFit.cover
                                    ),
                                  ),
                                  Expanded(
                                      child:Padding(
                                        padding:const EdgeInsets.all(8.0),
                                        child:Center(
                                         child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children:[
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   Text(
                                                     menuItems[index].itemName,
                                                     style:TextStyle(
                                                       fontSize:20.0,
                                                       fontWeight:FontWeight.bold,
                                                     ),
                                                     textAlign: TextAlign.center,
                                                   ),
                                                 ],
                                               ),
                                               Padding(
                                                   padding: const EdgeInsets.all(8.0)
                                               ),
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   Text(
                                                     '\$${menuItems[index].itemPrice.toStringAsFixed(2)}',
                                                     style:TextStyle(
                                                       fontSize:20.0,
                                                       color:Colors.black,
                                                     ),
                                                     textAlign: TextAlign.center,
                                                   ),
                                                 ],
                                               ),
                                               Padding(
                                                   padding: const EdgeInsets.all(8.0)
                                               ),
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   Text(
                                                     menuItems[index].rating,
                                                     style:TextStyle(
                                                       fontSize:18.0,
                                                       fontWeight:FontWeight.bold,
                                                     ),
                                                     textAlign: TextAlign.center,
                                                   ),
                                                   IconButton(
                                                     icon: Icon(Icons.star),
                                                     onPressed: () {  },
                                                   ),
                                                 ],
                                               ),
                                             ]
                                         ),
                                        )
                                      )
                                  ),
                                  Column(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children:[
                                      IconButton(
                                          icon:Icon(Icons.add),
                                          onPressed:(){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:(context)=>
                                                        MenuItemDetailsScreen(
                                                            menuItems[index])));
                                          }
                                      ),
                                      IconButton(
                                        icon:Icon(Icons.favorite_border),
                                        onPressed:(){
                                            //Implementyourfavoriteiconlogichere
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}