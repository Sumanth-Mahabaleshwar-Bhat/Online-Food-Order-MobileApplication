import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'order_screen.dart';

class OrderItem {
  MenuItem menuItem;
  List<String> options;
  int quantity;
  bool markedForDeletion;

  OrderItem(this.menuItem, this.options, this.quantity, this.markedForDeletion);
}

class Cart {
  List<OrderItem> items = [];
}

final Cart cart = Cart();

class MenuItemDetailsScreen extends StatefulWidget {
  final MenuItem menuItem;

  const MenuItemDetailsScreen(this.menuItem, {super.key});

  @override
  _MenuItemDetailsScreenState createState() => _MenuItemDetailsScreenState();
}

class _MenuItemDetailsScreenState extends State<MenuItemDetailsScreen> {
  List<String> selectedOptions = [];
  List<String> inputOptions = [];
  List<String> foodOptions = [];
  List<String> foodSizes = [];
  String selectedValue = 'None';
  late String foodSize = foodSizes[0];
  late String dropdownTextLabel1;
  late String dropdownTextLabel2;
  int initialQuantity = 1;

  @override
  void initState() {
    super.initState();
    // Initialize input options based on the selected menu item
    setInputOptions();
  }

  void setInputOptions() {
    // Define input options based on the selected menu item
    if (widget.menuItem.itemName == 'Coffee') {
      dropdownTextLabel1 = 'Select the size of ${widget.menuItem.itemName}';
      dropdownTextLabel2 = 'Select the type of ${widget.menuItem.itemName}';
      foodSizes = ['None', 'Small', 'Medium', 'Large', 'Extra-Large'];
      inputOptions = ['Sugar', 'Milk', 'Cream'];
      foodOptions = ['None','Black Coffee', 'Regular', 'Double Double', 'Triple Triple'];
    } else if (widget.menuItem.itemName == 'Pizza') {
      dropdownTextLabel1 = 'Select the size of ${widget.menuItem.itemName}';
      dropdownTextLabel2 = 'Select the sauce for ${widget.menuItem.itemName}';
      foodSizes = ['None', 'Small', 'Medium', 'Large', 'X-Large', 'Slab'];
      inputOptions = ['Cheese', 'Pepperoni', 'Mushrooms', 'Red Onion', 'Peppers', 'Jalapeno'];
      foodOptions = ['None','BBQ', 'Buffalo Style', 'Butter Chicken', 'Desi Sauce', 'Garlic Spread'];
    } else if (widget.menuItem.itemName == 'Burger Meal') {
      dropdownTextLabel1 = 'Select the sides for ${widget.menuItem.itemName}';
      dropdownTextLabel2 = 'Select the drink for ${widget.menuItem.itemName}';
      foodSizes = ['None', 'Medium Fries', 'Large Fries', 'Poutine', 'Extra Fries', 'Extra Patty'];
      foodOptions = ['None','Medium Coca-Cola', 'Medium Diet Coke', 'Medium Sprite', 'Large Coca-Cola', 'Large Diet Coke'];
      inputOptions = ['Onion Rings', 'Salad', 'Extra Onions', 'Extra Pickles', 'Lettuce', 'Tomato'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.itemName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.menuItem.itemImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buildDropdownValues(foodSize, foodSizes, dropdownTextLabel1),
            Text(
              'Select Type of ${widget.menuItem.itemName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildDropdownValues(selectedValue, foodOptions, dropdownTextLabel2),
            ListTile(
              title: Text('Customize your ${widget.menuItem.itemName}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:FontWeight.bold
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildInputOptions(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if(initialQuantity > 1) {
                        setState(() {
                          initialQuantity--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove)
                ),
                Text(
                  '$initialQuantity',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        initialQuantity++;
                      });
                    },
                    icon: Icon(Icons.add)
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showAlertDialog();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8.0,),
                  Text('Add to Cart',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  List<Widget> buildInputOptions() {
    return inputOptions.map((option) {
      return CheckboxListTile(
        title: Text(option),
        value: selectedOptions.contains(option),
        onChanged: (value) {
          setState(() {
            if (value!) {
              selectedOptions.add(option);
            } else {
              selectedOptions.remove(option);
            }
          });
        },
      );
    }).toList();
  }

  Widget buildDropdownValues(String input, List<String> inputList, String dropdownTextLabel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: input,
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              if (!selectedOptions.contains(newValue)) {
                selectedOptions.add(newValue);
              }
            });
          }
        },
        items: inputList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
            labelText: dropdownTextLabel,
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        validator: (value) {
          return value == null ? 'Please select an option' : null;
        },
      ),
    );
  }

  void showAlertDialog() {
    bool hasValidSelection = selectedOptions.any((option) => option != 'None');
    if(!hasValidSelection) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Please select an option for ${dropdownTextLabel1} and ${dropdownTextLabel2} to order'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          )
      );
    } else {
      OrderItem orderItem = OrderItem(widget.menuItem, selectedOptions, initialQuantity, false);
      cart.items.add(orderItem);
      Navigator.pop(context, orderItem);
    }
  }
}