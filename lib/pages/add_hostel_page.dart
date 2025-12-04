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

  // Main Theme Colors
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------------- DARK GRADIENT BACKGROUND ----------------
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [dark1, dark2, dark3, purpleDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // ---------------- TOP APPBAR TEXT ----------------
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: neon),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Add Hostel",
                      style: TextStyle(
                        color: neon,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ---------------- NEON CARD ----------------
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        dark3.withOpacity(0.4),
                        purpleDark.withOpacity(0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: neon.withOpacity(0.3),
                      width: 1.4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: neon.withOpacity(0.25),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _inputField(
                          controller: _buildingCtrl,
                          label: "Building Name *",
                        ),

                        const SizedBox(height: 20),

                        _dropdownField(
                          label: "Category",
                          value: _category,
                          items: const ["Boys", "Girls"],
                          onChanged: (v) => setState(() => _category = v),
                        ),

                        const SizedBox(height: 20),

                        _inputField(
                          controller: _addressCtrl,
                          label: "Address *",
                        ),

                        const SizedBox(height: 20),

                        _dropdownField(
                          label: "Incharge *",
                          value: _incharge,
                          items: const ["Staff1", "Staff2"],
                          onChanged: (v) => setState(() => _incharge = v),
                        ),

                        const SizedBox(height: 20),

                        _dropdownField(
                          label: "Branch *",
                          value: _branch,
                          items: const ["EAMCET", "NEET"],
                          onChanged: (v) => setState(() => _branch = v),
                        ),

                        const SizedBox(height: 20),

                        _dropdownField(
                          label: "Status",
                          value: _status,
                          items: const ["Active", "Inactive"],
                          onChanged: (v) => setState(() => _status = v),
                        ),

                        const SizedBox(height: 30),

                        // ---------------- NEON BUTTON ----------------
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
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 15,
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

  // ------------------------- INPUT FIELD -------------------------
  Widget _inputField({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24, width: 1.2),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB5C7E8), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }

  // ------------------------ DROPDOWN FIELD ------------------------
  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: const Color(0xFF16213e),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB5C7E8), fontSize: 14),
          border: InputBorder.none,
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, color: neon),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
