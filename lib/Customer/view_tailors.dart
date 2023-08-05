
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Tailors extends StatefulWidget {
  const Tailors({Key? key}) : super(key: key);

  @override
  State<Tailors> createState() => _TailorsState();
}

class _TailorsState extends State<Tailors> {
  void main() {
    runApp(
      const MaterialApp(
        home: Tailors(),
      ),
    );
  }
// style the app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const Icon(Icons.menu), // Leading icon
        backgroundColor: const Color(0xff4257b4),
        actions: [
          IconButton(
            icon: const Icon(Icons.search), // Search icon
            onPressed: () {
              // Add your search logic here
            },


          ),
        ],
      ),
      body: ViewTailor(),
    );
  }
}
//create a tailor list
class ViewTailor extends StatelessWidget {
  final List<Tailor> tailors = [
    const Tailor(
        name: 'Tailor 1',
        rating: 5,
        imageUrl:
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 2',
        rating: 5,
        imageUrl:
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 3',
        rating: 5,
        imageUrl:
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 4',
        rating: 5,
        imageUrl:
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 5',
        rating: 5,
        imageUrl:
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 6',
        rating: 5,
        imageUrl:
        'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 7',
        rating: 5,
        imageUrl:
        'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
    const Tailor(
        name: 'Tailor 8',
        rating: 5,
        imageUrl:
        'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
  ];

  ViewTailor({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tailors.length,
      itemBuilder: (context, index) {
        return TailorListItem(tailor: tailors[index]);
      },
    );
  }
}
// define the attribute of each tailor such as name, rating , imageurl
class Tailor {
  final String name;
  final double rating;
  final String imageUrl;

  const Tailor(
      {required this.name, required this.rating, required this.imageUrl});
}
// design item
class TailorListItem extends StatelessWidget {
  final double rating = 0;
  final Tailor tailor;

   const TailorListItem({super.key, required this.tailor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(tailor.imageUrl),

        ),
        title: Text(tailor.name, style: const TextStyle(fontSize: 18)),
        subtitle: Row(


              children: [
                 RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  itemSize: 18,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => const Icon(

                    Icons.star,

                    color: Colors.amber,
                  ),
                   updateOnDrag: false,
                  onRatingUpdate: (rating) {

                  },
                ),
                const SizedBox(width: 4),
                Text(tailor.rating.toString()),
              ],
            ),


        onTap: () {
          // Handle onTap event for each tailor item
        },
      ),
    );
  }
}

