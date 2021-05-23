import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/models/meal_model.dart';
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
        print("-- LOADING STATUS ----- " +
            store.state.mealState.loading.toString());

        if (authservice.currentUser == null) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            navigationService.pushAndReplaceNamed(LOGIN_ROUTE);
          });
        }

        if (store.state.userState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (store.state.mealState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: _buildAppBar(context, store),
          body: _buildBody(context, store),
          floatingActionButton: _buildFloatingActionButton(context, store),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  FloatingActionButton _buildFloatingActionButton(
      BuildContext context, Store<AppState> store) {
    return FloatingActionButton(
      onPressed: () {
        _showAddItemDialog(context, store);
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
              _buildMealsCard(store),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _buildMealsCard(Store<AppState> store) {
    return Expanded(
      child: Column(
        children: store.state.mealState.meals
            .map((meal) => MealsCard(meal: meal))
            .toList(),
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

  Future _showAddItemDialog(BuildContext context, Store<AppState> store) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _mealNameController = TextEditingController();
    TextEditingController _mealDescriptionController = TextEditingController();
    TimeOfDay selectedReminderTime = TimeOfDay.now();
    String selectedItem = Meal.mealTypeString(MealType.BREAKFAST);
    return showDialog(
      context: context,
      builder: (_) => Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text(
                'Add Meal',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remind me?",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
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
                          Text(
                            "Pick time",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).scaffoldBackgroundColor,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor,
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.1),
                              ),
                            ),
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then(
                                (value) => selectedReminderTime = value!,
                              );
                            },
                            child: Text(selectedReminderTime.format(context)),
                          )
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
                          Text(
                            "Select meal type",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedItem,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            items: <String>[
                              Meal.mealTypeString(MealType.BREAKFAST),
                              Meal.mealTypeString(MealType.LUNCH),
                              Meal.mealTypeString(MealType.SNACK),
                              Meal.mealTypeString(MealType.DINNER),
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) => selectedItem = val!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _mealNameController,
                      validator: (val) =>
                          val!.isEmpty ? 'Name cannot be empty' : null,
                      decoration: InputDecoration(
                        labelText: 'Enter Meal Name',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _mealDescriptionController,
                      validator: (val) =>
                          val!.isEmpty ? 'Description cannot be empty' : null,
                      decoration: InputDecoration(
                        labelText: 'Enter Meal Description',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Meal meal = Meal(
                            name: _mealNameController.text,
                            day: DateTime.now().day.toString(),
                            description: _mealDescriptionController.text,
                            user: authservice.currentUser!.uid,
                            savedAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            remindAt: DateTime.now(),
                          );

                          store.dispatch(AddMeal(meal: meal));
                        }
                      },
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
