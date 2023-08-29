
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/api/api.dart';
import 'package:test_app/model/provice.dart';
import 'package:test_app/model/social.dart';
import 'package:test_app/view/detail.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Provice? selectedProvices;
  List<Provice> provice = [];
  bool isSelect = false;
  APIservice repository = APIservice();
  List<Social> social = [];
  Social? selectedSocial;
  @override
  void initState() {
    super.initState();
    fetchSocials();
    fetchProvice();
  }

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> fetchSocials() async {
    try {
      final repository = APIservice();
      final data = await repository.fetchSocials();

      setState(() {
        social = data;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchProvice() async {
    try {
      final repository = APIservice();
      final data = await repository.fetchProvice();

      setState(() {
        provice = data;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // number of tabs
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('បន្លែមតំបន់ទេសចរណ៍'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            labelColor: Colors.amber,
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'YouTube'),
              Tab(text: 'Price'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Information tab content
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Photo Grallery',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          _pickImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.photo_album,
                                              color: Colors.amber,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.amber),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.camera,
                                              color: Colors.amber,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.amber),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: _imageFile == null
                                  ? Center(
                                      child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                    ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        _imageFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...List.generate(4, (index) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                )),
                              );
                            })
                          ],
                        ),
                        Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 8,
                          ),
                          padding:
                              EdgeInsets.all(6.0), // set padding for container
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // set background color for container
                            borderRadius: BorderRadius.circular(
                                10.0), // set border radius for container
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Name', // set hint text for text field
                              border: InputBorder
                                  .none, // remove border around text field
                            ),
                          ),
                        ),
                        Text(
                          'Provice',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 8,
                          ),
                          padding:
                              EdgeInsets.all(6.0), // set padding for container
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // set background color for container
                            borderRadius: BorderRadius.circular(
                                10.0), // set border radius for container
                          ),
                          child: DropdownButtonFormField<Provice>(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Provice',
                            ),
                            value: isSelect == true ? null : selectedProvices,
                            onChanged: (Provice? newValue) {
                              setState(() {
                                selectedProvices = newValue;
                              });
                            },
                            items: provice
                                .map<DropdownMenuItem<Provice>>((Provice item) {
                              return DropdownMenuItem<Provice>(
                                value: item,
                                child: Text(item.name!.lain),
                              );
                            }).toList(),
                          ),
                        ),
                        Text(
                          'Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 8,
                          ),
                          padding:
                              EdgeInsets.all(6.0), // set padding for container
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // set background color for container
                            borderRadius: BorderRadius.circular(
                                10.0), // set border radius for container
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'Address', // set hint text for text field
                              border: InputBorder
                                  .none, // remove border around text field
                            ),
                          ),
                        ),
                        Text(
                          'Locations',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 8,
                                ),
                                padding: EdgeInsets.all(
                                    6.0), // set padding for container
                                decoration: BoxDecoration(
                                  color: Colors
                                      .white, // set background color for container
                                  borderRadius: BorderRadius.circular(
                                      10.0), // set border radius for container
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText:
                                        'Locations', // set hint text for text field
                                    border: InputBorder
                                        .none, // remove border around text field
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 60,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Center(
                                child: Icon(
                                  Icons.place,
                                  color: Colors.amber,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Descriptions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 8,
                          ),
                          padding:
                              EdgeInsets.all(6.0), // set padding for container
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // set background color for container
                            borderRadius: BorderRadius.circular(
                                10.0), // set border radius for container
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                              helperMaxLines: 30,
                              hintText:
                                  'Descriptions', // set hint text for text field
                              border: InputBorder
                                  .none, // remove border around text field
                            ),
                          ),
                        ),
                        Text(
                          'Social',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8,
                                    ),
                                    padding: EdgeInsets.all(
                                        6.0), // set padding for container
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // set background color for container
                                      borderRadius: BorderRadius.circular(
                                          10.0), // set border radius for container
                                    ),
                                    child: DropdownButtonFormField<Social>(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Social',
                                      ),
                                      value: isSelect == true
                                          ? null
                                          : selectedSocial,
                                      onChanged: (Social? newValue) {
                                        setState(() {
                                          selectedSocial = newValue;
                                        });
                                      },
                                      items: social
                                          .map<DropdownMenuItem<Social>>(
                                              (Social item) {
                                        return DropdownMenuItem<Social>(
                                          value: item,
                                          child: Text(item.name!),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8,
                                    ),
                                    padding: EdgeInsets.all(
                                        6.0), // set padding for container
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // set background color for container
                                      borderRadius: BorderRadius.circular(
                                          10.0), // set border radius for container
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        // set hint text for text field
                                        border: InputBorder
                                            .none, // remove border around text field
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Color.fromARGB(255, 225, 203, 134),
                    child: Center(
                        child: Container(
                      padding: EdgeInsets.all(24.0),
                      width: double.infinity, // set padding for container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // set border radius for container
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(14),
                          backgroundColor:
                              Colors.amber, // set background color for button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // set border radius for button
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ), // set button text
                      ),
                    )),
                  ),
                )
              ],
            ),

            // YouTube tab content
            Center(child: Text('YouTube tab')),

            // Price tab content
            Center(child: Text('Price tab')),
          ],
        ),
      ),
    );
  }
}
