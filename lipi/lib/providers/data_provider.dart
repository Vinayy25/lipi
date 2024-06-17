import 'package:flutter/material.dart';
import 'package:lipi/models/chat_model.dart';
import 'package:lipi/services/http_service.dart';

class Data extends ChangeNotifier {
  List<ChatModel> chats = [];
  bool requestPending = false;

  addChat(ChatModel chat) {
    chats.add(chat);
    fetchTrasnscription();
    notifyListeners();
  }

  fetchTrasnscription() async {
    requestPending = true;
    await HttpService()
        .sendAudioRequest(
      chats.last.audio?.path ?? '',
    )
        .then((value) {
          value = value.substring(2, value.length - 2);
      chats.last.text = value;

      notifyListeners();
    });
    requestPending = false;

    notifyListeners();
  }

  int chatLength() {
    return chats.length;
  }

  deleteChat(int index) {
    chats.removeAt(index);
    notifyListeners();
  }

  updateChat(int index, ChatModel chat) {
    chats[index] = chat;
    notifyListeners();
  }

  clearChat() {
    chats.clear();
    notifyListeners();
  }
}
