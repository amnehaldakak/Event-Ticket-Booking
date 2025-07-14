import 'package:event_ticket_booking1/color.dart';
import 'package:flutter/material.dart';
import 'landing_screen.dart';
import 'dart:math';
import 'booking_review_confirmation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_ticket_booking1/local/app_localizations.dart';

class BookingFormScreen extends StatefulWidget {
  final TicketType ticketType;
  const BookingFormScreen({Key? key, required this.ticketType})
      : super(key: key);

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _promoController = TextEditingController();

  String? _selectedCountry;
  double _finalPrice = 0.0;
  bool _promoApplied = false;
  String? _promoError;

  final List<String> _countries = [
    'United States',
    'Germany',
    'India',
    'United Kingdom',
    'Canada',
    'Australia',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _finalPrice = widget.ticketType.price;
    _promoController.addListener(_updatePriceWithPromo);
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _emailController.text = prefs.getString('user_email') ?? '';
      _phoneController.text = prefs.getString('user_phone') ?? '';
      _selectedCountry = prefs.getString('user_country');
      _jobController.text = prefs.getString('user_job') ?? '';
      _orgController.text = prefs.getString('user_org') ?? '';
    });
  }

  Future<void> _saveUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    await prefs.setString('user_email', _emailController.text);
    await prefs.setString('user_phone', _phoneController.text);
    await prefs.setString('user_country', _selectedCountry ?? '');
    await prefs.setString('user_job', _jobController.text);
    await prefs.setString('user_org', _orgController.text);
  }

  void _updatePriceWithPromo() {
    final code = _promoController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _finalPrice = widget.ticketType.price;
        _promoApplied = false;
        _promoError = null;
      });
      return;
    }
    if (code.toUpperCase() == 'EXPO10') {
      setState(() {
        _finalPrice = widget.ticketType.price * 0.9;
        _promoApplied = true;
        _promoError = null;
      });
    } else {
      setState(() {
        _finalPrice = widget.ticketType.price;
        _promoApplied = false;
        _promoError = 'Invalid promo code';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _orgController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  void _reviewBooking() async {
    if (_formKey.currentState!.validate() && _selectedCountry != null) {
      await _saveUserInfo();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingReviewAndConfirmationScreen(
            ticketType: widget.ticketType,
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            country: _selectedCountry!,
            job: _jobController.text,
            org: _orgController.text,
            promo: _promoController.text,
            total: _finalPrice,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violetBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${AppLocalizations.of(context)!.get('booking')}: ${AppLocalizations.of(context)!.get(widget.ticketType.name)}',
          style:
              const TextStyle(color: violetBlue2, fontWeight: FontWeight.bold),
        ),
        backgroundColor: violetBlue3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                  '${AppLocalizations.of(context)!.get('booking')}: ${AppLocalizations.of(context)!.get(widget.ticketType.name)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: violetBlue3,
                      fontSize: 18)),
              Text(
                  '${AppLocalizations.of(context)!.get('price') ?? 'Price'}: ${widget.ticketType.price.toStringAsFixed(2)} USD',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              StyledInputCard(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('full_name'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.get('required')
                      : null,
                ),
              ),
              StyledInputCard(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('email'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.get('required');
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value))
                      return AppLocalizations.of(context)!.get('invalid_email');
                    return null;
                  },
                ),
              ),
              StyledInputCard(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('phone'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.get('required');
                    if (value.length < 7)
                      return AppLocalizations.of(context)!.get('too_short');
                    return null;
                  },
                ),
              ),
              StyledInputCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('country'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                  items: _countries
                      .map((country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCountry = value),
                  validator: (value) => value == null
                      ? AppLocalizations.of(context)!.get('required')
                      : null,
                ),
              ),
              StyledInputCard(
                child: TextFormField(
                  controller: _jobController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('job'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              StyledInputCard(
                child: TextFormField(
                  controller: _orgController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('org'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              StyledInputCard(
                child: TextFormField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.get('promo'),
                    labelStyle: const TextStyle(color: violetBlue3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_promoError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(_promoError!,
                      style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 16),
              Text(
                  '${AppLocalizations.of(context)!.get('total')}: ${_finalPrice.toStringAsFixed(2)} USD',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _reviewBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: violetBlue3,
                  foregroundColor: violetBlue2,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.get('review_booking'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledInputCard extends StatelessWidget {
  final Widget child;
  const StyledInputCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: violetBlue2,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        constraints:
            const BoxConstraints(minHeight: 56, minWidth: double.infinity),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
