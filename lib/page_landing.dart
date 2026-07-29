import 'package:flutter/material.dart';
import 'dart:async';
import 'page_selling.dart';

class ActionLandingPage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const ActionLandingPage({super.key, required this.onThemeToggle});

  @override
  State<ActionLandingPage> createState() => _ActionLandingPageState();
}

class _ActionLandingPageState extends State<ActionLandingPage> {
  int _currentFooterIndex = 0;
  bool _expandAllVariants = false;

  // Draggable REXA Button Coordinates
  Offset rexaPosition = const Offset(20, 520);

  // Slideshow Track Indexes
  int _bannerIndex = 0;
  int _factIndex = 0;
  late Timer _slideshowTimer;

  // Infinite Marquee Train Controller
  final ScrollController _marqueeController = ScrollController();
  late Timer _marqueeTimer;

  // Mock Sourcing Validation Datasets
  final List<Map<String, dynamic>> valuationSlides = [
    {
      "name": "Apple iPhone 15 Pro Max", 
      "mrp": "₹1,39,900", 
      "payout": "₹74,500", 
      "url": "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500",
      "color": const Color(0xFFF1F5F9)
    },
    {
      "name": "MacBook Pro M3 Max", 
      "mrp": "₹2,49,900", 
      "payout": "₹1,58,000", 
      "url": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500",
      "color": const Color(0xFFE0F2FE)
    },
    {
      "name": "Sony PlayStation 5 Slim", 
      "mrp": "₹44,990", 
      "payout": "₹29,500", 
      "url": "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=500",
      "color": const Color(0xFFF5F3FF)
    }
  ];

  final List<String> marketFacts = [
    "Apple devices retain over 55% value curves after 24 operational months.",
    "RECOM. direct pre-funded escrow settlement speeds compress payouts to 180 seconds.",
    "Automated decentralized diagnostics parameter mapping drops margins variances down to 5% Max."
  ];

  final List<String> partnerLogos = ["APPLE NET", "SAMSUNG EQ", "SONY DESK", "CROMA VAL", "INTEL CORE", "DELL DISP", "RECOM LABS"];

  @override
  void initState() {
    super.initState();

    // Regular text and banner cycle timers
    _slideshowTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _bannerIndex = (_bannerIndex + 1) % valuationSlides.length;
        _factIndex = (_factIndex + 1) % marketFacts.length;
      });
    });

    // Infinite Loop Scrolling Marquee Logic Engine
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _marqueeTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        if (_marqueeController.hasClients) {
          double maxScroll = _marqueeController.position.maxScrollExtent;
          double currentScroll = _marqueeController.offset;

          // Smooth loop reset back to start edge once limit is hit
          if (currentScroll >= maxScroll - 1) {
            _marqueeController.jumpTo(0);
          } else {
            _marqueeController.jumpTo(currentScroll + 1.2);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _slideshowTimer.cancel();
    _marqueeTimer.cancel();
    _marqueeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Ambient Glow Flow Background
          Positioned(
            top: 200, right: -150,
            child: Container(
                width: 350, height: 350,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF06B6D4).withAlpha(isDark ? 25 : 10)
                )
            ),
          ),

          // Main View Stream
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 1. MASTER BRANDING ROW HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('RECOM.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF3B82F6), letterSpacing: -1)),
                        Row(
                          children: [
                            IconButton(icon: Icon(Icons.brightness_6_rounded, color: isDark ? Colors.amber : Colors.indigo), onPressed: widget.onThemeToggle),
                            IconButton(icon: const Icon(Icons.near_me_rounded, color: Color(0xFF06B6D4)), onPressed: () {}),
                          ],
                        )
                      ],
                    ),
                  ),

                  // 2. SEARCH UTILITY BAR + NOTIFICATIONS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search premium gadgets to sell...',
                                prefixIcon: const Icon(Icons.search_rounded),
                                filled: true,
                                fillColor: Theme.of(context).cardColor,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0)
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                          child: IconButton(icon: const Icon(Icons.notifications_none_rounded), onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 3. STRUCTURAL INTENT SEGMENTS MAPPINGS WITH BACKGROUND-ISOLATED TARGETS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('EXPLORE ARCHITECTURES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 1.5)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 86,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        intentBlock('Personal Devices', 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', const Color(0xFF3B82F6)),
                        intentBlock('Work Workspace', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', const Color(0xFF06B6D4)),
                        intentBlock('Household Tech', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400', const Color(0xFF10B981)),
                        intentBlock('Entertainment Gears', 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400', const Color(0xFF7C3AED)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. IMPROVED LIVE TRUST VALUATION SLIDESHOW (Clean prices, larger reference frame)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                          color: isDark ? (valuationSlides[_bannerIndex]['color'] as Color).withAlpha(40) : (valuationSlides[_bannerIndex]['color'] as Color),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: (valuationSlides[_bannerIndex]['color'] as Color).withAlpha(80), width: 1.5)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.white.withAlpha(150), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('RECENT RECOM VALUE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black87)),
                                ),
                                const SizedBox(height: 12),
                                Text(valuationSlides[_bannerIndex]['name'].toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text('Original Store Valuation: ${valuationSlides[_bannerIndex]['mrp']}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('Instant Cash Payout: ${valuationSlides[_bannerIndex]['payout']}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF059669))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Expanded, high-fidelity transparent image container frame
                          Container(
                            width: 120, height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 15, offset: const Offset(0, 5))]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(valuationSlides[_bannerIndex]['url']!, fit: BoxFit.cover),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 5. EXPANDED 12-VARIETY VAULT
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('SELECT CATEGORY RADIAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 1.5)),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                      children: [
                        categoryTile('Phones', Icons.phone_iphone_rounded),
                        categoryTile('MacBooks', Icons.laptop_mac_rounded),
                        categoryTile('Smart TVs', Icons.tv_rounded),
                        categoryTile('Tablets', Icons.tablet_mac_rounded),
                        categoryTile('Consoles', Icons.sports_esports_rounded),
                        categoryTile('Speakers', Icons.speaker_group_rounded),
                        if (_expandAllVariants) ...[
                          categoryTile('Desktops', Icons.desktop_mac_rounded),
                          categoryTile('Audio', Icons.headphones_rounded),
                          categoryTile('Cameras', Icons.camera_alt_rounded),
                          categoryTile('ACs', Icons.air_rounded),
                          categoryTile('Fridges', Icons.kitchen_rounded),
                          categoryTile('Washers', Icons.local_laundry_service_rounded),
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => setState(() => _expandAllVariants = !_expandAllVariants),
                      icon: Icon(_expandAllVariants ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: const Color(0xFF06B6D4)),
                      label: Text(_expandAllVariants ? 'Collapse Matrix' : 'See More Categories', style: const TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6. FLASH BOUNTY DAILY PANEL WITH TAP CLAUSE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bounty active index tracking context initialized.'))),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: Colors.black, // Solid base for contrast
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 15, offset: const Offset(0, 8))],
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800'),
                              fit: BoxFit.cover,
                              opacity: 0.6, // Increased opacity since red tint is gone
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('🔥 HIGH-DEMAND FLASH BOUNTY OF THE DAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
                            const SizedBox(height: 12),
                            const Text('Sony Alpha DSLR Camera Body Only', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                            const SizedBox(height: 8),
                            const Text('Guaranteed Payback: Up to ₹1,18,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70)),
                            const SizedBox(height: 16),
                            const Row(
                              children: [
                                Icon(Icons.touch_app_rounded, size: 14, color: Colors.white38),
                                SizedBox(width: 4),
                                Text('Tap this banner to lock instant payout curve metrics', style: TextStyle(fontSize: 11, color: Colors.white38, fontWeight: FontWeight.w700)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 7. PLATFORM OPERATIONS WITH SOLID "RECOM." BACKGROUND FILL WATERMARK
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('RECOM. MARKET OPERATIONS INTELLIGENCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 1.5)),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF3B82F6).withAlpha(60))
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Luxury Background Fill Watermark Text
                          Text(
                              'RECOM.',
                              style: TextStyle(
                                  fontSize: 68,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF06B6D4).withAlpha(isDark ? 30 : 30),
                                  letterSpacing: -2.5
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.verified_user_rounded, color: Color(0xFF10B981), size: 28),
                                const SizedBox(height: 8),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                      marketFacts[_factIndex],
                                      key: ValueKey(_factIndex),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 8. INFINITE LOGISTICS CONTINUOUS ROLLING TRAIN MARQUEE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('TRUSTED LIQUIDATION & OEM PARTNERS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 1.5)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      controller: _marqueeController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(), // Handled entirely via code animation loop
                      itemCount: partnerLogos.length * 20,
                      itemBuilder: (context, index) {
                        final partner = partnerLogos[index % partnerLogos.length];
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(color: const Color(0xFF2D3748)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                              child: Text(
                                  partner,
                                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF64748B))
                              )
                          ),
                        );
                      },
                    ),
                  )

                ],
              ),
            ),
          ),

          // 🎯 9. EXTENDED PILL EXPANDED "ASK REXA" MOVABLE ORB
          Positioned(
            left: rexaPosition.dx,
            top: rexaPosition.dy,
            child: Draggable(
              feedback: floatingRexaWidget(true),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  // Safety threshold clamp so button doesn't drag completely off screen edges
                  rexaPosition = Offset(
                      details.offset.dx.clamp(10.0, MediaQuery.of(context).size.width - 150.0),
                      details.offset.dy.clamp(50.0, MediaQuery.of(context).size.height - 150.0)
                  );
                });
              },
              child: floatingRexaWidget(false),
            ),
          ),
        ],
      ),

      // 10. UNIFIED CONTROL FOOTER TRACK PANELS
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF2D3748), width: 0.5))),
        child: BottomNavigationBar(
          currentIndex: _currentFooterIndex,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SellFlowPage()));
            } else {
              setState(() => _currentFooterIndex = index);
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: const Color(0xFF06B6D4),
          unselectedItemColor: const Color(0xFF64748B),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_max_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bolt_rounded), label: 'Sell'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_rounded), label: 'Deals'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget intentBlock(String label, String imageUrl, Color highlightColor) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SellFlowPage(initialCategory: label))),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [highlightColor.withAlpha(40), highlightColor.withAlpha(10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: highlightColor.withAlpha(60), width: 1.5)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 3))
                ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.devices_other_rounded, color: highlightColor, size: 28),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Text(label, style: TextStyle(fontWeight: FontWeight.w900, color: highlightColor, fontSize: 14, letterSpacing: -0.2)),
          ],
        ),
      ),
    );
  }

  Widget categoryTile(String title, IconData icon) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SellFlowPage(initialCategory: title))),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor, border: Border.all(color: const Color(0xFF2D3748)), borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF06B6D4), size: 24),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  // UPGRADED "ASK REXA" FLOATING PILL BADGE WIDGET
  Widget floatingRexaWidget(bool isDragging) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF06B6D4).withAlpha(120),
                  blurRadius: isDragging ? 22 : 12,
                  offset: const Offset(0, 4)
              )
            ]
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.psychology_rounded, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text(
                'Ask REXA',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.2)
            ),
          ],
        ),
      ),
    );
  }
}