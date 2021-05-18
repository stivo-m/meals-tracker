import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/screens/widgets/data.dart';
import 'package:meal_tracker/screens/widgets/meals_card_widget.dart';

class MealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APP_TITLE,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [...dateCards],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        meals.length,
                        (index) => MealsCard(meal: meals[index]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant_outlined,
            ),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble_2,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }

  Future _showAddItemDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text('Add Meal'),
              content: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Remind me?"),
                          Switch(
                            value: true,
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pick time"),
                          TextButton(
                            onPressed: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                            },
                            child: Text(TimeOfDay.now().toString()),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Meal Name',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Meal Description',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Save Meal'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
