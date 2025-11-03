import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:spotto/models/user_profile.dart';
import '../data/mock_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = mockUserProfile;
    const Color spottoBlue = Color(0xFF0D6EFD);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Consistent light bg
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[50], // Match scaffold bg
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        children: [
          // --- User Header ---
          _buildProfileHeader(context, profile, spottoBlue),
          
          const SizedBox(height: 24),

          // --- Driver Stats ---
          _buildSectionHeader('Your Stats'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.8, // Make stats cards wider
              children: [
                _buildStatCard(
                  'Total Parks', '72', PhosphorIcons.pottedPlant(), Colors.green),
                _buildStatCard(
                  'Reports Made', '18', PhosphorIcons.warningCircle(), Colors.orange),
                _buildStatCard(
                  'Eco Rank', '#12', PhosphorIcons.leaf(), spottoBlue),
                _buildStatCard(
                  'Avg. Time', '43 min', PhosphorIcons.timer(), Colors.purple),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- Recent Activity ---
          _buildSectionHeader('Recent Activity'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            child: Column(
              children: [
                _buildActivityItem('Parked in Zone A', '+20 points', PhosphorIcons.pottedPlant(), Colors.green),
                _buildActivityItem('Reported Zone C Full', '+5 points', PhosphorIcons.warning(), Colors.orange),
                _buildActivityItem('Redeemed Coffee Voucher', '-300 points', PhosphorIcons.coffee(), Colors.brown),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- Badges (Horizontal List) ---
          _buildSectionHeader('Your Badges'),
          SizedBox(
            height: 120, // Constrained height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: profile.badges.length,
              itemBuilder: (context, index) {
                return _buildBadgeCard(
                  profile.badges[index],
                  isFirst: index == 0,
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),

          // --- Account Settings ---
          _buildSectionHeader('Account'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            child: Column(
              children: [
                _buildSettingsItem('Edit Profile', PhosphorIcons.user()),
                _buildSettingsItem('Notifications', PhosphorIcons.bell()),
                _buildSettingsItem('Help & Support', PhosphorIcons.question()),
                _buildSettingsItem('Logout', PhosphorIcons.signOut(), showArrow: false, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildProfileHeader(BuildContext context, UserProfile profile, Color spottoBlue) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: spottoBlue.withOpacity(0.1),
          child: Text(
            profile.name[0], // Initials
            style: GoogleFonts.inter(
              fontSize: 42,
              color: spottoBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          profile.name,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: spottoBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(PhosphorIcons.star() ,color: Colors.yellow[400], size: 16),
              const SizedBox(width: 8),
              Text(
                '${profile.points} points',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildBadgeCard(String badgeName, {bool isFirst = false}) {
    final icons = {
      'Eco Parker': PhosphorIcons.leaf(),
      'Early Bird': PhosphorIcons.sun(),
      'Top Rated': PhosphorIcons.star(),
      'Feedback Pro': PhosphorIcons.chatDots(PhosphorIconsStyle.fill),
      'City Explorer': PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
      'Weekend Warrior': PhosphorIcons.calendar(PhosphorIconsStyle.fill),
    };
    final colors = {
      'Eco Parker': Colors.green,
      'Early Bird': Colors.orange,
      'Top Rated': Colors.amber,
      'Feedback Pro': Colors.blue,
      'City Explorer': Colors.purple,
      'Weekend Warrior': Colors.teal,
    };

    return Container(
      width: 100,
      margin: EdgeInsets.only(left: isFirst ? 0 : 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (colors[badgeName] ?? Colors.grey).withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons[badgeName] ?? PhosphorIcons.question(),
            color: colors[badgeName] ?? Colors.grey,
            size: 36,
          ),
          const SizedBox(height: 8),
          Text(
            badgeName,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors[badgeName]?.shade800 ?? Colors.grey[800],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, {bool showArrow = true, Color? color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.grey[700],
        size: 24,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: color ?? Colors.black87,
        ),
      ),
      trailing: showArrow
          ? Icon(PhosphorIcons.caretRight(), color: Colors.grey[400], size: 16)
          : null,
      onTap: () {},
    );
  }
}