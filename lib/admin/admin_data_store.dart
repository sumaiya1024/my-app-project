import 'package:flutter/material.dart';

class AdminDataStore extends ChangeNotifier {
  static final AdminDataStore instance = AdminDataStore._internal();
  AdminDataStore._internal() {
    _initSampleData();
  }

  // 1. Ambassadors List
  final List<Map<String, dynamic>> ambassadors = [];

  // 2. Elderly Members List
  final List<Map<String, dynamic>> elderlyMembers = [];

  // 3. Family Members List
  final List<Map<String, dynamic>> familyMembers = [];

  // 4. Shifts & Bookings
  final List<Map<String, dynamic>> shifts = [];

  // 5. Payout Requests
  final List<Map<String, dynamic>> payouts = [];

  // 6. Documents & Verifications
  final List<Map<String, dynamic>> documents = [];

  // 7. Messages to CEO / Support
  final List<Map<String, dynamic>> ceoMessages = [];

  // 8. Notice Board Announcements
  final List<Map<String, dynamic>> announcements = [];

  // 9. Emergency SOS Logs
  final List<Map<String, dynamic>> emergencyLogs = [];

  // System Settings
  bool autoDispatch = true;
  bool maintenanceMode = false;
  double platformCommissionRate = 12.5; // percentage
  String supportHotline = "+880 9612-345678";

  void _initSampleData() {
    // Sample Ambassadors
    ambassadors.addAll([
      {
        "id": "AMB-101",
        "name": "Sumaiya Shahara",
        "email": "sumaiyashahara@gmail.com",
        "phone": "+880 1711-234567",
        "area": "Gulshan 2, Dhaka",
        "rating": 5.0,
        "shiftsCompleted": 42,
        "status": "Verified",
        "isOnDuty": true,
        "earnings": 15400.0,
        "nidVerified": true,
        "badge": "Care Ambassador of the Month",
      },
      {
        "id": "AMB-102",
        "name": "Rahim Uddin",
        "email": "rahim.care@kinvera.org",
        "phone": "+880 1811-987654",
        "area": "Banani, Dhaka",
        "rating": 4.8,
        "shiftsCompleted": 35,
        "status": "Verified",
        "isOnDuty": true,
        "earnings": 12800.0,
        "nidVerified": true,
        "badge": "Senior Caregiver",
      },
      {
        "id": "AMB-103",
        "name": "Nusrat Jahan",
        "email": "nusrat.jahan@gmail.com",
        "phone": "+880 1912-334455",
        "area": "Uttara Sector 7, Dhaka",
        "rating": 4.6,
        "shiftsCompleted": 18,
        "status": "Verified",
        "isOnDuty": false,
        "earnings": 7200.0,
        "nidVerified": true,
        "badge": "Palliative Specialist",
      },
      {
        "id": "AMB-104",
        "name": "Tanvir Hasan",
        "email": "tanvir.h@outlook.com",
        "phone": "+880 1622-445566",
        "area": "Dhanmondi, Dhaka",
        "rating": 0.0,
        "shiftsCompleted": 0,
        "status": "Pending",
        "isOnDuty": false,
        "earnings": 0.0,
        "nidVerified": false,
        "badge": "New Applicant",
      },
      {
        "id": "AMB-105",
        "name": "Farhana Akter",
        "email": "farhana.akter@gmail.com",
        "phone": "+880 1555-889900",
        "area": "Mirpur 10, Dhaka",
        "rating": 4.2,
        "shiftsCompleted": 12,
        "status": "Suspended",
        "isOnDuty": false,
        "earnings": 4500.0,
        "nidVerified": true,
        "badge": "Under Review",
      },
    ]);

    // Sample Elderly Members
    elderlyMembers.addAll([
      {
        "id": "ELD-201",
        "name": "Haji Abdul Gafur",
        "age": 78,
        "gender": "Male",
        "address": "House 14, Road 5, Gulshan 1, Dhaka",
        "emergencyContact": "+880 1711-556677 (Son: Zilan)",
        "medicalCondition": "Hypertension, Arthritis, Diabetic Type 2",
        "assignedCaregiver": "Rahim Uddin",
        "medicationStatus": true,
        "bloodGroup": "B+",
        "carePlan": "Daily 6-Hour Assistance & Physical Therapy",
      },
      {
        "id": "ELD-202",
        "name": "Fatema Begum",
        "age": 72,
        "gender": "Female",
        "address": "Flat 4B, Sector 3, Uttara, Dhaka",
        "emergencyContact": "+880 1819-223344 (Daughter: Shirin)",
        "medicalCondition": "Post-stroke mobility recovery, Mild Dementia",
        "assignedCaregiver": "Sumaiya Shahara",
        "medicationStatus": true,
        "bloodGroup": "O+",
        "carePlan": "12-Hour Day Shift & Memory Exercises",
      },
      {
        "id": "ELD-203",
        "name": "Professor Anwar Hossain",
        "age": 82,
        "gender": "Male",
        "address": "Road 8A, Dhanmondi, Dhaka",
        "emergencyContact": "+880 1911-889900 (Son: Dr. Nabil)",
        "medicalCondition": "Cardiac pacemaker, Limited mobility",
        "assignedCaregiver": "Nusrat Jahan",
        "medicationStatus": false,
        "bloodGroup": "A+",
        "carePlan": "Vital Signs Monitoring & Companionship",
      },
    ]);

    // Sample Family Members
    familyMembers.addAll([
      {
        "id": "FAM-301",
        "name": "Zilan Hasnath",
        "phone": "+880 1711-556677",
        "email": "zilan.hasnath@kinvera.org",
        "relation": "Son",
        "linkedElderly": "Haji Abdul Gafur",
        "status": "Active",
        "paymentMethod": "Credit Card (Auto-Pay)",
      },
      {
        "id": "FAM-302",
        "name": "Dr. Nabil Hossain",
        "phone": "+880 1911-889900",
        "email": "nabil.h@hospital.org",
        "relation": "Son",
        "linkedElderly": "Professor Anwar Hossain",
        "status": "Active",
        "paymentMethod": "Bkash Merchant",
      },
      {
        "id": "FAM-303",
        "name": "Shirin Sultana",
        "phone": "+880 1819-223344",
        "email": "shirin.s@gmail.com",
        "relation": "Daughter",
        "linkedElderly": "Fatema Begum",
        "status": "Active",
        "paymentMethod": "Nagad Pay",
      },
    ]);

    // Sample Shifts
    shifts.addAll([
      {
        "id": "SHF-401",
        "ambassador": "Sumaiya Shahara",
        "elderly": "Fatema Begum",
        "date": "Today, Oct 12",
        "time": "09:00 AM - 03:00 PM",
        "location": "Sector 3, Uttara",
        "status": "In Progress",
        "fee": 1200.0,
      },
      {
        "id": "SHF-402",
        "ambassador": "Rahim Uddin",
        "elderly": "Haji Abdul Gafur",
        "date": "Today, Oct 12",
        "time": "04:00 PM - 08:00 PM",
        "location": "Gulshan 1, Dhaka",
        "status": "Scheduled",
        "fee": 950.0,
      },
      {
        "id": "SHF-403",
        "ambassador": "Nusrat Jahan",
        "elderly": "Professor Anwar Hossain",
        "date": "Tomorrow, Oct 13",
        "time": "10:00 AM - 02:00 PM",
        "location": "Road 8A, Dhanmondi",
        "status": "Confirmed",
        "fee": 900.0,
      },
      {
        "id": "SHF-404",
        "ambassador": "Sumaiya Shahara",
        "elderly": "Fatema Begum",
        "date": "Yesterday, Oct 11",
        "time": "09:00 AM - 03:00 PM",
        "location": "Sector 3, Uttara",
        "status": "Completed",
        "fee": 1200.0,
      },
      {
        "id": "SHF-405",
        "ambassador": "Tanvir Hasan",
        "elderly": "Haji Abdul Gafur",
        "date": "Oct 10, 2026",
        "time": "02:00 PM - 06:00 PM",
        "location": "Gulshan 1",
        "status": "Cancelled",
        "fee": 850.0,
      },
    ]);

    // Sample Payout Requests
    payouts.addAll([
      {
        "id": "PAY-501",
        "ambassador": "Sumaiya Shahara",
        "amount": 15400.0,
        "method": "Bkash",
        "account": "+880 1711-234567",
        "date": "Oct 11, 2026",
        "status": "Pending",
        "trxId": "Pending Approval",
      },
      {
        "id": "PAY-502",
        "ambassador": "Rahim Uddin",
        "amount": 12000.0,
        "method": "Nagad",
        "account": "+880 1811-987654",
        "date": "Oct 08, 2026",
        "status": "Approved",
        "trxId": "BK9X0192934",
      },
      {
        "id": "PAY-503",
        "ambassador": "Nusrat Jahan",
        "amount": 6500.0,
        "method": "Bank Transfer",
        "account": "City Bank (A/C: 110293848)",
        "date": "Oct 05, 2026",
        "status": "Approved",
        "trxId": "CBL-TX-88392",
      },
    ]);

    // Sample Documents for Verification
    documents.addAll([
      {
        "id": "DOC-601",
        "applicant": "Tanvir Hasan",
        "docType": "National NID Card & Police Clearance",
        "date": "Oct 10, 2026",
        "status": "Pending",
        "notes": "Clear scanned copy of front and back submitted",
      },
      {
        "id": "DOC-602",
        "applicant": "Farhana Akter",
        "docType": "Nursing & Elder Care Diploma",
        "date": "Oct 09, 2026",
        "status": "Pending",
        "notes": "Awaiting institute verification badge",
      },
      {
        "id": "DOC-603",
        "applicant": "Sumaiya Shahara",
        "docType": "Emergency First Aid & CPR Certification",
        "date": "Sep 25, 2026",
        "status": "Verified",
        "notes": "Red Crescent Certified - Level 3",
      },
    ]);

    // Sample Messages to CEO
    ceoMessages.addAll([
      {
        "id": "CEO-701",
        "sender": "Sumaiya Shahara",
        "role": "Care Ambassador",
        "subject": "Request for specialized dementia care equipment",
        "message":
            "Dear CEO, in the Gulshan and Uttara clusters, several clients need specialized non-slip mobility gear and blood-oxygen loggers. Providing standard kits would significantly boost care quality.",
        "date": "Oct 11, 2026, 08:30 PM",
        "status": "Unread",
        "priority": "High",
      },
      {
        "id": "CEO-702",
        "sender": "Dr. Nabil Hossain",
        "role": "Family Member",
        "subject": "Appreciation for Caregiver Nusrat Jahan",
        "message":
            "I would like to express my sincere gratitude for the dedication shown by Nusrat. My father's vital signs and emotional health have visibly improved.",
        "date": "Oct 10, 2026, 04:15 PM",
        "status": "In Review",
        "priority": "Normal",
      },
      {
        "id": "CEO-703",
        "sender": "Rahim Uddin",
        "role": "Care Ambassador",
        "subject": "Shift scheduling travel allowance suggestion",
        "message":
            "When shifts are scheduled back-to-back between distant sectors like Mirpur and Gulshan during rush hour, travel reimbursement would be helpful.",
        "date": "Oct 08, 2026, 11:20 AM",
        "status": "Resolved",
        "priority": "Normal",
      },
    ]);

    // Sample Notice Board Announcements
    announcements.addAll([
      {
        "id": "ANN-801",
        "title": "Care Ambassador of the Month, May 2026 Announced!",
        "content":
            "Congratulations to Sumaiya Shahara (ID: 418613) for achieving a perfect 5.0 rating across 42 shifts! A special bonus certificate has been awarded.",
        "date": "May 30, 2026",
        "target": "All",
        "isPinned": true,
      },
      {
        "id": "ANN-802",
        "title": "Seasonal Flu & Pneumonia Protocol Update",
        "content":
            "All ambassadors on duty are requested to carry digital pulse-oximeters and record elderly member body temperature during morning check-ins.",
        "date": "Oct 05, 2026",
        "target": "Ambassadors",
        "isPinned": false,
      },
      {
        "id": "ANN-803",
        "title": "24/7 Helpline Priority Routing Now Live",
        "content":
            "Our centralized emergency hotline (+880 9612-345678) has upgraded to automated doctor-on-call routing for immediate emergency triage.",
        "date": "Oct 01, 2026",
        "target": "All",
        "isPinned": false,
      },
    ]);

    // Sample Emergency SOS Logs
    emergencyLogs.addAll([
      {
        "id": "SOS-901",
        "elderly": "Haji Abdul Gafur",
        "location": "Gulshan 1, Dhaka",
        "time": "Oct 11, 09:12 PM",
        "status": "Resolved",
        "notes": "Dizziness reported. Caregiver Rahim arrived within 8 mins. Vitals stabilized.",
      },
      {
        "id": "SOS-902",
        "elderly": "Fatema Begum",
        "location": "Sector 3, Uttara",
        "time": "Oct 04, 11:45 AM",
        "status": "Resolved",
        "notes": "Accidental fall near bed. Ambulance dispatched. No fractures detected.",
      },
    ]);
  }

  // --- CRUD ACTIONS ---

  // Ambassador Actions
  void addAmbassador(Map<String, dynamic> data) {
    ambassadors.insert(0, data);
    notifyListeners();
  }

  void updateAmbassadorStatus(String id, String status) {
    final idx = ambassadors.indexWhere((a) => a['id'] == id);
    if (idx != -1) {
      ambassadors[idx]['status'] = status;
      notifyListeners();
    }
  }

  void deleteAmbassador(String id) {
    ambassadors.removeWhere((a) => a['id'] == id);
    notifyListeners();
  }

  void toggleDutyStatus(String id) {
    final idx = ambassadors.indexWhere((a) => a['id'] == id);
    if (idx != -1) {
      ambassadors[idx]['isOnDuty'] = !(ambassadors[idx]['isOnDuty'] as bool);
      notifyListeners();
    }
  }

  // Elderly Actions
  void addElderly(Map<String, dynamic> data) {
    elderlyMembers.insert(0, data);
    notifyListeners();
  }

  void deleteElderly(String id) {
    elderlyMembers.removeWhere((e) => e['id'] == id);
    notifyListeners();
  }

  void updateElderlyCaregiver(String id, String caregiver) {
    final idx = elderlyMembers.indexWhere((e) => e['id'] == id);
    if (idx != -1) {
      elderlyMembers[idx]['assignedCaregiver'] = caregiver;
      notifyListeners();
    }
  }

  // Family Member Actions
  void addFamilyMember(Map<String, dynamic> data) {
    familyMembers.insert(0, data);
    notifyListeners();
  }

  void deleteFamilyMember(String id) {
    familyMembers.removeWhere((f) => f['id'] == id);
    notifyListeners();
  }

  // Shift Actions
  void addShift(Map<String, dynamic> data) {
    shifts.insert(0, data);
    notifyListeners();
  }

  void updateShiftStatus(String id, String newStatus) {
    final idx = shifts.indexWhere((s) => s['id'] == id);
    if (idx != -1) {
      shifts[idx]['status'] = newStatus;
      notifyListeners();
    }
  }

  void deleteShift(String id) {
    shifts.removeWhere((s) => s['id'] == id);
    notifyListeners();
  }

  // Payout Actions
  void approvePayout(String id, String trxId) {
    final idx = payouts.indexWhere((p) => p['id'] == id);
    if (idx != -1) {
      payouts[idx]['status'] = "Approved";
      payouts[idx]['trxId'] = trxId;
      notifyListeners();
    }
  }

  void rejectPayout(String id) {
    final idx = payouts.indexWhere((p) => p['id'] == id);
    if (idx != -1) {
      payouts[idx]['status'] = "Rejected";
      notifyListeners();
    }
  }

  // Document Verification Actions
  void approveDocument(String id) {
    final idx = documents.indexWhere((d) => d['id'] == id);
    if (idx != -1) {
      documents[idx]['status'] = "Verified";
      notifyListeners();
    }
  }

  void rejectDocument(String id) {
    final idx = documents.indexWhere((d) => d['id'] == id);
    if (idx != -1) {
      documents[idx]['status'] = "Rejected";
      notifyListeners();
    }
  }

  // CEO Messages Actions
  void updateCeoMessageStatus(String id, String status) {
    final idx = ceoMessages.indexWhere((m) => m['id'] == id);
    if (idx != -1) {
      ceoMessages[idx]['status'] = status;
      notifyListeners();
    }
  }

  void deleteCeoMessage(String id) {
    ceoMessages.removeWhere((m) => m['id'] == id);
    notifyListeners();
  }

  // Announcement Actions
  void addAnnouncement(Map<String, dynamic> data) {
    announcements.insert(0, data);
    notifyListeners();
  }

  void deleteAnnouncement(String id) {
    announcements.removeWhere((a) => a['id'] == id);
    notifyListeners();
  }

  // System Settings Update
  void updateSettings({
    bool? autoDispatch,
    bool? maintenanceMode,
    double? commissionRate,
    String? hotline,
  }) {
    if (autoDispatch != null) this.autoDispatch = autoDispatch;
    if (maintenanceMode != null) this.maintenanceMode = maintenanceMode;
    if (commissionRate != null) platformCommissionRate = commissionRate;
    if (hotline != null) supportHotline = hotline;
    notifyListeners();
  }
}
