import 'package:flutter/material.dart';
import 'package:online_order_application/menu_screen.dart';
import 'menu_item_details_screen.dart';

class OrderScreen extends StatefulWidget {
  final List<OrderItem> orderItems;

  const OrderScreen(this.orderItems, {super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.orderItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        child:Image.asset(widget.orderItems[index].menuItem.itemImageUrl,
                            height: 100,
                            width: 100,
                            fit:BoxFit.cover
                        ),
                      ),
                      Expanded(
                          child: Padding(
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
                                            widget.orderItems[index].menuItem.itemName,
                                            style:TextStyle(
                                              fontSize:18.0,
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
                                          Expanded(
                                            child: Text(
                                              'Options: ${widget.orderItems[index].options.join(', ')}',
                                              style:TextStyle(
                                                fontSize:18.0,
                                                fontWeight: FontWeight.bold,
                                                color:Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0)
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '\$${getTotalPrice(widget.orderItems).toStringAsFixed(2)}',
                                            style:TextStyle(
                                              fontSize:18.0,
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8.0)
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: widget.orderItems[index].quantity > 1 ?() {
                                                    setState(() {
                                                      widget.orderItems[index].quantity -= 1;
                                                    });
                                                  } : null,
                                                  icon: Icon(Icons.remove)
                                              ),
                                              Text(
                                                '${widget.orderItems[index].quantity}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.orderItems[index].quantity += 1;
                                                    });
                                                  },
                                                  icon: Icon(Icons.add)
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  bool confirmDelete = await showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        title: const Text('Delete order'),
                                                        content: Text('Are you sure you want to delete this ${widget.orderItems[index].menuItem.itemName}'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.of(context).pop(false),
                                                            child: Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () => Navigator.of(context).pop(true),
                                                            child: Text('Delete'),
                                                          ),
                                                        ],
                                                      ),
                                                  );
                                                  if(confirmDelete == true) {
                                                    setState(() {
                                                      widget.orderItems[index].markedForDeletion = true;
                                                      widget.orderItems.removeWhere((orderItem) => orderItem.markedForDeletion);
                                                    });
                                                    int count = 0;
                                                    for(int i = 0; i < widget.orderItems.length; i++) {
                                                      if(widget.orderItems[i].markedForDeletion != false) {
                                                        count++;
                                                      }
                                                      if(count == widget.orderItems.length) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:(context)=>
                                                                    MenuScreen()));
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                              )
                          )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Amount: \$${getTotalPrice(widget.orderItems).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(width: 8.0,),
                  Text('Checkout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
          )
        ],
      ),
    );
  }

  double getTotalPrice(List<OrderItem> items) {
    double totalPrice = 0;
    int count = 0;
    for (var orderItem in items) {
      count++;
      if(count == 1) {
        switch(orderItem.menuItem.itemName) {
          case 'Coffee':
            orderItem.menuItem.itemPrice = 3.50;
            if(orderItem.options.contains('Medium')) {
              orderItem.menuItem.itemPrice += 0.50;
            } else if(orderItem.options.contains('Large')) {
              orderItem.menuItem.itemPrice += 1.00;
            } else if(orderItem.options.contains('Extra-Large')){
              orderItem.menuItem.itemPrice += 1.50;
            }
            break;
          case 'Pizza':
            orderItem.menuItem.itemPrice = 11.99;
            if(orderItem.options.contains('Medium')) {
              orderItem.menuItem.itemPrice += 0.50;
            } else if(orderItem.options.contains('Large')) {
              orderItem.menuItem.itemPrice += 1.00;
            } else if(orderItem.options.contains('X-Large')){
              orderItem.menuItem.itemPrice += 1.50;
            } else if(orderItem.options.contains('Slab')) {
              orderItem.menuItem.itemPrice += 2.00;
            }
            break;
          case 'Burger Meal':
            orderItem.menuItem.itemPrice = 14.99;
            if(orderItem.options.contains('Large Fries')) {
              orderItem.menuItem.itemPrice += 0.50;
            } else if(orderItem.options.contains('Poutine')) {
              orderItem.menuItem.itemPrice += 1.00;
            } else if(orderItem.options.contains('Extra Fries')){
              orderItem.menuItem.itemPrice += 1.50;
            } else if(orderItem.options.contains('Extra Patty')) {
              orderItem.menuItem.itemPrice += 2.00;
            }
            break;
          default: orderItem.menuItem.itemPrice;
        }
      }
      totalPrice += orderItem.menuItem.itemPrice;
      totalPrice = totalPrice * orderItem.quantity;
    }
    return totalPrice;
  }
}
