class ApplicationData {
  static List<String> sections = [
    'Allergies',
    'Immunization',
    'Medication',
    'Problem List',
    'Procedures',
    'Demographics',
  ];

  static Map allergies = {
    0: {
      "name": "Penicillin",
      "reaction": "Hives",
      "severity": "Moderate to severe",
    },
    1: {
      "name": "Codeine",
      "reaction": "Shortness of breath",
      "severity": "Moderate",
    },
    2: {
      "name": "Bee sting",
      "reaction": "Anaphylactic shock",
      "severity": "Severe",
    },
  };

  static Map immunizations = {
    0: {
      "name": "Influenza virus vaccine",
      "type": "Intramuscular injection",
      "date": "May 2001",
      "quantity": "50 / mcg",
      "instructions": "Possible flu-like symptoms for three days",
    },
    1: {
      "name": "Tetanus and diphtheria toxoids, IM",
      "type": "Intramuscular injection",
      "date": "April 2000",
      "quantity": "50 / mcg",
      "instructions": "Mild pain or soreness in the local area",
    }
  };

  static Map medication = {
    0: {
      "name": "Acetaminophen with codeine",
      "dose": "2 / puffs",
      "rate": "1 / day",
      "instructions": "2 puffs once a day",
      "type": "liquid",
      "date": "March 28, 2005",
      "prescriber": "Ashby Medical Center",
    },
    1: {
      "name": "Indomethacin",
      "dose": "50 / mg",
      "rate": "2 / day",
      "instructions": "50mg bid with food",
      "type": "tablet",
      "date": "December 10, 2003",
      "prescriber": "Ashby Medical Center",
    },
  };

  static Map problemList = {
    0: {
      "name": "Ankle Sprain",
      "status": "Active",
      "date": "March 28, 2005",
      "notes": "Slipped on ice and fell.",
    },
    1: {
      "name": "Cholecytitis",
      "status": "Resolved",
      "date": "September 28, 2002",
      "notes": "Surgery postponed until after delivery.",
    },
  };

  static Map procedures = {
    0: {
      "name": "Laparoscopic Cholecystectomy",
      "date": "September 28, 2002",
      "provider": "Dr. Bala Venktaraman",
      "location": "Ashby Medical Center",
    },
    1: {
      "name": "Cesarian Section",
      "date": "March 22, 2002",
      "provider": "Dr. Tiffany Martinez",
      "location": "Ashby Medical Center",
    },
  };
}
