import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController _pageController = PageController(initialPage: 0);
  List<List<String>> questions = [
    ['سؤال 1', 'سؤال 2', 'سؤال 3', 'سؤال 4'],
    ['سؤال 5', 'سؤال 6', 'سؤال 7', 'سؤال 8'],
  ];
  String? selectedQuestionPage1;
  String? selectedQuestionPage2;
  int pagenumper = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 48, 130),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 92, 138),
        title: const Text(
          'Quiz App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              _buildQuestionsPage(questions[0], selectedQuestionPage1),
              _buildQuestionsPage(questions[1], selectedQuestionPage2),
              _buildSummaryPage(),
            ],
          ),
          Positioned(
            left: 30,
            right: 30,
            bottom: 20.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pagenumper == 0
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            setState(() {
                              pagenumper -= 1;
                            });
                          },
                          child: const Text('رجوع'),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  pagenumper ==
                          2 // ان كانت الصفحة رقم 3 هي التي تعمل وهي اخر صفحة سيتم اخفاء زر التالي
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            if (pagenumper == 0
                                ? selectedQuestionPage1 != null
                                : selectedQuestionPage2 != null) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                pagenumper += 1;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تنبيه'),
                                    content: Text('يجب اختيار سؤال.'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('موافق'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('التالي'),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsPage(
      List<String> questionsList, String? selectedQuestion) {
    return ListView.builder(
      itemCount: questionsList.length,
      itemBuilder: (context, index) {
        bool isSelected = selectedQuestion == questionsList[index];
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.amber,
            borderRadius: BorderRadius.circular(15),
          ),
          child: RadioListTile<String>(
            title: Text(
              questionsList[index],
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            value: questionsList[index],
            groupValue: selectedQuestion,
            onChanged: (value) {
              setState(() {
                if (questionsList == questions[0]) {
                  selectedQuestionPage1 = value;
                } else {
                  selectedQuestionPage2 = value;
                }
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildSummaryPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'اخترت:',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          if (selectedQuestionPage1 != null)
            Container(
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(selectedQuestionPage1!)),
          if (selectedQuestionPage2 != null)
            Container(
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(selectedQuestionPage2!)),
          ElevatedButton(
            onPressed: () {
              // قم بتنفيذ أي إجراء بعد الانتهاء من الاختبار
            },
            child: const Text('تم'),
          ),
        ],
      ),
    );
  }
}
