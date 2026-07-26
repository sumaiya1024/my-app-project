import 'package:flutter/material.dart';

class AmbassadorRegistrationScreen extends StatefulWidget {
  const AmbassadorRegistrationScreen({super.key});

  @override
  State<AmbassadorRegistrationScreen> createState() =>
      _AmbassadorRegistrationScreenState();
}

class _AmbassadorRegistrationScreenState
    extends State<AmbassadorRegistrationScreen> {
  int currentStep = 0;
  final Color primaryGreen = const Color.fromARGB(255, 217, 253, 185);

  String? selectedCity;
  String? selectedArea;
  String? selectedExperience;
  String? uploadedFileName;
  String? uploadedNidName;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool agreedToTerms = false;

  final List<String> skillOptions = [
    "First Aid",
    "Companionship",
    "Health Monitoring",
    "Nursing Care",
    "Elderly Feeding Assistance",
    "Mobility Support",
  ];
  final Map<String, bool> selectedSkills = {};

  @override
  void initState() {
    super.initState();
    for (var skill in skillOptions) {
      selectedSkills[skill] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text(
              "Register as Care Ambassador",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Apply to Provide Care",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepContinue: () {
          bool isLastStep = (currentStep == getSteps().length - 1);
          if (isLastStep) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Application Submitted Successfully!"),
              ),
            );
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepCancel: currentStep == 0
            ? null
            : () {
                setState(() {
                  currentStep -= 1;
                });
              },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed:
                        (currentStep == getSteps().length - 1 && !agreedToTerms)
                        ? null
                        : details.onStepContinue,
                    child: Text(
                      currentStep == getSteps().length - 1
                          ? "Apply as Ambassador"
                          : "Next Step",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (currentStep != 0) ...[
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: getSteps(),
      ),
    );
  }

  List<Step> getSteps() => [
    // ধাপ ১
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text("Basic Information"),
      content: Column(
        children: [
          customTextField("Full Name *", "e.g.Sumaiya Shahara Lopa"),
          const SizedBox(height: 15),
          customTextField("Phone Number *", "0153XXXXXXX"),
          const SizedBox(height: 15),
          customTextField("Email Address *", "sumaiyashahara24@gmail.com"),
          const SizedBox(height: 15),
          customDropdown("Gender *", ["Male", "Female", "Other"], (val) {}),
        ],
      ),
    ),

    // ধাপ ২
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: const Text("Location & Proximity"),
      content: Column(
        children: [
          customDropdown("City *", ["Dhaka", "Chattogram", "Sylhet"], (val) {
            setState(() {
              selectedCity = val;
            });
          }),
          const SizedBox(height: 15),
          customDropdown(
            "Specific Area *",
            [
              "Rayer Bazar",
              "Dhanmondi",
              "Mohammadpur",
              "Mirpur",
              "Gulshan",
              "",
            ],
            (val) {
              setState(() {
                selectedArea = val;
              });
            },
          ),
          const SizedBox(height: 15),
          customTextField("Current Address", "Detailed House/Road address"),
        ],
      ),
    ),

    // ধাপ ৩
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: const Text("Professional Details"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTextField(
            "Police Clearance Certificate *",
            "e.g.Sumaiyapolice.pdf",
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                uploadedFileName = "my_resume_cv.pdf";
              });
            },
            child: fileUploadBox(
              uploadedFileName,
              "Upload CV / Resume *",
              Icons.cloud_upload_outlined,
            ),
          ),
          const SizedBox(height: 20),
          customDropdown(
            "Experience *",
            ["Fresh", "1-2 Years", "3+ Years", "5+ Years"],
            (val) {
              setState(() {
                selectedExperience = val;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Key Skills (Select all that apply) *",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: primaryGreen.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: skillOptions.map((skill) {
                return CheckboxListTile(
                  title: Text(skill, style: const TextStyle(fontSize: 14)),
                  value: selectedSkills[skill],
                  activeColor: primaryGreen,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedSkills[skill] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),

    // ধাপ ৪
    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: const Text("Security & Vetting"),
      content: Column(
        children: [
          customTextField("NID Number *", "National ID Number"),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                uploadedNidName = "nid_front_back.jpg";
              });
            },
            child: fileUploadBox(
              uploadedNidName,
              "Upload NID Copy (Front & Back) *",
              Icons.credit_card,
            ),
          ),
        ],
      ),
    ),

    // ধাপ ৫
    Step(
      state: currentStep > 4 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 4,
      title: const Text("Account Setup"),
      content: Column(
        children: [
          customPasswordField("Password *", "******", isPasswordHidden, () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          }),
          const SizedBox(height: 15),
          customPasswordField(
            "Confirm Password *",
            "******",
            isConfirmPasswordHidden,
            () {
              setState(() {
                isConfirmPasswordHidden = !isConfirmPasswordHidden;
              });
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Checkbox(
                value: agreedToTerms,
                activeColor: primaryGreen,
                onChanged: (value) {
                  setState(() {
                    agreedToTerms = value ?? false;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  "I agree to the Terms of Service, Privacy Policy, and consent to background checks.",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget customTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget customPasswordField(
    String label,
    String hint,
    bool isHidden,
    VoidCallback toggleVisibility,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isHidden,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: toggleVisibility,
            ),
          ),
        ),
      ],
    );
  }

  Widget customDropdown(
    String label,
    List<String> items,
    Function(String?) onChange,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreen, width: 2),
            ),
          ),
          hint: Text(
            "Select $label",
            style: TextStyle(color: Colors.grey.shade400),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChange,
        ),
      ],
    );
  }

  Widget fileUploadBox(String? fileName, String defaultText, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: primaryGreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryGreen, size: 40),
          const SizedBox(height: 10),
          Text(
            fileName ?? defaultText,
            style: TextStyle(
              color: fileName != null ? Colors.black87 : Colors.grey.shade600,
              fontWeight: fileName != null
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
