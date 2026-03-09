import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.greenAccent,
            labelColor: Colors.greenAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Alerts"),
              Tab(text: "Recommendations"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllNotifications(),
            AlertsTab(),
            RecommendationsTab(),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// ALL TAB
////////////////////////////////////////////////////////////

class AllNotifications extends StatelessWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        NotificationCard(
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.redAccent,
          title: "Low Balance Alert",
          subtitle: "Your Checking account is below \$50.",
          actionText: "View",
        ),
        NotificationCard(
          icon: Icons.credit_card,
          iconColor: Colors.orangeAccent,
          title: "Upcoming Bill Payment",
          subtitle: "Electricity bill due tomorrow.",
          actionText: "Pay",
        ),
        NotificationCard(
          icon: Icons.lightbulb_outline,
          iconColor: Colors.greenAccent,
          title: "Savings Tip",
          subtitle: "Save \$25 this week by reducing coffee expenses.",
          actionText: "Learn",
        ),
        NotificationCard(
          icon: Icons.trending_up,
          iconColor: Colors.green,
          title: "Increase Emergency Fund",
          subtitle: "Add \$100 to strengthen your savings.",
          actionText: "Start",
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// ALERTS TAB
////////////////////////////////////////////////////////////

class AlertsTab extends StatelessWidget {
  const AlertsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        NotificationCard(
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.redAccent,
          title: "Low Balance Alert",
          subtitle: "Your Checking account is below \$50.",
          actionText: "View",
        ),
        NotificationCard(
          icon: Icons.credit_card,
          iconColor: Colors.orangeAccent,
          title: "Bill Due Soon",
          subtitle: "Electricity bill due tomorrow.",
          actionText: "Pay",
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// RECOMMENDATIONS TAB
////////////////////////////////////////////////////////////

class RecommendationsTab extends StatelessWidget {
  const RecommendationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        NotificationCard(
          icon: Icons.lightbulb_outline,
          iconColor: Colors.greenAccent,
          title: "Savings Tip",
          subtitle: "Save \$25 this week by reducing coffee expenses.",
          actionText: "Learn",
        ),
        NotificationCard(
          icon: Icons.trending_up,
          iconColor: Colors.green,
          title: "Increase Emergency Fund",
          subtitle: "Add \$100 to strengthen your savings.",
          actionText: "Start",
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// REUSABLE NOTIFICATION CARD
////////////////////////////////////////////////////////////

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String actionText;

  const NotificationCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.actionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            actionText,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
