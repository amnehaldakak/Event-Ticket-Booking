import 'package:event_ticket_booking1/local/app_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'landing_screen.dart';
import 'package:event_ticket_booking1/color.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingReviewAndConfirmationScreen extends StatefulWidget {
  final ValueNotifier<Locale>? localeNotifier;

  final TicketType ticketType;
  final String name;
  final String email;
  final String phone;
  final String country;
  final String job;
  final String org;
  final String promo;
  final double total;

  const BookingReviewAndConfirmationScreen({
    Key? key,
    required this.ticketType,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.job,
    required this.org,
    required this.promo,
    required this.total,
    this.localeNotifier,
  }) : super(key: key);

  @override
  State<BookingReviewAndConfirmationScreen> createState() =>
      _BookingReviewAndConfirmationScreenState();
}

class _BookingReviewAndConfirmationScreenState
    extends State<BookingReviewAndConfirmationScreen> {
  bool _confirmed = false;
  String? _referenceNumber;
  bool _loading = false;

  void _confirmBooking() async {
    setState(() {
      _loading = true;
    });
    // Simulate a fake API call delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
      _confirmed = true;
      _referenceNumber = _generateReference();
    });
  }

  String _generateReference() {
    final rand = Random();
    return 'REF${rand.nextInt(900000) + 100000}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violetBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.get('review_confirm'),
          style:
              const TextStyle(color: violetBlue2, fontWeight: FontWeight.bold),
        ),
        backgroundColor: violetBlue3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _confirmed
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 80),
                      const SizedBox(height: 24),
                      const Text('Booking Confirmed!',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: violetBlue3)),
                      const SizedBox(height: 12),
                      Text('Reference: $_referenceNumber',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                      (_referenceNumber != null
                          ? QrImageView(
                              data: _referenceNumber!,
                              version: QrVersions.auto,
                              size: 120.0,
                              backgroundColor: Colors.white,
                            )
                          : const SizedBox.shrink()),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.popUntil(
                            context, (route) => route.isFirst),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: violetBlue3,
                          foregroundColor: violetBlue2,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Back to Home',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                : ListView(
                    children: [
                      const Text('Please review your booking:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: violetBlue3)),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: violetBlue2,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ticket:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text(widget.ticketType.name,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 8),
                            Text('Name:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text(widget.name,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 8),
                            Text('Email:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text(widget.email,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 8),
                            Text('Phone:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text(widget.phone,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 8),
                            Text('Country:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text(widget.country,
                                style: const TextStyle(color: Colors.black)),
                            if (widget.job.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text('Job Title:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: violetBlue3)),
                              Text(widget.job,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                            if (widget.org.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text('Organization:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: violetBlue3)),
                              Text(widget.org,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                            if (widget.promo.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text('Promo Code:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: violetBlue3)),
                              Text(widget.promo,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                            const SizedBox(height: 8),
                            Text('Total:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: violetBlue3)),
                            Text('${widget.total.toStringAsFixed(2)} USD',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _confirmBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: violetBlue3,
                          foregroundColor: violetBlue2,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Confirm Booking',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
      ),
    );
  }
}
