import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
  Person(name: 'Jane', age: 21, emoji: '👸🏽'),
  Person(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
];

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Center(
          child: Text(
            "Person",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PersonDetails(person: people[index])));
                  },
                  child: ListTile(
                    leading: Hero(
                      tag: people[index].name,
                      child: Text(
                        people[index].emoji,
                        style: const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    title: Text(
                      people[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${people[index].age} years old',
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                );
              })),
    );
  }
}

class PersonDetails extends StatelessWidget {
  final Person person;

  const PersonDetails({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Hero(
          flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
          ){
            switch(flightDirection){
              case HeroFlightDirection.push:
                return ScaleTransition(
                  scale: animation.drive(
                    Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).chain(CurveTween(curve: Curves.fastOutSlowIn))
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Center(
            child: Text(
              person.emoji,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              person.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${person.age} years old',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
