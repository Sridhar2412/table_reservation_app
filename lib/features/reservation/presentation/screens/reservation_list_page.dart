import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_reservation_app/features/auth/presentation/providers/auth_providers.dart';

import '../../../../core/router/app_router.dart';
import '../../domain/models/reservation_model.dart';
import '../providers/reservation_providers.dart';

@RoutePage()
class ReservationListPage extends ConsumerWidget {
  const ReservationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reservationListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Reservations'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.dashboard_outlined),
          onPressed: () => context.router.push(const DashboardRoute()),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _confirmLogout(context, ref),
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(ReservationFormRoute()),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: state.when(
        data: (reservations) {
          if (reservations.isEmpty) {
            return _buildEmptyState(context);
          }

          final confirmed = reservations
              .where((r) => r.status == ReservationStatus.confirmed)
              .toList();
          final waitlist = reservations
              .where((r) => r.status == ReservationStatus.waitlist)
              .toList();
          final cancelled = reservations
              .where((r) => r.status == ReservationStatus.cancelled)
              .toList();

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: const TabBar(
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.orange,
                    tabs: [
                      Tab(text: 'Confirmed'),
                      Tab(text: 'Waitlist'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildReservationList(context, ref, confirmed),
                      _buildReservationList(context, ref, waitlist),
                      _buildReservationList(context, ref, cancelled,
                          isCancelledTab: true),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.orange)),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No reservations found',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.router.push(ReservationFormRoute()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationList(
      BuildContext context, WidgetRef ref, List<ReservationModel> list,
      {bool isCancelledTab = false}) {
    if (list.isEmpty) {
      return const Center(child: Text('No reservations in this category.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final res = list[index];
        return _buildReservationCard(context, ref, res, isCancelledTab);
      },
    );
  }

  Widget _buildReservationCard(BuildContext context, WidgetRef ref,
      ReservationModel res, bool isCancelled) {
    final dateStr = DateFormat('MMM dd, yyyy').format(res.dateTime);
    final timeStr = DateFormat('hh:mm a').format(res.dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 5,
                color: _getStatusColor(res.status),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${res.firstName} ${res.lastName}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          if (!isCancelled)
                            PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.more_vert, size: 20),
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  context.router.push(
                                      ReservationFormRoute(reservation: res));
                                } else if (value == 'cancel') {
                                  _confirmCancel(context, ref, res.id);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value: 'cancel',
                                  child: Text('Cancel',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _buildStatusBadge(res.status),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildModernInfoChip(Icons.calendar_today, dateStr,
                              _getStatusColor(res.status)),
                          _buildModernInfoChip(Icons.access_time, timeStr,
                              _getStatusColor(res.status)),
                          _buildModernInfoChip(
                              Icons.group_outlined,
                              '${res.partySize} Guests',
                              _getStatusColor(res.status)),
                          _buildModernInfoChip(
                              Icons.table_restaurant_outlined,
                              'Table ${res.tableNumber}',
                              _getStatusColor(res.status)),
                        ],
                      ),
                      if (res.specialRequests != null &&
                          res.specialRequests!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  _getStatusColor(res.status).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border(
                                left: BorderSide(
                                  color: _getStatusColor(res.status)
                                      .withOpacity(0.4),
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Text(
                              res.specialRequests!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade800,
                                height: 1.4,
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

  Color _getStatusColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.confirmed:
        return Colors.green;
      case ReservationStatus.waitlist:
        return Colors.orange;
      case ReservationStatus.cancelled:
        return Colors.red;
    }
  }

  Widget _buildModernInfoChip(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ReservationStatus status) {
    Color color;
    String label;
    switch (status) {
      case ReservationStatus.confirmed:
        color = Colors.green;
        label = 'CONFIRMED';
        break;
      case ReservationStatus.waitlist:
        color = Colors.orange;
        label = 'WAITLIST';
        break;
      case ReservationStatus.cancelled:
        color = Colors.red;
        label = 'CANCELLED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _confirmCancel(BuildContext context, WidgetRef ref, String id) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('Cancel Reservation'),
              content: const Text(
                  'Are you sure you want to cancel this reservation?'),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Keep it'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ref.read(reservationListProvider.notifier).cancel(id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reservation cancelled'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Yes, Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('No, Stay'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await ref.read(authNotifierProvider.notifier).logout();
                    if (context.mounted) {
                      context.router.replaceAll([const LoginRoute()]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Yes, Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
