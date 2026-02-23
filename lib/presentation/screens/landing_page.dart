import 'dart:async';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  // ── Premium Color Palette ──
  static const _orange = Color(0xFFF97316);
  static const _orangeLight = Color(0xFFFB923C);
  static const _orangeDark = Color(0xFFEA580C);
  static const _sky = Color(0xFF0EA5E9);
  static const _skyLight = Color(0xFF38BDF8);
  static const _skyDark = Color(0xFF0284C7);
  static const _navy = Color(0xFF0F172A);
  static const _navyLight = Color(0xFF1E293B);
  static const _slate = Color(0xFF334155);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _textMuted = Color(0xFF94A3B8);
  static const _surfaceLight = Color(0xFFF8FAFC);
  static const _surfaceWarm = Color(0xFFFFF7ED);

  // Hero slider
  final PageController _heroController = PageController();
  int _heroPage = 0;
  late Timer _heroTimer;
  late AnimationController _pulseController;

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

  final List<Map<String, dynamic>> _tripTypes = [
    {
      'title': 'Outstation',
      'description':
          'Wide range of cab models – 4, 7, 14, 16 seaters. Pick the perfect ride for your travel needs.',
      'image': 'assets/images/taxi1.jpg',
      'icon': Icons.flight_takeoff,
    },
    {
      'title': 'Hourly Rental',
      'description':
          'Make multiple stops, wait as needed. Book from 1 to 12 hours at your convenience.',
      'image': 'assets/images/taxi2.jpg',
      'icon': Icons.schedule,
    },
    {
      'title': 'Airport Taxi',
      'description':
          'Punctual pickups, transparent fares, and experienced drivers for stress-free airport transfers.',
      'image': 'assets/images/taxi3.jpg',
      'icon': Icons.flight,
    },
    {
      'title': 'Round Trip',
      'description':
          'Flexible waiting times and multiple stops. Perfect for weekend getaways and family trips.',
      'image': 'assets/images/taxi1.jpg',
      'icon': Icons.sync_alt,
    },
    {
      'title': 'Bulk Booking',
      'description':
          'Fleet coordination, special rates, and timely service for events and groups.',
      'image': 'assets/images/taxi2.jpg',
      'icon': Icons.groups,
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
      'seats': '4',
      'price': '₹12/km',
    },
    {
      'title': 'Mini',
      'description': 'Economy Class Ride',
      'image': 'assets/images/mini.jpg',
      'seats': '4',
      'price': '₹9/km',
    },
    {
      'title': 'SUV',
      'description': 'Spacious Family Trips',
      'image': 'assets/images/suv.jpg',
      'seats': '7',
      'price': '₹16/km',
    },
    {
      'title': 'Pink Taxi',
      'description': 'Safe rides by women, for women',
      'image': 'assets/images/pink.jpg',
      'seats': '4',
      'price': '₹11/km',
    },
    {
      'title': 'Traveller',
      'description': 'Perfect for large groups',
      'image': 'assets/images/traveller.jpg',
      'seats': '14',
      'price': '₹22/km',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _heroTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_heroPage + 1) % _heroImages.length;
      _heroController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
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
    _pulseController.dispose();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 900;
    final isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavBar(isWide),
            _buildHeroSection(isWide, isMobile),
            _buildStatsStrip(isMobile),
            _buildFeatureSection(isMobile),
            _buildTripSection(isMobile),
            _buildCorporateSection(isMobile),
            _buildCabSection(isMobile),
            _buildCTASection(isMobile),
            _buildFooter(isMobile),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  NAV BAR
  // ═══════════════════════════════════════════
  Widget _buildNavBar(bool isWide) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.local_taxi,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sign',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: _navy,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'Taxi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: _orange,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isWide) ...[
            _navItem('Home', true),
            _navItem('Services', false),
            _navItem('Fleet', false),
            _navItem('About', false),
            const SizedBox(width: 20),
          ],
          _buildNavButton(isWide),
        ],
      ),
    );
  }

  Widget _navItem(String label, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: active ? _orange : _slate,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(bool isWide) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _orange.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/role'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _orange,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 28 : 18,
            vertical: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isWide ? 'Get Started' : 'Start',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_rounded, size: 16),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  HERO SECTION — Dark premium background
  // ═══════════════════════════════════════════
  Widget _buildHeroSection(bool isWide, bool isMobile) {
    return SizedBox(
      height: isMobile ? 620 : 640,
      child: Stack(
        children: [
          // Dark elegant background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_navy, Color(0xFF0C1222), _navyLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Subtle background image
          PageView.builder(
            controller: _heroController,
            itemCount: _heroImages.length,
            onPageChanged: (i) => setState(() => _heroPage = i),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, i) => Opacity(
              opacity: 0.08,
              child: Image.asset(
                _heroImages[i],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          // Decorative geometric elements
          _buildDecorations(isMobile),
          // Main content
          LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth =
                  (isMobile
                          ? constraints.maxWidth - 32
                          : (constraints.maxWidth > 1200 ? 640 : 540))
                      .toDouble();
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 48.0,
                  vertical: isMobile ? 50 : 60,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _orange.withOpacity(0.5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: _orange.withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _orange,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _orange.withOpacity(0.6),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '#1 Ride-Hailing in Coimbatore',
                                style: TextStyle(
                                  color: _orangeLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        // Title
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Book a Ride\n',
                                style: TextStyle(
                                  fontSize: isMobile ? 38 : 60,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.1,
                                  letterSpacing: -1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'Instantly',
                                style: TextStyle(
                                  fontSize: isMobile ? 38 : 60,
                                  fontWeight: FontWeight.w900,
                                  color: _orange,
                                  height: 1.1,
                                  letterSpacing: -1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 22),
                        // Tagline
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _taglines[_heroPage],
                            key: ValueKey(_heroPage),
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 20,
                              color: _textMuted,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 32 : 40),
                        // CTA buttons
                        Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            // Primary CTA
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: _orange.withOpacity(0.4),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/role'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _orange,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 24 : 32,
                                    vertical: isMobile ? 16 : 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 0,
                                ),
                                icon: const Icon(Icons.local_taxi, size: 22),
                                label: Text(
                                  isMobile ? 'Book Now' : 'Book Your Ride',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: isMobile ? 15 : 17,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                            // Secondary CTA
                            OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1.5,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 20 : 28,
                                  vertical: isMobile ? 16 : 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_circle_outline,
                                size: 20,
                              ),
                              label: Text(
                                'How it Works',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isMobile ? 14 : 16,
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
          // Dots
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _heroImages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _heroPage == i ? 32 : 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _heroPage == i ? _orange : Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorations(bool isMobile) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulse = 0.6 + (_pulseController.value * 0.4);
        return Stack(
          children: [
            // Large orange glow - top right
            Positioned(
              top: -80,
              right: isMobile ? -60 : 60,
              child: Container(
                width: isMobile ? 250 : 400,
                height: isMobile ? 250 : 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _orange.withOpacity(0.12 * pulse),
                      _orange.withOpacity(0.04 * pulse),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Sky blue glow - bottom left
            Positioned(
              bottom: -40,
              left: isMobile ? -40 : 80,
              child: Container(
                width: isMobile ? 200 : 300,
                height: isMobile ? 200 : 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _sky.withOpacity(0.1 * pulse),
                      _sky.withOpacity(0.03 * pulse),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Small accent circles for desktop
            if (!isMobile)
              Positioned(
                top: 120,
                right: 200,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _orange.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: _orange.withOpacity(0.3),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
            if (!isMobile)
              Positioned(
                bottom: 140,
                right: 300,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _skyLight.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(color: _sky.withOpacity(0.3), blurRadius: 8),
                    ],
                  ),
                ),
              ),
            // Subtle grid pattern on desktop
            if (!isMobile)
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                width: 400,
                child: Opacity(
                  opacity: 0.03,
                  child: CustomPaint(painter: _GridPainter()),
                ),
              ),
          ],
        );
      },
    );
  }

  // ═══════════════════════════════════════════
  //  STATS STRIP (floating above sections)
  // ═══════════════════════════════════════════
  Widget _buildStatsStrip(bool isMobile) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 20 : 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statItem('50K+', 'Happy Rides', _orange, Icons.local_taxi),
              _statDivider(),
              _statItem('4.8', 'User Rating', _sky, Icons.star_rounded),
              _statDivider(),
              _statItem('1000+', 'Active Drivers', _orangeLight, Icons.people),
              if (!isMobile) ...[
                _statDivider(),
                _statItem(
                  '15+',
                  'Cities Covered',
                  _skyLight,
                  Icons.location_city,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label, Color color, IconData icon) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: _navy,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      width: 1,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFFE2E8F0),
    );
  }

  // ═══════════════════════════════════════════
  //  FEATURE SECTION
  // ═══════════════════════════════════════════
  Widget _buildFeatureSection(bool isMobile) {
    final features = [
      _FeatureData(
        Icons.bolt,
        'Instant Booking',
        'Book in under 10 seconds',
        _orange,
        _surfaceWarm,
      ),
      _FeatureData(
        Icons.security_rounded,
        'Safe & Verified',
        'Fully verified drivers',
        const Color(0xFF10B981),
        const Color(0xFFECFDF5),
      ),
      _FeatureData(
        Icons.route_rounded,
        'Live Tracking',
        'Real-time ride tracking',
        _sky,
        const Color(0xFFF0F9FF),
      ),
      _FeatureData(
        Icons.schedule_rounded,
        'Schedule Rides',
        'Plan ahead anytime',
        const Color(0xFF8B5CF6),
        const Color(0xFFF5F3FF),
      ),
      _FeatureData(
        Icons.directions_car_rounded,
        'Fleet Variety',
        'Mini to Traveller',
        _orangeDark,
        _surfaceWarm,
      ),
      _FeatureData(
        Icons.support_agent,
        '24/7 Support',
        'Always here for you',
        _skyDark,
        const Color(0xFFF0F9FF),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 70,
        horizontal: isMobile ? 20 : 48,
      ),
      color: _surfaceLight,
      child: Column(
        children: [
          _sectionHeader(
            'Why Choose Us',
            'Premium features that make every ride exceptional',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 550
                  ? 2
                  : 1;
              final cardWidth =
                  (constraints.maxWidth - (crossCount - 1) * 16) / crossCount;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: features
                    .map(
                      (f) => SizedBox(
                        width: cardWidth - 1,
                        child: _buildFeatureCard(f),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(_FeatureData f) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: f.bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(f.icon, size: 26, color: f.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  f.subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: _textMuted,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  TRIP TYPES SECTION
  // ═══════════════════════════════════════════
  Widget _buildTripSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 70,
        horizontal: isMobile ? 20 : 48,
      ),
      color: Colors.white,
      child: Column(
        children: [
          _sectionHeader(
            'Trip Types',
            'Every journey deserves the right ride option',
          ),
          const SizedBox(height: 36),
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _tripController,
              itemCount: _tripTypes.length,
              onPageChanged: (i) => setState(() => _tripPage = i),
              itemBuilder: (_, i) => _buildTripCard(_tripTypes[i], i),
            ),
          ),
          const SizedBox(height: 20),
          _dots(_tripTypes.length, _tripPage),
        ],
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip, int index) {
    final isHovered = _tripHoverIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _tripHoverIndex = index),
        onExit: (_) => setState(() => _tripHoverIndex = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? _orange.withOpacity(0.15)
                    : Colors.black.withOpacity(0.06),
                blurRadius: isHovered ? 30 : 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: isHovered
                  ? _orange.withOpacity(0.3)
                  : const Color(0xFFE2E8F0),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with overlay
                SizedBox(
                  height: 220,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        trip['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: _navy.withOpacity(0.05),
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: _textMuted,
                            ),
                          ),
                        ),
                      ),
                      // Bottom gradient scrim
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Icon badge
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _orange,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: _orange.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            trip['icon'] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['title'] as String,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            trip['description'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: _textSecondary,
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _navy,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  CORPORATE SECTION
  // ═══════════════════════════════════════════
  Widget _buildCorporateSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : 48,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_navy, _navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final narrow = c.maxWidth < 800;
          final imageWidget = Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/corporate_left.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    color: _slate,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business_center,
                      size: 60,
                      color: _orange,
                    ),
                  ),
                ),
              ),
            ),
          );
          final textWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'CORPORATE',
                  style: TextStyle(
                    color: _orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Business Travel\nSimplified.',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.15,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '24/7 support, experienced drivers, comfortable rides, and special corporate rates for seamless business travel.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  _corpPerk(Icons.verified_user, 'Verified'),
                  const SizedBox(width: 24),
                  _corpPerk(Icons.access_time_filled, '24/7'),
                  const SizedBox(width: 24),
                  _corpPerk(Icons.receipt_long, 'Invoicing'),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: _sky.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _sky,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Get Corporate Plan',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          );
          if (narrow) {
            return Column(
              children: [imageWidget, const SizedBox(height: 40), textWidget],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: imageWidget),
              const SizedBox(width: 60),
              Expanded(child: textWidget),
            ],
          );
        },
      ),
    );
  }

  Widget _corpPerk(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _orange, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════
  //  CAB TYPES SECTION
  // ═══════════════════════════════════════════
  Widget _buildCabSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 70,
        horizontal: isMobile ? 20 : 48,
      ),
      color: _surfaceLight,
      child: Column(
        children: [
          _sectionHeader(
            'Our Fleet',
            'Premium vehicles for every kind of traveller',
          ),
          const SizedBox(height: 36),
          SizedBox(
            height: 420,
            child: PageView.builder(
              controller: _cabController,
              itemCount: _cabTypes.length,
              onPageChanged: (i) => setState(() => _cabPage = i),
              itemBuilder: (_, i) => _buildCabCard(_cabTypes[i]),
            ),
          ),
          const SizedBox(height: 20),
          _dots(_cabTypes.length, _cabPage),
        ],
      ),
    );
  }

  Widget _buildCabCard(Map<String, String> cab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      cab['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _surfaceLight,
                        child: const Center(
                          child: Icon(
                            Icons.directions_car_filled,
                            size: 60,
                            color: _textMuted,
                          ),
                        ),
                      ),
                    ),
                    // Price badge
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          cab['price'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: _orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cab['title']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _textPrimary,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: _sky.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.person, size: 14, color: _sky),
                                const SizedBox(width: 4),
                                Text(
                                  '${cab['seats']} seats',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: _sky,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cab['description']!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _navy,
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Select Vehicle',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  //  CTA SECTION
  // ═══════════════════════════════════════════
  Widget _buildCTASection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : 48,
      ),
      color: Colors.white,
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(isMobile ? 32 : 56),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_orange, _orangeDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: _orange.withOpacity(0.3),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.local_taxi, color: Colors.white, size: 44),
              const SizedBox(height: 20),
              Text(
                'Ready to Ride?',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Download the app or book directly from the web.\nYour next ride is just a tap away.',
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  color: Colors.white.withOpacity(0.85),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/role'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.rocket_launch, size: 20),
                    label: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.phone_android, size: 20),
                    label: const Text(
                      'Download App',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
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
  }

  // ═══════════════════════════════════════════
  //  FOOTER
  // ═══════════════════════════════════════════
  Widget _buildFooter(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: isMobile ? 20 : 48,
      ),
      color: _navy,
      child: Column(
        children: [
          // Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.local_taxi,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'SignTaxi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Your trusted ride partner in Coimbatore',
            style: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 28),
          // Contact
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _footerPill(Icons.phone, '+91 9876543210'),
                const SizedBox(width: 12),
                _footerPill(Icons.email_outlined, 'support@signtaxi.com'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Social
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),
              const SizedBox(width: 10),
              _socialIcon(Icons.telegram),
              const SizedBox(width: 10),
              _socialIcon(Icons.language),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.08),
          ),
          const SizedBox(height: 20),
          Text(
            '© 2026 SignTaxi. All rights reserved.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _orange, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Icon(icon, color: Colors.white.withOpacity(0.5), size: 18),
    );
  }

  // ═══════════════════════════════════════════
  //  SHARED WIDGETS
  // ═══════════════════════════════════════════
  Widget _sectionHeader(String title, String subtitle) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: _orange,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _orange,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: _orange,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: _textPrimary,
            letterSpacing: -0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _dots(int count, int current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == current ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == current ? _orange : const Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

// ── Data class for features ──
class _FeatureData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color bgColor;
  const _FeatureData(
    this.icon,
    this.title,
    this.subtitle,
    this.color,
    this.bgColor,
  );
}

// ── Grid pattern painter for hero decoration ──
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
