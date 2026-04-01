import 'dart:convert';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  static late StompClient client;

  /// Kết nối WebSocket, yêu cầu truyền vào JWT Token đã đăng nhập
  static void connect(String jwtToken) {
    client = StompClient(
      config: StompConfig(
        // Chuyển từ http:// sang ws:// và thêm /websocket ở cuối
        // 10.0.2.2 là địa chỉ IP localhost dành cho Android Emulator
        // url: 'ws://10.0.2.2:8080/ws/chat/websocket',
        url: 'ws://http://localhost:8080/ws/chat/websocket',

        onConnect: onConnect,

        onWebSocketError: (dynamic error) => print('Lỗi kết nối WebSocket: $error'),

        // Truyền JWT Token vào Header để Backend Spring Boot xác thực
        stompConnectHeaders: {
          'Authorization': 'Bearer $jwtToken',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $jwtToken',
        },
      ),
    );

    client.activate();
  }

  /// Xử lý sự kiện khi kết nối thành công
  static void onConnect(StompFrame frame) {
    print('Đã kết nối WebSocket thành công!');

    // Lắng nghe tin nhắn tới (Theo API Document là /user/queue/messages)
    client.subscribe(
      destination: '/user/queue/messages',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          print('Nhận được tin nhắn mới: ${frame.body}');

          // Decode JSON tin nhắn nhận được
          // Map<String, dynamic> messageData = json.decode(frame.body!);
          // TODO: Gửi messageData vào State Management (Provider/Bloc/GetX) để cập nhật UI
        }
      },
    );
  }

  /// Hàm gửi tin nhắn
  static void sendMessage(String senderId, String receiverId, String content) {
    if (client.isActive) {
      client.send(
        destination: '/app/chat', // Kênh gửi tin nhắn theo API Document
        body: json.encode({
          'senderId': senderId,
          'receiverId': receiverId,
          'content': content,
        }),
      );
    } else {
      print('WebSocket chưa kết nối, không thể gửi tin nhắn!');
    }
  }

  /// Đóng kết nối khi không dùng nữa (vd: Logout)
  static void disconnect() {
    if (client.isActive) {
      client.deactivate();
      print('Đã ngắt kết nối WebSocket.');
    }
  }
}