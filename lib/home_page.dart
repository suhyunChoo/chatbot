import 'package:flutter/material.dart';
import 'package:flutter_chatbot_app/chat_list_item.dart';
import 'package:flutter_chatbot_app/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  final textController = TextEditingController();

  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final chatList = ref.watch(homeViewModelProvider);

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      return ChatListItem(
                          content: chat.content, isReceived: chat.isReceived);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                  ),
                ),
                TextField(
                  controller: textController,
                  onSubmitted: (value) {
                    if(value.trim().isEmpty){
                      return;
                    }
                    //여기서 뷰모델 호출하고 
                    //TextEditingController clear 메서드 이용해서
                    //텍스트 필드 값 비워주기

                    //한식메뉴 간단하게 3가지 부탁해
                    final vm = ref.read(homeViewModelProvider.notifier);
                    vm.send(value);
                    textController.clear();
                  },
                  decoration:InputDecoration(
                    border: MaterialStateOutlineInputBorder.resolveWith((states) {
                      return OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.purple
                        )
                      );
                    },)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
