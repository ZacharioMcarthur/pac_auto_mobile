import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'Nouvelle demande de course',
      'message': 'Vous avez une nouvelle demande de course en attente',
      'time': 'Il y a 5 minutes',
      'icon': Icons.car_rental,
      'color': Colors.blue,
      'route': 'demande_detail',
      'data': {'id': 1},
    },
    {
      'id': 2,
      'title': 'Course assignée',
      'message': 'Une course vous a été assignée',
      'time': 'Il y a 1 heure',
      'icon': Icons.assignment_turned_in,
      'color': Colors.white,
      'route': 'course_detail',
      'data': {'id': 2},
    },
    {
      'id': 3,
      'title': 'Rappel',
      'message': 'N\'oubliez pas de noter votre dernière course',
      'time': 'Il y a 2 heures',
      'icon': Icons.star,
      'color': Colors.orange,
      'route': 'notation',
      'data': {'id': 3},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF3e65af),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Aucune notification', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notification['color']?.withOpacity(0.2),
                      child: Icon(
                        notification['icon'],
                        color: notification['color'],
                      ),
                    ),
                    title: Text(notification['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['message']),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'],
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          notifications.removeAt(index);
                        });
                        // Update notification count in home page
                        Navigator.pop(context, notifications.length);
                      },
                    ),
                    onTap: () {
                      // Navigate based on notification route
                      final route = notification['route'];
                      final data = notification['data'];
                      
                      // Remove notification after clicking
                      setState(() {
                        notifications.removeAt(index);
                      });
                      
                      // Navigate to appropriate page
                      switch (route) {
                        case 'demande_detail':
                          Navigator.pop(context);
                          // Navigate to demande detail page
                          break;
                        case 'course_detail':
                          Navigator.pop(context);
                          // Navigate to course detail page
                          break;
                        case 'notation':
                          Navigator.pop(context);
                          // Navigate to notation page
                          break;
                        default:
                          Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}