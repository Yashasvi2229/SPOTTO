import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../data/mock_data.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = mockUserProfile;
    const Color spottoBlue = Color(0xFF0D6EFD); // Our theme blue

    return Scaffold(
      // Use a modern, light grey background for depth
      backgroundColor: Colors.grey[50], 
      appBar: AppBar(
        title: Text(
          'Rewards',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[50], // Match scaffold bg
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Gradient-based Points Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      spottoBlue.withOpacity(0.8),
                      spottoBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: spottoBlue.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Points',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[400],
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${profile.points}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Available Rewards',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // New unified reward cards
              _buildRewardCard(
                context,
                'Free Hour Parking',
                '500 points',
                PhosphorIcons.clock(),
              ),
              _buildRewardCard(
                context,
                'Coffee Voucher',
                '300 points',
                PhosphorIcons.coffee(),
              ),
              _buildRewardCard(
                context,
                'Premium Spot Access',
                '1000 points',
                PhosphorIcons.sparkle(),
              ),
              _buildRewardCard(
                context,
                'Gas Gift Card',
                '800 points',
                PhosphorIcons.gasPump(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New refactored widget for the reward card
  Widget _buildRewardCard(
      BuildContext context, String title, String points, IconData icon) {
    const Color spottoBlue = Color(0xFF0D6EFD);
    
    // We use a Card that follows our global theme
    return Card(
      elevation: 0, // Use border instead of shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icon in a light blue container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: spottoBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: spottoBlue, size: 28),
            ),
            const SizedBox(width: 16),
            // Title and points
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    points,
                    style: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Redeem Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: spottoBlue, // Always use theme blue
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Redeem',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}