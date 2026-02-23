import 'package:flutter/material.dart';
import '../../common/custom_app_bar.dart';
import '../../common/custom_bottom_navbar.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  int _currentNavIndex = 0;
  int _selectedVehicle = 0;
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  // ── Colors ──
  static const _primary = Color(0xFFF97316);
  static const _primaryLight = Color(0xFFFB923C);
  static const _secondary = Color(0xFF0EA5E9);
  static const _accent = Color(0xFF38BDF8);
  static const _bg = Color(0xFFF0F9FF);
  static const _surface = Color(0xFFFFFFFF);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF475569);
  static const _success = Color(0xFF22C55E);
  static const _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: CustomAppBar(
        title: 'SignTaxi',
        backgroundColor: _primary,
        actions: [
          IconButton(
            icon: Badge(
              label: const Text('2', style: TextStyle(fontSize: 10)),
              child: const Icon(Icons.notifications_outlined, size: 22),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Bottom Nav Bar ──
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onItemTapped: (i) => setState(() => _currentNavIndex = i),
        items: [
          BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          BottomNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: 'My Rides',
          ),
          BottomNavItem(
            icon: Icons.local_offer_outlined,
            activeIcon: Icons.local_offer,
            label: 'Offers',
          ),
          BottomNavItem(
            icon: Icons.account_circle_outlined,
            activeIcon: Icons.account_circle,
            label: 'Account',
          ),
        ],
      ),

      // ── Body ──
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildHomeTab(),
          _buildMyRidesTab(),
          _buildOffersTab(),
          _buildAccountTab(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  HOME TAB
  // ═══════════════════════════════════════════════
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header with solid orange ──
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            decoration: const BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Morning! 👋',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Where are you going?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                // ── Location bar ──
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _locationField(
                        controller: _pickupController,
                        hint: 'Pickup location',
                        icon: Icons.circle,
                        iconColor: _success,
                        iconSize: 10,
                      ),
                      Divider(
                        height: 1,
                        color: _border,
                        indent: 46,
                        endIndent: 16,
                      ),
                      _locationField(
                        controller: _dropController,
                        hint: 'Where to?',
                        icon: Icons.location_on,
                        iconColor: Colors.redAccent,
                        iconSize: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Quick actions ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                _quickAction(
                  Icons.schedule,
                  'Schedule',
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 12),
                _quickAction(Icons.bookmark_border, 'Saved', _primaryLight),
                const SizedBox(width: 12),
                _quickAction(Icons.history, 'Recent', _secondary),
                const SizedBox(width: 12),
                _quickAction(Icons.flight, 'Airport', const Color(0xFF8B5CF6)),
              ],
            ),
          ),

          // ── Vehicle type section ──
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Text(
              'Choose your ride',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _vehicleCard(0, 'Mini', '₹100', Icons.directions_car, _accent),
                _vehicleCard(
                  1,
                  'Sedan',
                  '₹150',
                  Icons.directions_car,
                  _primaryLight,
                ),
                _vehicleCard(2, 'SUV', '₹200', Icons.directions_car, _primary),
                _vehicleCard(
                  3,
                  'Premium',
                  '₹300',
                  Icons.directions_car,
                  const Color(0xFF8B5CF6),
                ),
              ],
            ),
          ),

          // ── Book Now button ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/searching'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_taxi, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Promo banner ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.local_offer,
                      color: Color(0xFFB45309),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '20% off your first ride!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF78350F),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Use code WELCOME20',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF92400E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFF92400E),
                  ),
                ],
              ),
            ),
          ),

          // ── Recent rides ──
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 10),
            child: Text(
              'Recent Rides',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          _recentRideCard(
            'MG Road → Airport',
            'Yesterday, 3:45 PM',
            '₹340',
            Icons.flight_takeoff,
          ),
          _recentRideCard(
            'Home → Office',
            'Feb 20, 9:10 AM',
            '₹120',
            Icons.work,
          ),
          _recentRideCard(
            'Mall → Home',
            'Feb 18, 7:30 PM',
            '₹180',
            Icons.shopping_bag,
          ),

          // ── Safety section ──
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Safety Features',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _safetyChip(Icons.shield, 'Verified Drivers'),
                const SizedBox(width: 8),
                _safetyChip(Icons.share_location, 'Live Tracking'),
                const SizedBox(width: 8),
                _safetyChip(Icons.sos, 'SOS Button'),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  MY RIDES TAB
  // ═══════════════════════════════════════════════
  Widget _buildMyRidesTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'My Rides',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _rideHistoryCard(
          'MG Road → Airport',
          'Feb 23, 3:45 PM',
          '₹340',
          'Completed',
          _success,
        ),
        _rideHistoryCard(
          'Home → Office',
          'Feb 20, 9:10 AM',
          '₹120',
          'Completed',
          _success,
        ),
        _rideHistoryCard(
          'Mall → Home',
          'Feb 18, 7:30 PM',
          '₹180',
          'Completed',
          _success,
        ),
        _rideHistoryCard(
          'Station → Hotel',
          'Feb 15, 11:00 AM',
          '₹260',
          'Cancelled',
          Colors.redAccent,
        ),
        _rideHistoryCard(
          'Airport → Home',
          'Feb 12, 6:20 PM',
          '₹380',
          'Completed',
          _success,
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  //  OFFERS TAB
  // ═══════════════════════════════════════════════
  Widget _buildOffersTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Offers & Rewards',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _offerCard(
          'WELCOME20',
          '20% off your first ride',
          'Valid till Mar 31',
          const Color(0xFFF59E0B),
        ),
        _offerCard(
          'WEEKEND50',
          '₹50 off weekend rides',
          'Sat & Sun only',
          _primaryLight,
        ),
        _offerCard(
          'AIRPORT15',
          '15% off airport pickups',
          'No min fare',
          const Color(0xFF8B5CF6),
        ),
        _offerCard(
          'REFER100',
          '₹100 for each referral',
          'Unlimited referrals',
          _success,
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  //  ACCOUNT TAB
  // ═══════════════════════════════════════════════
  Widget _buildAccountTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Profile header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, size: 36, color: Colors.white),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vignesh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '+91 98765 43210',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _accountTile(Icons.payment, 'Payment Methods'),
        _accountTile(Icons.location_on_outlined, 'Saved Addresses'),
        _accountTile(Icons.security, 'Safety'),
        _accountTile(Icons.people_outline, 'Refer & Earn'),
        _accountTile(Icons.help_outline, 'Help & Support'),
        _accountTile(Icons.info_outline, 'About'),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  //  HELPER WIDGETS
  // ═══════════════════════════════════════════════

  Widget _locationField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    double iconSize = 14,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: _textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _textSecondary, fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleCard(
    int index,
    String name,
    String price,
    IconData icon,
    Color color,
  ) {
    final selected = _selectedVehicle == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedVehicle = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 105,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? color : _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : _border,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withOpacity(0.2)
                    : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: selected ? Colors.white : _textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: selected ? Colors.white70 : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentRideCard(
    String route,
    String date,
    String fare,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _primaryLight, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 11, color: _textSecondary),
                  ),
                ],
              ),
            ),
            Text(
              fare,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: _primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: _success.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _success.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _success, size: 14),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF065F46),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rideHistoryCard(
    String route,
    String date,
    String fare,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.directions_car,
              color: _primaryLight,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(fontSize: 11, color: _textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fare,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: _primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                status,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _offerCard(String code, String title, String validity, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.withOpacity(0.3),
                style: BorderStyle.solid,
              ),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  validity,
                  style: const TextStyle(fontSize: 11, color: _textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: _textSecondary),
        ],
      ),
    );
  }

  Widget _accountTile(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: _textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: _textSecondary,
      ),
      onTap: () {},
    );
  }
}
