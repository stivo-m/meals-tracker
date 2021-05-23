import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final String day;
  final int date;
  final bool hasMeal;
  final bool isToday;

  const DateCard({
    Key? key,
    required this.day,
    required this.date,
    this.hasMeal = false,
    this.isToday = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: 7.0,
      ),
      decoration: BoxDecoration(
          color: isToday
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Theme.of(context).accentColor.withOpacity(0.05),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isToday
                  ? Theme.of(context).primaryColor.withOpacity(0.05)
                  : Theme.of(context).accentColor.withOpacity(0.05),
              blurRadius: 5.0,
              spreadRadius: 0.08,
            )
          ]),
      child: TextButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Text(
              day,
              style: TextStyle(
                color: isToday
                    ? Colors.white.withOpacity(0.8)
                    : Theme.of(context).accentColor.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
            Text(
              date.toString(),
              style: TextStyle(
                color: isToday ? Colors.white : Theme.of(context).accentColor,
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 10.0,
              ),
              width: double.infinity,
              height: 5.0,
              decoration: BoxDecoration(
                color: hasMeal
                    ? isToday
                        ? Colors.white
                        : Theme.of(context).primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
