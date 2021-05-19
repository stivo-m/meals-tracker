import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/redux/actions/meal/meal_actions.dart';
import 'package:meal_tracker/redux/actions/user/user_actions.dart';
import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/screens/widgets/data.dart';
import 'package:meal_tracker/screens/widgets/meals_card_widget.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/navigation/navigation_service.dart';
import 'package:redux/redux.dart';

class MealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) => store.dispatch(GetMeals()),
      builder: (BuildContext context, Store<AppState> store) {
        if (authservice.currentUser == null) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            navigationService.pushAndReplaceNamed(LOGIN_ROUTE);
          });
        }

        if (store.state.userState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: _buildAppBar(context, store),
          body: _buildBody(context, store),
          floatingActionButton: _buildFloatingActionButton(context),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddItemDialog(context);
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Store<AppState> store) {
    return AppBar(
      title: Text(
        APP_TITLE,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 20.0,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            store.dispatch(SignOutAction());
          },
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.signOutAlt,
                size: 15,
                color: Theme.of(context).accentColor.withOpacity(0.6),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Sign Out',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
      elevation: 0,
    );
  }

  ListView _buildBody(BuildContext context, Store<AppState> store) {
    return ListView(
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
              _buildDateCards(),
              _buildMealsCard(),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _buildMealsCard() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          meals.length,
          (index) => MealsCard(meal: meals[index]),
        ),
      ),
    );
  }

  Container _buildDateCards() {
    return Container(
      height: 100,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [...dateCards],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
