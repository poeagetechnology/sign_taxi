import 'dart:async';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // ── Colors ──
  static const _primary = Color(0xFFF97316);
  static const _primaryLight = Color(0xFFFB923C);
  static const _secondary = Color(0xFF0EA5E9);
  static const _accent = Color(0xFF38BDF8);
  static const _bg = Color(0xFFF0F9FF);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF475569);

  // Hero slider
  final PageController _heroController = PageController();
  int _heroPage = 0;
  late Timer _heroTimer;

  final List<String> _heroImages = [
    'assets/images/taxi1.jpg',
    'assets/images/taxi2.jpg',
    'assets/images/taxi3.jpg',
  ];

  final List<String> _taglines = [
    'Your ride, your way – book instantly!',
    'Safe, reliable, and just a tap away.',
    '24/7 service in Coimbatore, always ready.',
  ];

  // Trip types carousel
  late PageController _tripController;
  late Timer _tripTimer;
  int _tripPage = 0;
  int _tripHoverIndex = -1;

  final List<Map<String, String>> _tripTypes = [
    {
      'title': 'Outstation',
      'description':
          'Wide range of cab models – 4, 7, 14, 16 seaters. Pick the perfect ride for your travel needs.',
      'image': 'assets/images/taxi1.jpg',
    },
    {
      'title': 'Hourly Rental',
      'description':
          'Make multiple stops, wait as needed. Book from 1 to 12 hours at your convenience.',
      'image': 'assets/images/taxi2.jpg',
    },
    {
      'title': 'Airport Taxi',
      'description':
          'Punctual pickups, transparent fares, and experienced drivers for stress-free airport transfers.',
      'image': 'assets/images/taxi3.jpg',
    },
    {
      'title': 'Round Trip',
      'description':
          'Flexible waiting times and multiple stops. Perfect for weekend getaways and family trips.',
      'image': 'assets/images/taxi1.jpg',
    },
    {
      'title': 'Bulk Booking',
      'description':
          'Fleet coordination, special rates, and timely service for events and groups.',
      'image': 'assets/images/taxi2.jpg',
    },
  ];

  // Cab types carousel
  late PageController _cabController;
  late Timer _cabTimer;
  int _cabPage = 0;

  final List<Map<String, String>> _cabTypes = [
    {
      'title': 'Sedan',
      'description': 'Business Class Comfort',
      'image': 'assets/images/sedan.jpg',
    },
    {
      'title': 'Mini',
      'description': 'Economy Class Ride',
      'image': 'assets/images/mini.jpg',
    },
    {
      'title': 'SUV',
      'description': 'Spacious Family Trips',
      'image': 'assets/images/suv.jpg',
    },
    {
      'title': 'Pink Taxi',
      'description': 'Safe rides by women, for women',
      'image': 'assets/images/pink.jpg',
    },
    {
      'title': 'Traveller',
      'description': 'Perfect for large groups',
      'image': 'assets/images/traveller.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _heroTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_heroPage + 1) % _heroImages.length;
      _heroController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
    _tripController = PageController(viewportFraction: 1.0);
    _tripTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_tripPage + 1) % _tripTypes.length;
      _tripController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
    _cabController = PageController(viewportFraction: 1.0);
    _cabTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_cabPage + 1) % _cabTypes.length;
      _cabController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _heroTimer.cancel();
    _tripTimer.cancel();
    _cabTimer.cancel();
    _heroController.dispose();
    _tripController.dispose();
    _cabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: _bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top Navigation Bar ──
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 40 : 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  // Logo
                  const Text(
                    'SignTaxi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  if (isWideScreen) ...[
                    _navLink('Home'),
                    _navLink('My Rides'),
                    _navLink('Offers'),
                    _navLink('About'),
                    const SizedBox(width: 16),
                  ],
                  SizedBox(
                    width: isWideScreen ? 140 : 110,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/role'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isWideScreen ? 28 : 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        isWideScreen ? 'Get Started' : 'Start',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Hero Slider ──
            SizedBox(
              height: 560,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _heroController,
                    itemCount: _heroImages.length,
                    onPageChanged: (i) => setState(() => _heroPage = i),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (_, i) => Container(
                      color: _primary,
                      child: Opacity(
                        opacity: 0.25,
                        child: Image.asset(
                          _heroImages[i],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 560,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                  // Solid color overlay
                  Container(color: _primary),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 700;
                      final contentWidth =
                          (isMobile
                                  ? constraints.maxWidth - 32
                                  : (constraints.maxWidth > 1200 ? 600 : 500))
                              .toDouble();
                      final horizPad = isMobile ? 16.0 : 40.0;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizPad,
                          vertical: 40,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: contentWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.verified,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isMobile
                                            ? '#1 Ride App'
                                            : '#1 Ride-Hailing App in Coimbatore',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white.withOpacity(0.9),
                                    ],
                                  ).createShader(bounds),
                                  child: Text(
                                    'Book a Ride\nInstantly',
                                    style: TextStyle(
                                      fontSize: isMobile ? 36 : 54,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.1,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    _taglines[_heroPage],
                                    key: ValueKey(_heroPage),
                                    style: TextStyle(
                                      fontSize: isMobile ? 16 : 20,
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          Navigator.pushNamed(context, '/role'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: _primary,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 24 : 32,
                                          vertical: isMobile ? 14 : 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        elevation: 8,
                                        shadowColor: Colors.black26,
                                      ),
                                      icon: const Icon(
                                        Icons.local_taxi,
                                        size: 22,
                                      ),
                                      label: Text(
                                        isMobile ? 'Book' : 'Book Now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: isMobile ? 15 : 17,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 20 : 28,
                                          vertical: isMobile ? 12 : 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.play_circle_outline,
                                        size: 20,
                                      ),
                                      label: Text(
                                        isMobile ? 'How' : 'How it Works',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: isMobile ? 13 : 16,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Page dots
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _heroImages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _heroPage == i ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _heroPage == i
                                ? Colors.white
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Stats bar
                  Positioned(
                    bottom: 60,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _heroStat('50K+', 'Rides'),
                          _heroDivider(),
                          _heroStat('4.8★', 'Rating'),
                          _heroDivider(),
                          _heroStat('1000+', 'Drivers'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Feature Cards ──
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth =
                      (constraints.maxWidth < 600
                              ? constraints.maxWidth - 40
                              : 180.0)
                          .toDouble();

                  return Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [_primary, _secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Text(
                          'Why Choose SignTaxi?',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Everything you need for a perfect ride, every single time',
                        style: TextStyle(
                          fontSize: 17,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          _featureCard(
                            Icons.bolt,
                            'Instant Booking',
                            'Book in seconds, ride in minutes',
                            _primaryLight,
                            cardWidth,
                          ),
                          _featureCard(
                            Icons.schedule,
                            'Schedule Rides',
                            'Plan ahead for important trips',
                            _secondary,
                            cardWidth,
                          ),
                          _featureCard(
                            Icons.directions_car,
                            'Multiple Options',
                            'Mini, Sedan, SUV & Premium',
                            _accent,
                            cardWidth,
                          ),
                          _featureCard(
                            Icons.gps_fixed,
                            'Live Tracking',
                            'Track your driver in real-time',
                            const Color(0xFF8B5CF6),
                            cardWidth,
                          ),
                          _featureCard(
                            Icons.shield,
                            'Safe & Secure',
                            'Verified drivers & SOS feature',
                            const Color(0xFF10B981),
                            cardWidth,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // ── Trip Types Carousel ──
            Container(
              color: _bg,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [_primary, _secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Our Trip Types',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Choose the perfect trip type for your journey',
                    style: TextStyle(
                      fontSize: 17,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 480,
                    child: PageView.builder(
                      controller: _tripController,
                      itemCount: _tripTypes.length,
                      onPageChanged: (i) => setState(() => _tripPage = i),
                      itemBuilder: (_, i) => _buildTripCard(_tripTypes[i], i),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _dots(_tripTypes.length, _tripPage),
                ],
              ),
            ),

            // ── Corporate Travel ──
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: LayoutBuilder(
                builder: (context, c) {
                  final narrow = c.maxWidth < 800;
                  final image = ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/corporate_left.jpg',
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 280,
                        decoration: BoxDecoration(
                          color: _primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.business,
                            size: 60,
                            color: _primary,
                          ),
                        ),
                      ),
                    ),
                  );
                  final text = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'A ride you can count on for every business need',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'SignTaxi provides smooth business travel with 24/7 support, experienced drivers, and comfortable rides. Special corporate rates available.',
                        style: TextStyle(
                          fontSize: 16,
                          color: _textSecondary,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Learn More',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  );
                  if (narrow)
                    return Column(
                      children: [image, const SizedBox(height: 24), text],
                    );
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: image),
                      const SizedBox(width: 40),
                      Expanded(child: text),
                    ],
                  );
                },
              ),
            ),

            // ── Cab Types Carousel ──
            Container(
              color: _bg,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [_primary, _secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Cab Types for Every Traveller',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Select from our premium fleet of vehicles',
                    style: TextStyle(
                      fontSize: 17,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 380,
                    child: PageView.builder(
                      controller: _cabController,
                      itemCount: _cabTypes.length,
                      onPageChanged: (i) => setState(() => _cabPage = i),
                      itemBuilder: (_, i) => _buildCabCard(_cabTypes[i]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _dots(_cabTypes.length, _cabPage),
                ],
              ),
            ),

            // ── Footer ──
            Container(
              decoration: BoxDecoration(
                color: _primary,
                boxShadow: [
                  BoxShadow(
                    color: _primary.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'SignTaxi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your trusted ride partner',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _footerIcon(Icons.phone, '+91 9876543210'),
                        const SizedBox(width: 32),
                        _footerIcon(Icons.email, 'support@signtaxi.com'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(Icons.facebook),
                      const SizedBox(width: 12),
                      _socialButton(Icons.telegram),
                      const SizedBox(width: 12),
                      _socialButton(Icons.email_outlined),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '© 2026 SignTaxi. All rights reserved.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helper Widgets ───

  Widget _navLink(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _heroStat(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11),
        ),
      ],
    );
  }

  Widget _heroDivider() {
    return Container(
      width: 1,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      color: Colors.white24,
    );
  }

  Widget _featureCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: MouseRegion(
        onEnter: (_) => setState(() {}),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.2), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.3), width: 1),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: _textPrimary,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(Map<String, String> trip, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: MouseRegion(
            onEnter: (_) => setState(() => _tripHoverIndex = index),
            onExit: (_) => setState(() => _tripHoverIndex = -1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: Matrix4.identity()
                          ..scale(_tripHoverIndex == index ? 1.06 : 1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            trip['image']!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: _primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: _textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_tripHoverIndex == index)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Travel Option',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    trip['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      trip['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _textSecondary,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCabCard(Map<String, String> cab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  cab['image']!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.directions_car,
                        size: 50,
                        color: _textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Vehicle Class',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _secondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                cab['title']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                cab['description']!,
                style: const TextStyle(
                  fontSize: 15,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dots(int count, int current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == current ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == current ? _primary : const Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _footerIcon(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _socialButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
