import 'package:flutter/material.dart';

class IssueOutingPage extends StatefulWidget {
  const IssueOutingPage({super.key, required studentName, required outingType});

  @override
  State<IssueOutingPage> createState() => _IssueOutingPageState();
}

class _IssueOutingPageState extends State<IssueOutingPage> {
  String passType = "";
  final TextStyle headingStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  final TextStyle normalStyle = const TextStyle(
    color: Colors.white70,
    fontSize: 15,
  );
  @override
  Widget build(BuildContext context) {
    final headingStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
              Color(0xFF533483),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppTitle(context),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white30, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF38EF7D), Color(0xFF3366E8)],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Issue New Outing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text("Date *", style: headingStyle),

                      const SizedBox(height: 6),
                      textField("20/11/2025"),
                      const SizedBox(height: 12),

                      Text("Pass Type *", style: headingStyle),

                      Row(children: [radio("Home Pass"), radio("Outing Pass")]),
                      Row(children: [radio("Self Outing"), radio("Self Home")]),
                      const SizedBox(height: 12),

                      Text("Select Student *", style: headingStyle),

                      const SizedBox(height: 6),
                      textField("Sunil"),
                      const SizedBox(height: 12),

                      Text("Letter Photo *", style: headingStyle),

                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Take Photo *", style: headingStyle),
                        ),
                      ),
                      const SizedBox(height: 14),

                      Text("Out time *", style: headingStyle),

                      const SizedBox(height: 6),
                      textField("07:12 PM"),
                      const SizedBox(height: 14),

                      Text("Purpose *", style: headingStyle),

                      const SizedBox(height: 6),
                      textField("SELECT"),
                      const SizedBox(height: 22),

                      SizedBox(
                        width: 160,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Grant Outing",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Outing Granted Successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppTitle(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: const [
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 8),
          Text(
            "Issue Outing",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget radio(String text) {
    return Row(
      children: [
        Radio(
          value: text,
          groupValue: passType,
          activeColor: Colors.white,
          fillColor: WidgetStatePropertyAll(Colors.white),
          onChanged: (value) {
            setState(() {
              passType = value.toString();
            });
          },
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.60),
          ),
        ),
      ],
    );
  }

  Widget textField(String value) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
