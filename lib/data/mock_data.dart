import 'package:latlong2/latlong.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/parking_zone.dart';
import '../models/zone_details.dart';
import '../models/user_profile.dart';

// --- NEW MOCK ZONES FOR PUNE ---
// Coordinates based on user input for main parking lot

final List<ParkingZone> mockParkingZones = [
  ParkingZone(
    id: 'zone_a',
    name: 'Main Parking Lot',
    boundaries: [
      // Your coordinates, converted to Decimal Degrees
      const LatLng(18.605556, 73.716389), // 18°36'20"N 73°42'59"E
      const LatLng(18.605556, 73.717222), // 18°36'20"N 73°43'02"E
      const LatLng(18.603889, 73.716944), // 18°36'14"N 73°43'01"E
      const LatLng(18.604167, 73.716111), // 18°36'15"N 73°42'58"E
      const LatLng(18.605556, 73.716389), // Closing the loop
    ],
    probability: 0.35, // Let's make it somewhat full
  ),
  ParkingZone(
    id: 'zone_b',
    name: 'Street (East)',
    boundaries: [
      const LatLng(18.605556, 73.71728), // East of Zone A
      const LatLng(18.605556, 73.71750),
      const LatLng(18.603889, 73.71716),
      const LatLng(18.603889, 73.716944),
      const LatLng(18.605556, 73.71728),
    ],
    probability: 0.75,
  ),
  ParkingZone(
    id: 'zone_c',
    name: 'Street (South)',
    boundaries: [
      const LatLng(18.603611, 73.716944), // South of Zone A
      const LatLng(18.603889, 73.716944),
      const LatLng(18.603889, 73.716111),
      const LatLng(18.603611, 73.716111),
      const LatLng(18.603611, 73.716944),
    ],
    probability: 0.90, // High chance
  ),
  ParkingZone(
    id: 'zone_d',
    name: 'West Lot',
    boundaries: [
      const LatLng(18.605556, 73.71580), // West of Zone A
      const LatLng(18.605556, 73.71630),
      const LatLng(18.604167, 73.716111),
      const LatLng(18.604167, 73.71560),
      const LatLng(18.605556, 73.71580),
    ],
    probability: 0.15, // Super full
  ),
];

// Mock details mapped to the new IDs
final Map<String, ZoneDetails> mockZoneDetails = {
  'zone_a': ZoneDetails(
    avgParkingTime: '65 min',
    lastUpdated: '2 min ago',
    probabilityHistory: [
      const FlSpot(0, 0.3),
      const FlSpot(1, 0.4),
      const FlSpot(2, 0.45),
      const FlSpot(3, 0.5),
      const FlSpot(4, 0.35),
      const FlSpot(5, 0.35),
    ],
  ),
  'zone_b': ZoneDetails(
    avgParkingTime: '30 min',
    lastUpdated: '1 min ago',
    probabilityHistory: [
      const FlSpot(0, 0.7),
      const FlSpot(1, 0.75),
      const FlSpot(2, 0.8),
      const FlSpot(3, 0.85),
      const FlSpot(4, 0.9),
      const FlSpot(5, 0.75),
    ],
  ),
  'zone_c': ZoneDetails(
    avgParkingTime: '25 min',
    lastUpdated: '5 min ago',
    probabilityHistory: [
      const FlSpot(0, 0.8),
      const FlSpot(1, 0.85),
      const FlSpot(2, 0.9),
      const FlSpot(3, 0.95),
      const FlSpot(4, 0.9),
      const FlSpot(5, 0.90),
    ],
  ),
  'zone_d': ZoneDetails(
    avgParkingTime: '150 min',
    lastUpdated: '1 min ago',
    probabilityHistory: [
      const FlSpot(0, 0.2),
      const FlSpot(1, 0.1),
      const FlSpot(2, 0.15),
      const FlSpot(3, 0.2),
      const FlSpot(4, 0.15),
      const FlSpot(5, 0.15),
    ],
  ),
};

final UserProfile mockUserProfile = UserProfile(
  name: 'Jordan Lee',
  points: 1840,
  badges: [
    'Eco Parker',
    'Early Bird',
    'Top Rated',
    'Feedback Pro',
    'City Explorer',
    'Weekend Warrior',
  ],
);