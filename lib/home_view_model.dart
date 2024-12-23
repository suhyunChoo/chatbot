import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Chat {
  final String content;
  final bool isReceived;

  const Chat({required this.content, required this.isReceived});
}

class HomeViewModel extends Notifier<List<Chat>> {
  @override
  List<Chat> build() {
    return [];
  }

  final _model = GenerativeModel(

    model: 'gemini-1.5-flash',
    // apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
    apiKey: dotenv.get("GEMINI_API_KEY"),
    // apiKey: 'AIzaSyCNIOt_mddLd6aFgD0vkiyTLQAhH1Mc3fQ'

  );
//    apiKey: 'AIzaSyCNIOt_mddLd6aFgD0vkiyTLQAhH1Mc3fQ'
  // void send(String text) async {
  //   state = [...state, Chat(content: text, isReceived: false)];

  //   final result = await _model.generateContent([Content.text(text)]);

  //   if (result.text != null) {
  //     state = [
  //       ...state,
  //       Chat(content: result.text!, isReceived: true),
  //     ];
  //   }
  // }

  void send(String text) async {
  state = [...state, Chat(content: text, isReceived: false)];

  try {
    final result = await _model.generateContent([Content.text(text)]);

    if (result.text != null) {
      state = [
        ...state,
        Chat(content: result.text!, isReceived: true),
      ];
    } else {
      // API 응답이 성공했지만 결과가 없는 경우 처리
      state = [
        ...state,
        Chat(content: 'No response from API', isReceived: true),
      ];
    }
  } catch (e) {
    // 오류 처리
    state = [
      ...state,
      Chat(content: 'Error: $e', isReceived: true),
    ];
  }
}

}

final homeViewModelProvider = NotifierProvider<HomeViewModel,List<Chat>>(() => HomeViewModel(),);


// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class Chat {
//   final String content;
//   final bool isReceived;
//   const Chat({
//     required this.content,
//     required this.isReceived,
//   });
// }

// class HomeViewModel extends Notifier<List<Chat>> {
//   @override
//   List<Chat> build() {
//     return [];
//   }

//   final _model = GenerativeModel(
//     model: 'gemini-1.5-flash',
//     apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
//   );

//   void send(String text) async {
//     state = [...state, Chat(content: text, isReceived: false)];

//     final result = await _model.generateContent([Content.text(text)]);
//     if (result.text != null) {
//       state = [...state, Chat(content: result.text!, isReceived: true)];
//     }
//   }
// }

// final homeViewModelProvider =
//     NotifierProvider<HomeViewModel, List<Chat>>(() => HomeViewModel());


