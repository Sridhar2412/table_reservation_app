import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_reservation_app/core/router/app_router.dart';

import '../../domain/models/reservation_model.dart';
import '../providers/reservation_form_providers.dart';

@RoutePage()
class ReservationFormPage extends ConsumerStatefulWidget {
  final ReservationModel? reservation;
  const ReservationFormPage({super.key, this.reservation});

  @override
  ConsumerState<ReservationFormPage> createState() =>
      _ReservationFormPageState();
}

class _ReservationFormPageState extends ConsumerState<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _partySizeController;
  late TextEditingController _specialRequestsController;

  bool get isEditing => widget.reservation != null;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.reservation?.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.reservation?.lastName ?? '');
    _phoneController =
        TextEditingController(text: widget.reservation?.phone ?? '');
    _partySizeController = TextEditingController(
        text: widget.reservation?.partySize.toString() ?? '');
    _specialRequestsController =
        TextEditingController(text: widget.reservation?.specialRequests ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(reservationFormNotifierProvider.notifier)
          .setInitial(widget.reservation);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _partySizeController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final formState = ref.read(reservationFormNotifierProvider);

    final date = await showDatePicker(
      context: context,
      initialDate: formState.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      if (!mounted) return;
      ref.read(reservationFormNotifierProvider.notifier).updateDate(date);

      final time = await showTimePicker(
        context: context,
        initialTime: formState.selectedTime ?? TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.orange,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        ref.read(reservationFormNotifierProvider.notifier).updateTime(time);
      }
    }
  }

  void _submit({bool joinWaitlist = false}) async {
    if (!_formKey.currentState!.validate()) return;

    final formState = ref.read(reservationFormNotifierProvider);
    final combinedDate = formState.combinedDateTime;

    if (combinedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Date & Time')),
      );
      return;
    }

    final partySize = int.tryParse(_partySizeController.text) ?? 1;

    if (!joinWaitlist) {
      final isAvailable = await ref
          .read(reservationFormNotifierProvider.notifier)
          .checkAvailability(
            dateTime: combinedDate,
            partySize: partySize,
            firstName: _firstNameController.text,
            phone: _phoneController.text,
          );

      if (!isAvailable) {
        if (!mounted) return;
        final currentError =
            ref.read(reservationFormNotifierProvider).errorMessage;
        if (currentError == null) {
          _showWaitlistDialog();
        }
        return;
      }
    }

    final reservation = ReservationModel(
      id: widget.reservation?.id ?? '',
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneController.text.trim(),
      dateTime: combinedDate,
      partySize: partySize,
      tableNumber: isEditing
          ? widget.reservation!.tableNumber
          : (1 + (DateTime.now().millisecondsSinceEpoch % 20)).toString(),
      specialRequests: _specialRequestsController.text.trim(),
      status: joinWaitlist
          ? ReservationStatus.waitlist
          : ReservationStatus.confirmed,
    );

    await ref.read(reservationFormNotifierProvider.notifier).submit(
          reservation: reservation,
          isEditing: isEditing,
        );
  }

  void _showWaitlistDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Fully Booked'),
        content: const Text(
          'We are fully booked for this slot. Would you like to join the waitlist?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _submit(joinWaitlist: true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Join Waitlist'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(reservationFormNotifierProvider);

    ref.listen(reservationFormNotifierProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      } else if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.isWaitlistSuccess
                  ? 'Added to Waitlist!'
                  : (isEditing
                      ? 'Reservation updated!'
                      : 'Reservation confirmed!'),
            ),
          ),
        );
        context.router.replaceAll([const ReservationListRoute()]);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Reservation' : 'Book a Table'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: formState.isLoading ? null : () => _submit(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: formState.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  isEditing ? 'Update Reservation' : 'Confirm & Book',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionTitle('Customer Details'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _firstNameController,
                          label: 'First Name',
                          icon: Icons.person_outline,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          controller: _lastNameController,
                          label: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_android,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Reservation Details'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _partySizeController,
                    label: 'Number of Guests',
                    icon: Icons.group_outlined,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Required';
                      final size = int.tryParse(val);
                      if (size == null || size <= 0) return 'Invalid';
                      if (size > 20) return 'Max 20';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Date & Time'),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: formState.isLoading ? null : _pickDateTime,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              formState.combinedDateTime == null
                                  ? 'Select Date & Time'
                                  : DateFormat('EEEE, MMM dd, hh:mm a').format(
                                      formState.combinedDateTime!,
                                    ),
                              style: TextStyle(
                                fontSize: 14,
                                color: formState.combinedDateTime == null
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 14, color: Colors.grey.shade400),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _specialRequestsController,
                    label: 'Special Requests (Optional)',
                    icon: Icons.note_add_outlined,
                    isRequired: false,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          if (formState.isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    int? maxLength,
    bool isRequired = true,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.orange) : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator ??
          (val) {
            if (!isRequired) return null;
            return val == null || val.isEmpty ? 'Required' : null;
          },
    );
  }
}
