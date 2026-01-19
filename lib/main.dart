import 'package:flutter/material.dart';

void main() {
  runApp(const FlexiApp());
}

/* ===========================
   ROOT APP
=========================== */

class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flexi CRM',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      ),
      home: const HomeShell(),
    );
  }
}

/* ===========================
   BOTTOM NAVIGATION
=========================== */

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final screens = const [
    DashboardScreen(),
    DailyCallScreen(),
    DoctorListScreen(),
    RCPAScreen(),
    DailyPlanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Doctors"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "RCPA"),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: "Plan"),
        ],
      ),
    );
  }
}

/* ===========================
   DASHBOARD
=========================== */

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget tile(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flexi Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                tile("Calls Today", "12/15", Icons.call, Colors.orange),
                const SizedBox(width: 10),
                tile("Coverage", "85%", Icons.check_circle, Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ===========================
   DAILY CALL
=========================== */

class DailyCallScreen extends StatefulWidget {
  const DailyCallScreen({super.key});

  @override
  State<DailyCallScreen> createState() => _DailyCallScreenState();
}

class _DailyCallScreenState extends State<DailyCallScreen> {
  String? doctor;
  List<String> selectedProducts = [];

  final products = [
    "Pantoprazole",
    "Cilnidipine",
    "Esomeprazole",
    "Ferrous Ascorbate"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Call")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Select Doctor"),
              items: ["Dr Sharma", "Dr Das", "Dr Paul"]
                  .map((d) =>
                      DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => doctor = v,
            ),
            const SizedBox(height: 20),
            const Text("Products Detailed",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: products.map((p) {
                final selected = selectedProducts.contains(p);
                return FilterChip(
                  label: Text(p),
                  selected: selected,
                  onSelected: (v) {
                    setState(() {
                      v ? selectedProducts.add(p) : selectedProducts.remove(p);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved offline ✅")),
                );
              },
              child: const Text("SUBMIT"),
            )
          ],
        ),
      ),
    );
  }
}

/* ===========================
   DOCTOR LIST
=========================== */

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctors")),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text("A")),
            title: Text("Dr Anjali Sharma"),
            subtitle: Text("Cardio • City"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("B")),
            title: Text("Dr Rahul Das"),
            subtitle: Text("GP • Town"),
          ),
        ],
      ),
    );
  }
}

/* ===========================
   RCPA
=========================== */

class RCPAScreen extends StatelessWidget {
  const RCPAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RCPA")),
      body: const Center(
        child: Text("Chemist Audit Screen"),
      ),
    );
  }
}

/* ===========================
   DAILY PLAN
=========================== */

class DailyPlanScreen extends StatelessWidget {
  const DailyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Plan")),
      body: const Center(
        child: Text("Route Planning"),
      ),
    );
  }
}
