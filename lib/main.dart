import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> _notifications = [
    {'sender': 'WhatsApp', 'message': 'New message from Mom: "Call me when you can."'},
    {'sender': 'Instagram', 'message': 'user123 liked your story.'},
    {'sender': 'Tiktok', 'message': 'Kenia is live now.'},
    {'sender': 'Pinterest', 'message': 'Check out these new shoes.'},
    {'sender': 'YouTube', 'message': 'Kenia channel uploaded: Weekly vlog.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Notifications'),
        backgroundColor: Colors.indigo,
        ),
      body: _notifications.isEmpty
          ? const Center(child: Text('All notifications cleared!'))
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                
                return Dismissible(
                  key: ValueKey(item['sender']),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: const ColoredBox(
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                      child: Icon(Icons.archive, color: Colors.white),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });

                    final action = direction == DismissDirection.startToEnd
                        ? 'deleted'
                        : 'archived';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['sender']} notification $action.'),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: Text(item['sender']![0]),
                      ),
                      title: Text(
                        item['sender']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item['message']!),
                    ),
                  ),
                );
              },
            ),
    );
  }
}