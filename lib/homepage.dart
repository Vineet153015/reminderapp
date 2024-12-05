import 'package:flutter/material.dart';
import 'TaskCard.dart';
import 'appbar.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController _newTaskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedTime = '';

  void _addNewTask() {
    if (_newTaskController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedTime.isNotEmpty) {
      setState(() {
        tasks.add({
          'title': _newTaskController.text,
          'description': _descriptionController.text,
          'time': _selectedTime,
          'completed': false,
        });
        _newTaskController.clear();
        _descriptionController.clear();
        _selectedTime = ''; // Reset time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reminders',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _newTaskController,
                            decoration: InputDecoration(
                              hintText: 'Task Title',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                          Divider(height: 1, color: Colors.grey),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Task Description',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                          Divider(height: 1, color: Colors.grey),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  _selectedTime = pickedTime.format(context);
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _timeController,
                                decoration: InputDecoration(
                                  hintText: _selectedTime.isEmpty
                                      ? 'Select Time'
                                      : 'Time: $_selectedTime',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 1, color: Colors.grey),
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.black),
                            onPressed: _addNewTask,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            title: tasks[index]['title'],
                            description: tasks[index]['description'],
                            time: tasks[index]['time'],
                            completed: tasks[index]['completed'],
                            onChanged: (value) {
                              setState(() {
                                tasks[index]['completed'] = value!;
                              });
                            },
                          );
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
    );
  }
}
