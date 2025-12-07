import 'package:flutter/material.dart';

class AddHostelPage extends StatefulWidget {
  const AddHostelPage({super.key});

  @override
  State<AddHostelPage> createState() => _AddHostelPageState();
}

class _AddHostelPageState extends State<AddHostelPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _buildingCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  String? _category;
  String? _incharge;
  String? _branch;
  String? _status;

  // Theme Colors
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  // Gender Icons
  final Map<String, IconData> genderIcons = {
    "Boys": Icons.male,
    "Girls": Icons.female,
  };

  // Branch Icons
  final Map<String, IconData> branchIcons = {
    "EAMCET": Icons.engineering,
    "NEET": Icons.local_hospital,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // MAIN BACKGROUND GRADIENT
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [dark1, dark2, dark3, purpleDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // APP BAR BACK + TITLE
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Add Hostel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // =================== NEON CARD ===================
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a1a2e),
                        Color(0xFF16213e),
                        Color(0xFF0f3460),
                        Color(0xFF533483),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: neon, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: neon.withOpacity(0.35),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // BUILDING NAME
                        _inputField(
                          label: "Building Name *",
                          controller: _buildingCtrl,
                          icon: Icons.home_work,
                        ),
                        const SizedBox(height: 20),

                        // CATEGORY DROPDOWN
                        _dropdownField(
                          label: "Category",
                          value: _category,
                          icon: Icons.male,
                          items: const ["Boys", "Girls"],
                          innerIcons: genderIcons,
                          onChanged: (v) => setState(() => _category = v),
                        ),
                        const SizedBox(height: 20),

                        // ADDRESS
                        _inputField(
                          label: "Address *",
                          controller: _addressCtrl,
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 20),

                        // INCHARGE
                        _dropdownField(
                          label: "Incharge *",
                          value: _incharge,
                          icon: Icons.person,
                          items: const ["Staff1", "Staff2"],
                          onChanged: (v) => setState(() => _incharge = v),
                        ),
                        const SizedBox(height: 20),

                        // BRANCH DROPDOWN WITH ICONS
                        _dropdownField(
                          label: "Branch *",
                          value: _branch,
                          icon: Icons.account_tree,
                          items: const ["EAMCET", "NEET"],
                          innerIcons: branchIcons,
                          onChanged: (v) => setState(() => _branch = v),
                        ),
                        const SizedBox(height: 20),

                        // STATUS
                        _dropdownField(
                          label: "Status",
                          value: _status,
                          icon: Icons.toggle_on,
                          items: const ["Active", "Inactive"],
                          onChanged: (v) => setState(() => _status = v),
                        ),
                        const SizedBox(height: 30),

                        // ADD HOSTEL BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Add Hostel",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: neon,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 20,
                              shadowColor: neon,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Hostel added (dummy action)',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================== INPUT FIELD =====================
  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
            Color(0xFF533483),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),

      child: Row(
        children: [
          Icon(icon, color: neon, size: 22),
          const SizedBox(width: 12),

          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(
                  color: Color(0xFFB5C7E8),
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
          ),
        ],
      ),
    );
  }

  // ===================== DROPDOWN FIELD =====================
  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
    Map<String, IconData>? innerIcons,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
            Color(0xFF533483),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          dropdownColor: const Color(0xFF16213e),
          decoration: const InputDecoration(border: InputBorder.none),

          icon: const Icon(Icons.arrow_drop_down, color: neon),

          hint: Text(
            label,
            style: const TextStyle(color: Color(0xFFB5C7E8), fontSize: 14),
          ),

          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Icon(innerIcons?[e] ?? icon, color: neon, size: 18),
                  const SizedBox(width: 8),
                  Text(e, style: const TextStyle(color: Colors.white)),
                ],
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
