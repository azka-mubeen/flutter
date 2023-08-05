import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:tailor_assistant/Tailor/EditProfile.dart';

import '../../Login/login_page.dart';



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Navigation Drawer Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//       routes: {
//         '/page1': (context) => EditProfileScreen(),
//         '/page2': (context) => const Page2(),
//         '/page3': (context) => const Page3(),
//         '/page4': (context) => const Page4(),
//         '/page5': (context) => const Page5(),
//         '/page6': (context) => const Page6(),
//         '/page7': (contex`

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),


      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}



class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26495c),
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of notifications
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),

            title: Text('Notification $index'),
            subtitle: const Text('This is the notification message.'),
            onTap: () {
              // Handle notification tap event
            },
          );
        },
      ),
    );
  }
}
class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26495c),
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Last updated: June 10, 2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your privacy is important to us. This privacy policy explains how we collect, use, and disclose information when you use our mobile application.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'When you use our app, we may collect the following types of information:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('- Personal information, such as your name and email address, when you provide it to us.'),
            Text('- Usage information, such as your interactions with the app and the features you use.'),
            Text('- Device information, such as your device type, operating system, and unique device identifiers.'),
            SizedBox(height: 16.0),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may use the information we collect from you in the following ways:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('- To provide and maintain the app and its features.'),
            Text('- To personalize your experience and improve our services.'),
            Text('- To respond to your inquiries and provide customer support.'),
            Text('- To send you updates.'),
            SizedBox(height: 16.0),
            Text(
              'Third-Party Services',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may use third-party services that collect, monitor, and analyze information to improve the functionality of our app.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Data Retention',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We will retain your information for as long as necessary to provide you with the app and fulfill our legal obligations. If you wish to delete your information, please contact us at [tailorAssistant@gmail.com]',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our privacy policy from time to time. Any changes will be posted on this page and the "last updated" date will be revised accordingly.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or suggestions about our privacy policy, please contact us at [tailorAssistante@gmail.com]',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            // User clicked on "NO"
            Navigator.of(context).pop(false);
          },
          child: const Text('NO'),
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
            );
          },
          child: const Text('YES'),
        ),
      ],
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26495c),
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tailor Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Tailor Assistant! This app is designed to help you Customize tailoring service accessible through a mobile device. It connects tailors and customers for custom-designed dresses. Features include dress design uploads, chatting and Notifications etc',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff26495c),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Action to navigate back
                Navigator.pop(context);
              },
              child: const Text('Go Back'),

            ),
          ],
        ),
      ),
    );
  }
}

class Page6 extends StatelessWidget {
  const Page6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26495c),
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'For any inquiries or support, please feel free to contact us:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Email: tailorAssistant@gmail.com',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Phone: +1 234 567 890',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff26495c),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Handle button press
                // For example, open email client or phone dialer
              },
              child: const Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26495c),
        title: const Text('Help'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('FAQs'),
            onTap: () {
              // Navigate to FAQs page
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Contact Us'),
            onTap: () {
              // Open email client to contact support
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Provide Feedback'),
            onTap: () {
              // Open feedback form or redirect to feedback page
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('User Manual'),
            onTap: () {
              // Open user manual or display PDF/online documentation
            },
          ),
        ],
      ),
    );
  }
}