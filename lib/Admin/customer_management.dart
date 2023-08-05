import 'package:flutter/material.dart';

class CustomerManagementPage extends StatefulWidget {
  const CustomerManagementPage({super.key});

  @override
  State<CustomerManagementPage>  createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  List<Customer> customers = [
    Customer(name: 'Asma Fatima', address: '123 Main St', contact: 'asma@example.com'),
    Customer(name: 'Irfan Khan', address: '456 Main St', contact: 'irfan@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Customer Management'),
        backgroundColor: const Color(0xff26495c),
      ),
      body: Container(
        color: const Color(0xfff1f4ff),
        child: ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
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
                        //function to delete the tailor
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

class Customer {
  final String name;
  final String address;
  final String contact;

  Customer({required this.name, required this.address, required this.contact});
}
