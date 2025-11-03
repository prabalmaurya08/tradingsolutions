import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPrivacyMode = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Stack(children: [_buildSettingsCard(), _buildUserCard()]),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
       color: Colors.grey[300],
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Prabal Maurya",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),), Icon(Icons.notifications)],
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      // This margin positions the card.
      // top: 20 gives space from the AppBar
      // horizontal: 24 makes it a bit narrower than the card below
      margin: const EdgeInsets.only(top: 20, left: 24, right: 24),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
     
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Column for Name and Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isPrivacyMode ? '*****' : 'John Doe',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'your.email@company.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(), // Pushes profile pic to the right
              // Profile Pic
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueAccent,
                // You would use a NetworkImage or AssetImage here
                child: Text(
                  'YN',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Privacy mode',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Spacer(),
              Switch(
                value: _isPrivacyMode,
                onChanged: (value) {
                  setState(() {
                    _isPrivacyMode = value;
                  });
                },
                activeThumbColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      // This margin is the key!
      // The top: 110 leaves space for the UserCard to overlap
      margin: const EdgeInsets.only(top: 110),
      padding: EdgeInsets.only(left: 8,right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 80), // Adjust this value to fit
          Text("Accounts",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          const Divider(height: 12),
          _buildSettingsItem(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Funds',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.person_outline,
            title: 'App Code',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.settings_outlined,
            title: 'Account Settings',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.apps,
            title: 'Connected Apps',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(icon: Icons.logout, title: 'Logout', onTap: () {}),
          const Divider(height: 2),
          const SizedBox(height: 12),
          Text('Support',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
           const SizedBox(height: 12),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.support,
            title: 'Support portal',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'User manual',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.call_rounded,
            title: 'Contact',
            onTap: () {},
          ),
          const Divider(height: 2),
                const SizedBox(height: 12),
          Text('Others',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.person_add_alt_rounded,
            title: 'Invite Friends',
            onTap: () {},
          ),
          const Divider(height: 2),
          _buildSettingsItem(
            icon: Icons.file_copy_sharp,
            title: 'Licenses',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      trailing: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
