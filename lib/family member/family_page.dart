import 'package:flutter/material.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  // ফ্যামিলি মেম্বারদের ডেটা (এখন ডায়নামিক লিস্ট করা হয়েছে যেন নতুন মেম্বার যোগ করা যায়)
  final List<Map<String, String>> familyMembers = [
    {"name": "Zilan Hasnath", "relation": "Son", "status": "Active"},
    {"name": "Fatema Begum", "relation": "Mother", "status": "Active"},
    {"name": "Sami Ahmed", "relation": "Brother", "status": "Away"},
  ];

  final Color primaryTeal = const Color(0xFF0F766E);
  final Color mintAccent = const Color(0xFF14B8A6);

  // নতুন মেম্বার যোগ করার ডায়ালগ
  void _showAddMemberDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController relationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Add Family Member"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Member Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: relationController,
              decoration: const InputDecoration(
                labelText: "Relation (e.g. Daughter, Sister)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (nameController.text.trim().isNotEmpty &&
                  relationController.text.trim().isNotEmpty) {
                setState(() {
                  familyMembers.add({
                    "name": nameController.text.trim(),
                    "relation": relationController.text.trim(),
                    "status": "Active",
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Family member added successfully!"),
                  ),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // Soft Modern Background
      appBar: AppBar(
        title: const Text(
          "Family Members",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryTeal, mintAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          bool isActive = member['status'] == "Active";

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: primaryTeal.withValues(alpha: 0.1),
                child: Icon(Icons.person, color: primaryTeal),
              ),
              title: Text(
                member['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Text(
                      member['relation']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Text(" • ", style: TextStyle(color: Colors.grey)),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      member['status']!,
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
              onTap: () {
                // মেম্বারে ক্লিক করলে ডিটেইলস বটম শিট ওপেন হবে
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: primaryTeal.withValues(
                                  alpha: 0.1,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: primaryTeal,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member['name']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Relation: ${member['relation']}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Status: ${member['status']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isActive ? Colors.green : Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryTeal,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Calling ${member['name']}...',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.phone),
                                  label: const Text("Call"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      // নতুন মেম্বার যোগ করার স্টাইলিশ বাটন (ফুললি সচল)
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 2,
        onPressed: () {
          _showAddMemberDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
