import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../data/mock_data.dart';
import '../models/parking_zone.dart';
import 'zone_details_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<ParkingZone> zones;
  Timer? _timer;
  final Random _random = Random();
  // We no longer need the AnimationController or TickerProvider

  @override
  void initState() {
    super.initState();
    zones = List.from(mockParkingZones);
    _startLiveSimulation();
  }

  void _startLiveSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        final numZonesToUpdate = _random.nextInt(2) + 1;
        for (var i = 0; i < numZonesToUpdate; i++) {
          final randomIndex = _random.nextInt(zones.length);
          zones[randomIndex].probability = _random.nextDouble();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color _getZoneColor(double probability) {
    if (probability > 0.7) {
      return const Color(0xFF10B981); // Modern green
    } else if (probability > 0.3) {
      return const Color(0xFFF59E0B); // Modern amber
    } else {
      return const Color(0xFFEF4444); // Modern red
    }
  }

  // This is the new, modern way to show details
  void _onZoneTap(ParkingZone zone) {
    // This is the new, modern way
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make sheet bg transparent
      builder: (context) {
        // We wrap this in a draggable sheet
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // Start 60% high
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // We re-use the ZoneDetailsScreen widget here,
              // but we MUST pass the scrollController to it.
              child: ZoneDetailsScreen(
                zone: zone,
                scrollController: scrollController,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // We remove the AppBar and FAB, and use a Stack as the body
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(18.604792, 73.716666), 
              initialZoom: 18.0,
              onTap: (tapPos, latlng) {
                for (final zone in zones) {
                  if (_pointInPolygon(latlng, zone.boundaries)) {
                    _onZoneTap(zone);
                    return;
                  }
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.spotto',
              ),
              PolygonLayer(
                polygons: zones.map((zone) {
                  final baseColor = _getZoneColor(zone.probability);
                  return Polygon(
                    points: zone.boundaries,
                    color: baseColor.withOpacity(0.20),
                    borderColor: baseColor.withOpacity(0.85),
                    borderStrokeWidth: 2.5,
                    isFilled: true,
                  );
                }).toList(),
              ),
              MarkerLayer(
                markers: zones.map((zone) {
                  final centroid = _centroid(zone.boundaries);
                  return Marker(
                    width: 48,
                    height: 48,
                    point: centroid,
                    child: GestureDetector(
                      onTap: () => _onZoneTap(zone),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    _getZoneColor(zone.probability),
                                    _getZoneColor(zone.probability)
                                        .withOpacity(0.8),
                                  ],
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getZoneColor(zone.probability)
                                        .withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '${(zone.probability * 100).toInt()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // This is the new Search Bar overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(PhosphorIcons.magnifyingGlass(), color: Colors.grey),
                    hintText: 'Search destination or zone...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          // Your Legend overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 90, // Adjusted top
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLegendItem('High', const Color(0xFF10B981)),
                  const SizedBox(height: 8),
                  _buildLegendItem('Medium', const Color(0xFFF59E0B)),
                  const SizedBox(height: 8),
                  _buildLegendItem('Low', const Color(0xFFEF4444)),
                ],
              ),
            ),
          ),
        ],
      ),
      // No FloatingActionButton
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  LatLng _centroid(List<LatLng> points) {
    if (points.isEmpty) return const LatLng(0, 0);
    double lat = 0.0;
    double lng = 0.0;
    for (final p in points) {
      lat += p.latitude;
      lng += p.longitude;
    }
    return LatLng(lat / points.length, lng / points.length);
  }

  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.length < 3) return false;
    bool inside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final xi = polygon[i].latitude;
      final yi = polygon[i].longitude;
      final xj = polygon[j].latitude;
      final yj = polygon[j].longitude;

      final intersect = ((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude <
              (xj - xi) * (point.longitude - yi) / (yj - yi + 0.0) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  }
}