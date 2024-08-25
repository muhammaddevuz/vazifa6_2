import 'package:flutter/material.dart';
import 'package:vazifa/ui/screens/admin_drawer/add_group.dart';
import 'package:vazifa/ui/screens/admin_drawer/room_screen.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';
import 'package:vazifa/ui/screens/admin_drawer/show_users_screen.dart';

class CustomDrawerForAdmin extends StatelessWidget {
  const CustomDrawerForAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "MENYU",
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AdminScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Bosh sahifa",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ProfileScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Profile",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      role: 1,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Students",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      role: 2,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Teachers",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ShowUsersScreen(
                      role: 3,
                    );
                  },
                ),
              );
            },
            title: const Text(
              "Admins",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AddGroup();
                  },
                ),
              );
            },
            title: const Text(
              "Add Group",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const RoomScreen();
                  },
                ),
              );
            },
            title: const Text(
              "Rooms",
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        ],
      ),
    );
  }
}
