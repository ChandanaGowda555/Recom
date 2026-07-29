import 'package:flutter/material.dart';

class SellFlowPage extends StatefulWidget {
  final String? initialCategory;
  const SellFlowPage({super.key, this.initialCategory});

  @override
  State<SellFlowPage> createState() => _SellFlowPageState();
}

class _SellFlowPageState extends State<SellFlowPage> {
  int _currentStep = 0;
  String? _selectedCategory;
  String? _selectedBrand;
  String? _selectedModel;
  
  // Step 2 Diagnostic state
  bool _powersOn = true;
  String? _activeDiagnosticItem;
  final Map<String, String> _diagnosticSelections = {};
  
  final List<String> _diagnosticQuestions = [
    "Screen & Display",
    "Body & Back Panel",
    "Battery & Charging",
    "Camera Performance",
    "Speaker & Mic",
    "Buttons & Ports",
  ];

  final Map<String, bool> _accessories = {
    "Original Box": true,
    "Original Charger": true,
    "Valid Bill": true,
    "Warranty Remaining": false,
  };

  final List<String> _steps = [
    'Selection',
    'Diagnostic',
    'Quote Lock',
    'Evaluation'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory;
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_steps[_currentStep].toUpperCase(), 
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        centerTitle: true,
        leading: _currentStep > 0 
          ? IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18), onPressed: _prevStep)
          : IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildCurrentStepView(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _currentStep < 3 ? _buildBottomAction(isDark) : null,
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Row(
        children: List.generate(_steps.length, (index) {
          bool isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF3B82F6) : Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepView() {
    switch (_currentStep) {
      case 0:
        return _buildVariantSelection();
      case 1:
        return _buildDiagnosticAssessment();
      case 2:
        return _buildAddressAndQuote();
      case 3:
        return _buildSuccessStep();
      default:
        return Container();
    }
  }

  // --- STEP 1: VARIANT SELECTION ---
  Widget _buildVariantSelection() {
    if (_selectedCategory == null) {
      return _buildGridPicker("Select Category", [
        {'name': 'Phones', 'img': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300'},
        {'name': 'MacBooks', 'img': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300'},
        {'name': 'Smart TVs', 'img': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300'},
        {'name': 'Tablets', 'img': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300'},
        {'name': 'Consoles', 'img': 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=300'},
        {'name': 'Speakers', 'img': 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=300'},
        {'name': 'Desktops', 'img': 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=300'},
        {'name': 'Audio', 'img': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300'},
        {'name': 'Cameras', 'img': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300'},
        {'name': 'ACs', 'img': 'https://images.unsplash.com/photo-1585338107529-13afc5f02586?w=300'},
        {'name': 'Fridges', 'img': 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=300'},
        {'name': 'Washers', 'img': 'https://images.unsplash.com/photo-1626806819282-2c1dc01a5e0c?w=300'},
      ], (val) => setState(() => _selectedCategory = val));
    }
    if (_selectedBrand == null) {
      return _buildGridPicker("Select Brand", [
        {'name': 'Apple', 'icon': Icons.apple},
        {'name': 'Samsung', 'icon': Icons.smartphone},
        {'name': 'Sony', 'icon': Icons.camera_alt},
        {'name': 'Dell', 'icon': Icons.computer},
      ], (val) => setState(() => _selectedBrand = val));
    }
    return _buildListPicker("Select Model & Variant", [
      "iPhone 15 Pro Max (256 GB)",
      "iPhone 15 Pro Max (512 GB)",
      "iPhone 14 Plus (128 GB)",
      "Samsung S24 Ultra (512 GB)",
      "Sony Bravia OLED 55\"",
      "MacBook Pro M3 (16GB RAM)",
    ], (val) => setState(() => _selectedModel = val));
  }

  // --- STEP 2: DIAGNOSTIC ASSESSMENT ---
  Widget _buildDiagnosticAssessment() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text("Physical Condition", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // Power On State
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.withAlpha(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text("Does device power on?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChoiceChip(
                    label: const Text("YES", style: TextStyle(fontSize: 12)), 
                    selected: _powersOn,
                    onSelected: (val) => setState(() => _powersOn = true),
                    selectedColor: const Color(0xFF3B82F6).withAlpha(40),
                    labelStyle: TextStyle(color: _powersOn ? const Color(0xFF3B82F6) : Colors.grey, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 4),
                  ChoiceChip(
                    label: const Text("NO", style: TextStyle(fontSize: 12)), 
                    selected: !_powersOn,
                    onSelected: (val) => setState(() => _powersOn = false),
                    selectedColor: Colors.red.withAlpha(40),
                    labelStyle: TextStyle(color: !_powersOn ? Colors.red : Colors.grey, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        const Text("Diagnostics Checklist", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
        const SizedBox(height: 12),
        
        // Dynamic Question List
        ..._diagnosticQuestions.map((question) {
          bool isExpanded = _activeDiagnosticItem == question;
          String? selection = _diagnosticSelections[question];

          return Column(
            children: [
              ListTile(
                onTap: () => setState(() => _activeDiagnosticItem = isExpanded ? null : question),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                tileColor: Theme.of(context).cardColor,
                title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: selection != null ? Text(selection, style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)) : null,
                trailing: Icon(isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded),
              ),
              if (isExpanded) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    _conditionCard(question, "Excellent", "Flawless screen & body"),
                    const SizedBox(width: 8),
                    _conditionCard(question, "Good", "Light signs of usage"),
                    const SizedBox(width: 8),
                    _conditionCard(question, "Fair", "Scratches / Minor dents"),
                  ],
                ),
              ],
              const SizedBox(height: 8),
            ],
          );
        }),

        const SizedBox(height: 24),
        const Text("Included Accessories", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
        const SizedBox(height: 12),
        
        ..._accessories.keys.map((key) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CheckboxListTile(
            value: _accessories[key], 
            onChanged: (val) => setState(() => _accessories[key] = val!),
            title: Text(key, style: const TextStyle(fontWeight: FontWeight.w600)),
            tileColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            activeColor: const Color(0xFF3B82F6),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        )),
      ],
    );
  }

  Widget _conditionCard(String question, String title, String desc) {
    bool isSelected = _diagnosticSelections[question] == title;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _diagnosticSelections[question] = title;
          _activeDiagnosticItem = null; // Close after selection
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3B82F6).withAlpha(20) : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.withAlpha(30), width: 2),
          ),
          child: Column(
            children: [
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isSelected ? const Color(0xFF3B82F6) : null)),
              const SizedBox(height: 4),
              Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // --- STEP 3: ADDRESS & QUOTE ---
  Widget _buildAddressAndQuote() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text("YOUR FINAL QUOTE", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                
                // Rolling Price Animation
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 42500),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutExpo,
                  builder: (context, value, child) {
                    return Text(
                      "₹${value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 48)
                    );
                  },
                ),

                const SizedBox(height: 8),
                const Text("Valid for 48 hours", style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text("Pickup Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: "Pincode",
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Full Address with Landmark",
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 4: SUCCESS ---
  Widget _buildSuccessStep() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, size: 64, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text("Pickup Scheduled!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text("Our agent will arrive within 24 hours.", style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text("BACK TO HOME", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // --- HELPER UI COMPONENTS ---
  Widget _buildGridPicker(String title, List<Map<String, dynamic>> items, Function(String) onSelect, {bool isLogo = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.1
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onSelect(items[index]['name']),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.withAlpha(30)),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10, offset: const Offset(0, 4))]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (items[index].containsKey('img'))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          items[index]['img'],
                          height: isLogo ? 40 : 80,
                          width: isLogo ? 100 : 120,
                          fit: isLogo ? BoxFit.contain : BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            isLogo ? Icons.business_rounded : Icons.devices_other_rounded,
                            size: isLogo ? 30 : 50,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    else if (items[index].containsKey('icon'))
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(items[index]['icon'], color: Colors.white, size: 30),
                      ),
                    const SizedBox(height: 12),
                    Text(items[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListPicker(String title, List<String> options, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: options.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                onTap: () => onSelect(options[index]),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                tileColor: Theme.of(context).cardColor,
                title: Text(options[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(bool isDark) {
    bool canProceed = false;
    if (_currentStep == 0 && _selectedModel != null) canProceed = true;
    if (_currentStep == 1) canProceed = true;
    if (_currentStep == 2) canProceed = true;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed: canProceed ? _nextStep : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text("CONTINUE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
    );
  }
}
