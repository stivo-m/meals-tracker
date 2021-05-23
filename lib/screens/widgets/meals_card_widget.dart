import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_tracker/models/meal_model.dart';

class MealsCard extends StatelessWidget {
  final Meal meal;

  const MealsCard({
    Key? key,
    required this.meal,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            DateFormat("dd MMMM, yyyy").format(
              DateTime.parse(meal.remindAt.toString()),
            ),
            style: TextStyle(
              color: Theme.of(context).accentColor.withOpacity(0.5),
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          _buildDecoratedContainer(context),
        ],
      ),
    );
  }

  Expanded _buildDecoratedContainer(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 15.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            stops: [
              0.02,
              0.02,
            ],
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).accentColor.withOpacity(0.1),
              blurRadius: 8.0,
              spreadRadius: 3.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildItems(context),
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 15.0,
                color: Theme.of(context).accentColor.withOpacity(0.5),
              ),
              onPressed: () {
                print('tapped');
              },
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildItems(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Meal.mealTypeString(meal.mealType).toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).accentColor.withOpacity(0.3),
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            meal.name,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            meal.description,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          )
        ],
      ),
    );
  }
}
