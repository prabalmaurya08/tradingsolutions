import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John"),
                  SizedBox(height: 5),
                  Text("john@gmail.com"),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(""),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
