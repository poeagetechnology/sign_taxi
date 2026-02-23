import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignTaxi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  // ── Modern Color Palette ──
  static const _primary = Color(0xFF7C3AED); // Vibrant purple
  static const _secondary = Color(0xFF06B6D4); // Cyan
  static const _accent = Color(0xFFF59E0B); // Amber
  static const _gradientStart = Color(0xFF8B5CF6);
  static const _gradientEnd = Color(0xFFEC4899); // Pink
  static const _bg = Color(0xFFF9FAFB);
  static const _textPrimary = Color(0xFF111827);
  static const _textSecondary = Color(0xFF6B7280);

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

  // Trip types
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
      'icon': Icons.route,
      'color': Color(0xFFEF4444),
    },
    {
      'title': 'Hourly Rental',
      'description':
          'Make multiple stops, wait as needed. Book from 1 to 12 hours at your convenience.',
      'image': 'assets/images/taxi2.jpg',
      'icon': Icons.access_time,
      'color': Color(0xFF10B981),
    },
    {
      'title': 'Airport Taxi',
      'description':
          'Punctual pickups, transparent fares, and experienced drivers for stress-free airport transfers.',
      'image': 'assets/images/taxi3.jpg',
      'icon': Icons.flight,
      'color': Color(0xFF3B82F6),
    },
    {
      'title': 'Round Trip',
      'description':
          'Flexible waiting times and multiple stops. Perfect for weekend getaways and family trips.',
      'image': 'assets/images/taxi1.jpg',
      'icon': Icons.sync_alt,
      'color': Color(0xFFF59E0B),
    },
    {
      'title': 'Bulk Booking',
      'description':
          'Fleet coordination, special rates, and timely service for events and groups.',
      'image': 'assets/images/taxi2.jpg',
      'icon': Icons.groups,
      'color': Color(0xFF8B5CF6),
    },
  ];

  // Cab types
  late PageController _cabController;
  late Timer _cabTimer;
  int _cabPage = 0;

  final List<Map<String, dynamic>> _cabTypes = [
    {
      'title': 'Sedan',
      'description': 'Business Class Comfort',
      'image': 'assets/images/sedan.jpg',
      'icon': Icons.directions_car,
      'price': '₹12/km',
      'capacity': '4 Seats',
    },
    {
      'title': 'Mini',
      'description': 'Economy Class Ride',
      'image': 'assets/images/mini.jpg',
      'icon': Icons.directions_car,
      'price': '₹10/km',
      'capacity': '4 Seats',
    },
    {
      'title': 'SUV',
      'description': 'Spacious Family Trips',
      'image': 'assets/images/suv.jpg',
      'icon': Icons.directions_car,
      'price': '₹18/km',
      'capacity': '7 Seats',
    },
    {
      'title': 'Pink Taxi',
      'description': 'Safe rides by women, for women',
      'image': 'assets/images/pink.jpg',
      'icon': Icons.female,
      'price': '₹14/km',
      'capacity': '4 Seats',
    },
    {
      'title': 'Traveller',
      'description': 'Perfect for large groups',
      'image': 'assets/images/traveller.jpg',
      'icon': Icons.airport_shuttle,
      'price': '₹22/km',
      'capacity': '12 Seats',
    },
  ];

  // Testimonials
  final List<Map<String, String>> _testimonials = [
    {
      'name': 'Rahul Sharma',
      'role': 'Business Traveler',
      'comment':
          'Best taxi service in Coimbatore! Always on time and professional drivers.',
      'rating': '5.0',
      'image': 'assets/images/user1.jpg',
    },
    {
      'name': 'Priya Venkatesh',
      'role': 'Frequent Flyer',
      'comment':
          'Airport transfers are seamless. Love the Pink Taxi service for safety.',
      'rating': '4.9',
      'image': 'assets/images/user2.jpg',
    },
    {
      'name': 'Karthik Rajan',
      'role': 'Tourist',
      'comment':
          'Great experience with outstation cabs. Comfortable and affordable.',
      'rating': '5.0',
      'image': 'assets/images/user3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();

    // Auto-scroll timers
    _heroTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final next = (_heroPage + 1) % _heroImages.length;
      _heroController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });

    _tripController = PageController(viewportFraction: 0.85);
    _tripTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_tripPage + 1) % _tripTypes.length;
      _tripController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });

    _cabController = PageController(viewportFraction: 0.85);
    _cabTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_cabPage + 1) % _cabTypes.length;
      _cabController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
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
    _fadeController.dispose();
    _slideController.dispose();
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
            // ── Modern Glassmorphism Navigation ──
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 60 : 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    // Animated Logo
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_gradientStart, _gradientEnd],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_taxi,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [_gradientStart, _gradientEnd],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'SignTaxi',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isWideScreen) ...[
                      _navLink('Home'),
                      _navLink('My Rides'),
                      _navLink('Offers'),
                      _navLink('About'),
                      const SizedBox(width: 16),
                    ],
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_gradientStart, _gradientEnd],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _gradientStart.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/role'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: isWideScreen ? 28 : 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
            ),

            // ── Modern Hero Section with Gradient Overlay ──
            SizedBox(
              height: 600,
              child: Stack(
                children: [
                  // Background Images
                  PageView.builder(
                    controller: _heroController,
                    itemCount: _heroImages.length,
                    onPageChanged: (i) => setState(() => _heroPage = i),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (_, i) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_heroImages[i]),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.6),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Animated Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _gradientStart.withValues(alpha: 0.8),
                          _gradientEnd.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 1.0],
                      ),
                    ),
                  ),

                  // Content
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 700;
                      final contentWidth = isMobile
                          ? constraints.maxWidth - 32
                          : 600.0;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 60,
                          vertical: 40,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: SizedBox(
                                width: contentWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            isMobile
                                                ? '#1 in Coimbatore'
                                                : '#1 Ride-Hailing App in Coimbatore',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Book Your Ride',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Anytime, Anywhere',
                                      style: TextStyle(
                                        fontSize: isMobile ? 48 : 64,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        height: 1.1,
                                        letterSpacing: -1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      child: Text(
                                        _taglines[_heroPage],
                                        key: ValueKey(_heroPage),
                                        style: TextStyle(
                                          fontSize: isMobile ? 18 : 22,
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 20,
                                                offset: const Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: ElevatedButton.icon(
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                  context,
                                                  '/role',
                                                ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: _primary,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: isMobile ? 28 : 36,
                                                vertical: isMobile ? 16 : 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              elevation: 0,
                                            ),
                                            icon: const Icon(
                                              Icons.local_taxi,
                                              size: 24,
                                            ),
                                            label: Text(
                                              isMobile
                                                  ? 'Book Now'
                                                  : 'Book a Ride Now',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: isMobile ? 16 : 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                              color: Colors.white38,
                                              width: 2,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isMobile ? 24 : 32,
                                              vertical: isMobile ? 16 : 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.play_circle_outline,
                                            size: 24,
                                          ),
                                          label: Text(
                                            isMobile ? 'Watch' : 'Watch Video',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: isMobile ? 15 : 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Modern Stats Cards
                  Positioned(
                    bottom: 40,
                    right: 40,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _heroStat('50K+', 'Happy Riders'),
                          Container(
                            width: 1,
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            color: Colors.white.withOpacity(0.2),
                          ),
                          _heroStat('4.9★', 'App Rating'),
                          Container(
                            width: 1,
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            color: Colors.white.withOpacity(0.2),
                          ),
                          _heroStat('1000+', 'Active Drivers'),
                        ],
                      ),
                    ),
                  ),

                  // Modern Page Dots
                  Positioned(
                    bottom: 30,
                    left: 60,
                    child: Row(
                      children: List.generate(
                        _heroImages.length,
                        (i) => GestureDetector(
                          onTap: () {
                            _heroController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 10),
                            width: _heroPage == i ? 40 : 12,
                            height: 12,
                            decoration: BoxDecoration(
                              gradient: _heroPage == i
                                  ? const LinearGradient(
                                      colors: [Colors.white, Colors.white70],
                                    )
                                  : null,
                              color: _heroPage == i ? null : Colors.white38,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _heroPage == i
                                    ? Colors.transparent
                                    : Colors.white24,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Modern Feature Cards with Icons ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Why Choose Us?',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gradientStart, _gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _modernFeatureCard(
                            icon: Icons.bolt,
                            title: 'Instant Booking',
                            description:
                                'Book in seconds with our smart system',
                            color: _accent,
                            index: 0,
                          ),
                          _modernFeatureCard(
                            icon: Icons.schedule,
                            title: 'Schedule Rides',
                            description: 'Plan ahead with ease',
                            color: _secondary,
                            index: 1,
                          ),
                          _modernFeatureCard(
                            icon: Icons.directions_car,
                            title: 'Fleet Options',
                            description: 'Choose from 5+ car types',
                            color: _gradientStart,
                            index: 2,
                          ),
                          _modernFeatureCard(
                            icon: Icons.gps_fixed,
                            title: 'Live Tracking',
                            description: 'Real-time driver location',
                            color: _gradientEnd,
                            index: 3,
                          ),
                          _modernFeatureCard(
                            icon: Icons.shield,
                            title: 'Safe Rides',
                            description: 'Verified drivers & SOS',
                            color: Colors.green,
                            index: 4,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // ── Modern Trip Types Carousel ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gradientStart, _gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 500,
                    child: PageView.builder(
                      controller: _tripController,
                      itemCount: _tripTypes.length,
                      onPageChanged: (i) => setState(() => _tripPage = i),
                      itemBuilder: (_, i) =>
                          _buildModernTripCard(_tripTypes[i], i),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _modernDots(_tripTypes.length, _tripPage),
                ],
              ),
            ),

            // ── Modern Corporate Section ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: LayoutBuilder(
                builder: (context, c) {
                  final narrow = c.maxWidth < 800;
                  return Container(
                    padding: const EdgeInsets.all(48),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _gradientStart.withValues(alpha: 0.1),
                          _gradientEnd.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: _gradientStart.withValues(alpha: 0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: narrow
                        ? Column(
                            children: [
                              _buildCorporateImage(),
                              const SizedBox(height: 32),
                              _buildCorporateText(),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(child: _buildCorporateImage()),
                              const SizedBox(width: 48),
                              Expanded(child: _buildCorporateText()),
                            ],
                          ),
                  );
                },
              ),
            ),

            // ── Modern Cab Types Carousel ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    'Our Fleet',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gradientStart, _gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 420,
                    child: PageView.builder(
                      controller: _cabController,
                      itemCount: _cabTypes.length,
                      onPageChanged: (i) => setState(() => _cabPage = i),
                      itemBuilder: (_, i) => _buildModernCabCard(_cabTypes[i]),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _modernDots(_cabTypes.length, _cabPage),
                ],
              ),
            ),

            // ── Modern Testimonials ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'What Our Riders Say',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gradientStart, _gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: _testimonials
                            .map((t) => _buildTestimonialCard(t))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ── Modern Footer ──
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_gradientStart, _gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.local_taxi,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'SignTaxi',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your trusted ride partner in Coimbatore',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _modernFooterIcon(Icons.phone, '+91 98765 43210'),
                      const SizedBox(width: 32),
                      _modernFooterIcon(Icons.email, 'support@signtaxi.com'),
                      const SizedBox(width: 32),
                      _modernFooterIcon(Icons.location_on, 'Coimbatore'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(Icons.facebook),
                      const SizedBox(width: 16),
                      _socialIcon(Icons.telegram),
                      const SizedBox(width: 16),
                      _socialIcon(Icons.email_outlined),
                      const SizedBox(width: 16),
                      _socialIcon(Icons.message),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 1,
                    width: 200,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '© 2026 SignTaxi. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14,
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

  // ─── Modern Helper Widgets ───

  Widget _navLink(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: _textPrimary,
          overlayColor: _gradientStart.withOpacity(0.1),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _heroStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _modernFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required int index,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: _textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTripCard(Map<String, dynamic> trip, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _tripHoverIndex = index),
        onExit: (_) => setState(() => _tripHoverIndex = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..scale(_tripHoverIndex == index ? 1.02 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: (trip['color'] as Color).withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        child: Image.asset(
                          trip['image'],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            color: (trip['color'] as Color).withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                trip['icon'],
                                size: 60,
                                color: trip['color'],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Icon(
                            trip['icon'],
                            color: trip['color'],
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: trip['color'],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          trip['description'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: _textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  trip['color'],
                                  trip['color'].withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: (trip['color'] as Color).withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildModernCabCard(Map<String, dynamic> cab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: _gradientStart.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: Image.asset(
                      cab['image'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: _gradientStart.withOpacity(0.1),
                        child: Center(
                          child: Icon(
                            cab['icon'],
                            size: 60,
                            color: _gradientStart,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: _accent, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '4.9',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cab['title'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _gradientStart.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            cab['price'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _gradientStart,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cab['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: _textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.people, size: 16, color: _textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          cab['capacity'],
                          style: TextStyle(fontSize: 13, color: _textSecondary),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 1,
                          height: 12,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.ac_unit, size: 16, color: _textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          'AC',
                          style: TextStyle(fontSize: 13, color: _textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorporateImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [_gradientStart, _gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _gradientStart.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/corporate_left.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.transparent,
                child: const Center(
                  child: Icon(
                    Icons.business_center,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _gradientStart.withOpacity(0.6),
                    _gradientEnd.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorporateText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Corporate Travel',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'A ride you can count on for every business need',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _gradientStart,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'SignTaxi provides smooth business travel with 24/7 support, '
          'experienced drivers, and comfortable rides. Special corporate '
          'rates and monthly billing available for companies.',
          style: TextStyle(fontSize: 16, color: _textSecondary, height: 1.6),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _gradientStart.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.support_agent, color: _gradientStart),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '24/7 Priority Support',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  'Dedicated account manager',
                  style: TextStyle(fontSize: 14, color: _textSecondary),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_gradientStart, _gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _gradientStart.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Enquire Now',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _gradientStart.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_gradientStart, _gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    testimonial['name']![0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      testimonial['role']!,
                      style: TextStyle(fontSize: 13, color: _textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ...List.generate(5, (i) {
                return Icon(
                  Icons.star,
                  size: 16,
                  color: i < double.parse(testimonial['rating']!).round()
                      ? _accent
                      : Colors.grey.shade300,
                );
              }),
              const SizedBox(width: 8),
              Text(
                testimonial['rating']!,
                style: TextStyle(fontWeight: FontWeight.w600, color: _accent),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '"${testimonial['comment']}"',
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernDots(int count, int current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => GestureDetector(
          onTap: () {
            if (i == _tripPage) {
              _tripController.animateToPage(
                i,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == current ? 30 : 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: i == current
                  ? const LinearGradient(
                      colors: [_gradientStart, _gradientEnd],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              color: i == current ? null : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _modernFooterIcon(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }
}
