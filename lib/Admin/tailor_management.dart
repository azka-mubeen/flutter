import 'package:flutter/material.dart';

class TailorManagementPage extends StatefulWidget {
  const TailorManagementPage({super.key});

  @override
  State<TailorManagementPage> createState() => _TailorManagementPageState();
}

class _TailorManagementPageState extends State<TailorManagementPage> {
  List<Tailor> tailors = [
    Tailor(name: 'Ali', address: '123 Main St', contact: 'ali@example.com'),
    Tailor(name: 'Nadia Hassan', address: '456 Elm St', contact: 'nadia@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Tailor Management'),
        backgroundColor: const Color(0xff26495c),
      ),
      body: Container(
        color: const Color(0xfff1f4ff),
        child: ListView.builder(
          itemCount: tailors.length,
          itemBuilder: (context, index) {
            final customer = tailors[index];
            return Container(
              color: Colors.white,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),

                      color: Colors.red,
                      onPressed: () {

                      },
                    ),
                    title: Text(customer.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ${customer.address}'),
                        Text('Contact: ${customer.contact}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff26495c),
        child: const Icon(Icons.add),
        onPressed: () {

        },


      ),
    );
  }
}

class Tailor {
  final String name;
  final String address;
  final String contact;

  Tailor({required this.name, required this.address, required this.contact});
}
