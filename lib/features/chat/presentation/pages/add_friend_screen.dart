import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  // Dữ liệu giả lập
  final List<Map<String, dynamic>> _friends = [
    {"name": "Pena Valdez", "avatar": "https://randomuser.me/api/portraits/women/68.jpg", "selected": false},
    {"name": "Gil Hajoon", "avatar": "https://randomuser.me/api/portraits/women/44.jpg", "selected": true},
    {"name": "Fitzgerald", "avatar": "https://randomuser.me/api/portraits/men/46.jpg", "selected": false},
    {"name": "KerriBarber", "avatar": "https://randomuser.me/api/portraits/women/88.jpg", "selected": true},
    {"name": "WhiteCastaneda", "avatar": "https://randomuser.me/api/portraits/women/90.jpg", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    // Lọc ra những người đã chọn
    final selectedFriends = _friends.where((f) => f["selected"] == true).toList();

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsApp.textDark, size: Responsive.rw(20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add Friends",
          style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("DONE", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          // ==========================================
          // SEARCH BAR
          // ==========================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
            child: Container(
              height: Responsive.rh(40),
              decoration: BoxDecoration(
                color: ColorsApp.grayF5F5F5,
                borderRadius: BorderRadius.circular(Responsive.rw(20)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Friend",
                  hintStyle: TextStyle(color: ColorsApp.gray777, fontSize: Responsive.rw(14)),
                  prefixIcon: Icon(Icons.search, color: ColorsApp.gray999, size: Responsive.rw(20)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(10)),
                ),
              ),
            ),
          ),

          // ==========================================
          // SELECTED FRIENDS (Cuộn ngang)
          // ==========================================
          if (selectedFriends.isNotEmpty)
            Container(
              height: Responsive.rh(70),
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedFriends.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: Responsive.rw(15), top: Responsive.rh(5)),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: Responsive.rw(25),
                          backgroundImage: NetworkImage(selectedFriends[index]["avatar"]),
                        ),
                        // Dấu X để bỏ chọn
                        Positioned(
                          top: 0, right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Tìm và bỏ chọn
                                int realIndex = _friends.indexWhere((f) => f["name"] == selectedFriends[index]["name"]);
                                _friends[realIndex]["selected"] = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(Responsive.rw(2)),
                              decoration: const BoxDecoration(color: ColorsApp.textDark, shape: BoxShape.circle),
                              child: Icon(Icons.close, color: Colors.white, size: Responsive.rw(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          if (selectedFriends.isNotEmpty)
            const Divider(height: 1, color: ColorsApp.grayDBDBDB),

          // ==========================================
          // LIST FRIENDS (Cuộn dọc)
          // ==========================================
          Expanded(
            child: ListView.builder(
              itemCount: _friends.length,
              itemBuilder: (context, index) {
                final friend = _friends[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(5)),
                  leading: CircleAvatar(
                    radius: Responsive.rw(25),
                    backgroundImage: NetworkImage(friend["avatar"]),
                  ),
                  title: Text(friend["name"], style: TextStyle(fontSize: Responsive.rw(16), color: ColorsApp.textDark)),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        friend["selected"] = !friend["selected"];
                      });
                    },
                    child: Container(
                      width: Responsive.rw(24), height: Responsive.rw(24),
                      decoration: BoxDecoration(
                        color: friend["selected"] ? ColorsApp.primary : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: friend["selected"] ? ColorsApp.primary : ColorsApp.grayAFAFAF),
                      ),
                      child: friend["selected"] ? Icon(Icons.check, color: Colors.white, size: Responsive.rw(16)) : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}