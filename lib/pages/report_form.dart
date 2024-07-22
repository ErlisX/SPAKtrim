import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added for Firestore
import 'package:firebase_storage/firebase_storage.dart';

class ReportFormPage extends StatefulWidget {
  const ReportFormPage({super.key});

  @override
  State<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];

  // Initialize list of elements for Institution textformfield
  final List<String> _institutions = [
    'Agjencia për Dialog dhe Bashkëqeverisje',
    'Autoriteti i Konkurrencës',
    'Autoriteti i Mbikëqyrjes Financiare',
    'Dhoma Kombëtare e Noterëve',
    'Dhoma Kombëtare e Përmbaruesve Gjyqësorë Privatë',
    'Inspektoriati i Lartë i Deklarimit dhe Kontrollit të Pasurive dhe Konfliktit të Interesave',
    'Këshilli i Lartë Gjyqësor',
    'Komisioneri për të Drejtën e Informimit dhe Mbrojtjen e të Dhënave Personale',
    'Komisioni i Prokurimit Publik (KPP)',
    'Komisioni Qendror Zgjedhor (KQZ)',
    'Kontrolli i Lartë i Shtetit (KLSH)',
    'Kryeministria',
    'Kuvendi i Republikës së Shqipërisë',
    'Ministër Shteti për Sipërmarrjen dhe Klimën e Biznesit',
    'Ministria e Arsimit dhe Sportit',
    'Ministria e Brendshme',
    'Ministria e Bujqësisë dhe Zhvillimit Rural',
    'Ministria e Drejtësisë',
    'Ministria e Ekonomisë, Kulturës dhe Inovacionit',
    'Ministria e Financave',
    'Ministria e Infrastrukturës dhe Energjisë',
    'Ministria e Mbrojtjes',
    'Ministria e Shëndetësisë dhe Mbrojtjes Sociale',
    'Ministria e Turizmit dhe Mjedisit',
    'Ministria për Evropën dhe Punët e Jashtme',
    'Njesitë vendore',
    'Prokuroria e Përgjithshme',
    'Universiteti i Tiranës'
  ];
  String? _selectedInstitution;

  Future<void> _pickFiles() async {
    // Use the file picker to allow the user to select multiple files
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Allow multiple file selection
      allowedExtensions:['jpg', 'pdf', 'doc', 'png', 'm4a', 'mp4', 'mp3'],
      withData: true // Allow any type of file
    );

    // Check if the user has selected any files
    if (result != null) {
      // Update the state with the selected files
      setState(() {
        _selectedFiles = result.files;
      });
      // Print file details for debugging
    }
  }
  
  // Initialize calendar in Date textformfield
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        List<String> fileUrls = [];

      // Upload files to Firebase Storage
      for (var file in _selectedFiles) {
      if (file.bytes != null) {
        final storageRef = FirebaseStorage.instance.ref().child('uploads/${file.name}');
        await storageRef.putData(file.bytes!);
        final fileUrl = await storageRef.getDownloadURL();
        fileUrls.add(fileUrl);
      }  else {
          throw Exception('File bytes are null for file: ${file.name}');
        }
      }

      // Save form data and file URLs to Firestore
      await FirebaseFirestore.instance.collection('Forms').add({
        'date': _dateController.text,
        'institution': _selectedInstitution,
        'description': _descriptionController.text,
        'files': fileUrls,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Raportimi u dergua me sukses!\nMund ta mbyllni faqen')),
      );

      // Clear the form
      _formKey.currentState?.reset();
      setState(() {
        _selectedFiles.clear();
        _selectedInstitution = null
        ;
      });
    } catch (e) {

      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting form: $e')),
      );
    }
  }
}

  Future uploadFile() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plotëso rubrikat')),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Kliko mbi ikonen per te zgjedhur daten',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lutem vendosni daten';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Flexible(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _selectedInstitution,
                  decoration: InputDecoration(
                      labelText: 'Institucioni',
                      prefixIcon: Icon(Icons.account_balance),
                      border: OutlineInputBorder()),
                  items: _institutions.map((String institution) {
                    return DropdownMenuItem<String>(
                      value: institution,
                      child: Text(
                        institution,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInstitution = newValue;
                      _institutionController.text = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lutem zgjidhni një institucion';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Scrollbar(
                thickness: 10,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Detaje',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Lutem plotesoni detajet';
                    }
                    return null;
                  },
                  minLines: 6,
                  maxLines: 6,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed:
                    _pickFiles, // call _pickfiles function when button is pressed
                child: Text('Ngarko foto/video'),
              ),
              SizedBox(height: 20.0),
              if (_selectedFiles.isNotEmpty)
                Scrollbar(
                  thickness: 10,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    height: 100,
                    child: ListView.builder(
                      itemCount: _selectedFiles.length,
                      itemBuilder: (context, index) {
                        final file = _selectedFiles[index];
                        return ListTile(
                          title: Text(file.name),
                          subtitle: Text('${file.size} bytes'),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 5.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    foregroundColor: Colors.deepOrange),
                onPressed: _submitForm,
                child: Text(
                  'Perfundo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
