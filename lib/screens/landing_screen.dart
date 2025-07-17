import 'package:event_ticket_booking1/color.dart';
import 'package:event_ticket_booking1/local/app_localizations.dart';
import 'package:flutter/material.dart';
import 'booking_form_screen.dart';

class LandingScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeModeNotifier;
  final ValueNotifier<Locale>? localeNotifier;
  const LandingScreen({Key? key, this.themeModeNotifier, this.localeNotifier})
      : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class TicketType {
  final String name;
  final String description;
  final double price;
  final String image;

  TicketType({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

// ... استيراد الباقات كما هو

class _LandingScreenState extends State<LandingScreen> {
  final List<TicketType> ticketTypes = [
    TicketType(
        name: 'ticket_general',
        description: 'desc_general',
        price: 50.0,
        image: 'assets/image/general.jpg'),
    TicketType(
        name: 'ticket_student',
        description: 'desc_student',
        price: 30.0,
        image: 'assets/image/student.jpg'),
    TicketType(
        name: 'ticket_vip',
        description: 'desc_vip',
        price: 120.0,
        image: 'assets/image/vip1.jpg'),
    TicketType(
        name: 'ticket_group',
        description: 'desc_group',
        price: 200.0,
        image: 'assets/image/group.jpg'),
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violetBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.get('select_ticket'),
          style:
              const TextStyle(color: violetBlue2, fontWeight: FontWeight.bold),
        ),
        backgroundColor: violetBlue3,
        actions: [
          if (widget.localeNotifier != null)
            ValueListenableBuilder<Locale>(
              valueListenable: widget.localeNotifier!,
              builder: (context, locale, _) => IconButton(
                icon: Icon(Icons.language),
                tooltip: 'Change Language',
                onPressed: () {
                  widget.localeNotifier!.value = locale.languageCode == 'en'
                      ? const Locale('de')
                      : const Locale('en');
                },
              ),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: ticketTypes.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final ticket = ticketTypes[index];
          final isSelected = selectedIndex == index;

          return Center(
            child: Card(
              color: violetBlue2,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? violetBlue3 : Colors.transparent,
                  width: 2,
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: selectedIndex,
                        activeColor: violetBlue3,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          ticket.image,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.get(ticket.name),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: violetBlue3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppLocalizations.of(context)!
                                  .get(ticket.description),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '\$${ticket.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedIndex != null
              ? () {
                  final selectedTicket = ticketTypes[selectedIndex!];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingFormScreen(ticketType: selectedTicket),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedIndex != null ? violetBlue3 : const Color(0xFFE0E0E0),
            foregroundColor: selectedIndex != null ? violetBlue2 : Colors.grey,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.get('continue'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
