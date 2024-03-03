import 'package:flutter/material.dart'; // استيراد حزمة المكتبة المستخدمة في تطوير التطبيق

void main() {
  runApp(MyApp()); // تشغيل التطبيق عبر MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(), // تحديد واجهة الصفحة الرئيسية للتطبيق QuizPage
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState(); // إنشاء حالة للصفحة
}

class _QuizPageState extends State<QuizPage> {
  PageController _pageController = PageController(initialPage: 0); // تحديد تحكم الصفحات مع صفحة البداية هي الصفحة رقم 0
  List<List<String>> questions = [ // قائمة تحتوي على الأسئلة
    ['سؤال 1', 'سؤال 2', 'سؤال 3', 'سؤال 4'],
    ['سؤال 5', 'سؤال 6', 'سؤال 7', 'سؤال 8'],
  ];
  String? selectedQuestionPage1; // سؤال محدد من الصفحة الأولى
  String? selectedQuestionPage2; // سؤال محدد من الصفحة الثانية
  int pagenumper = 0; // تتبع رقم الصفحة

  @override
  Widget build(BuildContext context) {
    return Scaffold( // إنشاء واجهة Scaffold
      backgroundColor: Color.fromARGB(255, 1, 48, 130), // تعيين لون الخلفية
      appBar: AppBar( // شريط العنوان في أعلى الصفحة
        backgroundColor: const Color.fromARGB(255, 0, 92, 138), // تعيين لون خلفية شريط العنوان
        title: const Text( // عنوان شريط العنوان
          'Quiz App', // العنوان نفسه
          style: TextStyle(color: Colors.white), // تعيين لون النص
        ),
      ),
      body: Stack( // تراص العناصر في الصفحة
        children: [
          PageView( // عرض صفحات متعددة بشكل أفقي
            physics: const NeverScrollableScrollPhysics(), // تعطيل التمرير
            controller: _pageController, // تحكم بالصفحات
            children: [
              _buildQuestionsPage(questions[0], selectedQuestionPage1), // بناء واجهة الأسئلة للصفحة الأولى
              _buildQuestionsPage(questions[1], selectedQuestionPage2), // بناء واجهة الأسئلة للصفحة الثانية
              _buildSummaryPage(), // بناء واجهة ملخص الإجابات
            ],
          ),
          Positioned( // تحديد موضع العنصر بناءً على الموضع المحدد
            left: 30,
            right: 30,
            bottom: 20.0,
            child: Center( // تحديد محتوى العنصر في وسط الصفحة
              child: Row( // تحديد عناصر أفقية
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي على المحور الرئيسي
                children: [
                  pagenumper == 0 // إذا كان رقم الصفحة يساوي 0
                      ? SizedBox() // لا شيء
                      : ElevatedButton( // زر مرتفع
                          onPressed: () {
                            _pageController.previousPage( // الانتقال إلى الصفحة السابقة
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            setState(() {
                              pagenumper -= 1; // تحديث رقم الصفحة
                            });
                          },
                          child: const Text('رجوع'), // نص الزر
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  pagenumper == 2 // إذا كان رقم الصفحة يساوي 2 (الصفحة الأخيرة)
                      ? SizedBox() // لا شيء
                      : ElevatedButton( // زر مرتفع
                          onPressed: () {
                            if (pagenumper == 0 // إذا كانت الصفحة الحالية الأولى
                                ? selectedQuestionPage1 != null // وتم اختيار سؤال منها
                                : selectedQuestionPage2 != null) { // أو الصفحة الثانية وتم اختيار سؤال منها
                              _pageController.nextPage( // الانتقال إلى الصفحة التالية
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                pagenumper += 1; // تحديث رقم الصفحة
                              });
                            } else {
                              showDialog( // عرض نافذة حوارية
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تنبيه'),
                                    content: Text('يجب اختيار سؤال.'), // نص الرسالة
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('موافق'), // نص الزر
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('التالي'), // نص الزر
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
      List<String> questionsList, String? selectedQuestion) { // بناء واجهة الأسئلة
    return ListView.builder( // بناء قائمة عمودية
      itemCount: questionsList.length,
      itemBuilder: (context, index) {
        bool isSelected = selectedQuestion == questionsList[index]; // تحقق مما إذا كان السؤال محددًا أم لا
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.amber, // تحديد لون الخلفية بناءً على اختيار المستخدم
            borderRadius: BorderRadius.circular(15),
          ),
          child: RadioListTile<String>(
            title: Text(
              questionsList[index],
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            value: questionsList[index],
            groupValue: selectedQuestion, // تحديد القيمة المحددة للمستخدم
            onChanged: (value) {
              setState(() {
                if (questionsList == questions[0]) {
                  selectedQuestionPage1 = value; // تحديد السؤال المحدد للصفحة الأولى
                } else {
                  selectedQuestionPage2 = value; // تحديد السؤال المحدد للصفحة الثانية
                }
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildSummaryPage() { // بناء واجهة ملخص الإجابات
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'اخترت:', // عنوان
            style: TextStyle(color: Colors.white), // تعيين لون النص
          ),
          const SizedBox(height: 20),
          if (selectedQuestionPage1 != null) // إذا تم اختيار سؤال من الصفحة الأولى
            Container( // إنشاء حاوية لعرض السؤال المحدد
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(selectedQuestionPage1!)), // عرض السؤال المحدد
          if (selectedQuestionPage2 != null) // إذا تم اختيار سؤال من الصفحة الثانية
            Container( // إنشاء حاوية لعرض السؤال المحدد
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(selectedQuestionPage2!)), // عرض السؤال المحدد
          ElevatedButton(
            onPressed: () {
              // قم بتنفيذ أي إجراء بعد الانتهاء من الاختبار
            },
            child: const Text('تم'), // زر لإنهاء الاختبار
          ),
        ],
      ),
    );
  }
}
