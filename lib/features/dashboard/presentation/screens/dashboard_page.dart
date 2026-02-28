import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../reservation/domain/models/reservation_model.dart';
import '../../../reservation/presentation/providers/reservation_providers.dart';

@RoutePage()
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reservationListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: state.when(
        data: (reservations) {
          final topMetrics = _calculateMetrics(reservations);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Today\'s Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildMetricsRow(topMetrics),
                const SizedBox(height: 32),
                const Text(
                  'Weekly Activity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Number of confirmed reservations per day',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 350,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildChart(reservations),
                ),
                const SizedBox(height: 32),
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

  Map<String, dynamic> _calculateMetrics(List<ReservationModel> reservations) {
    final today = DateTime.now();
    final todayReservations = reservations
        .where((r) =>
            r.status == ReservationStatus.confirmed &&
            r.dateTime.year == today.year &&
            r.dateTime.month == today.month &&
            r.dateTime.day == today.day)
        .toList();

    const totalTables = 20;
    final occupiedTables = todayReservations.length;
    final remainingTables =
        (totalTables - occupiedTables).clamp(0, totalTables);
    final totalGuests =
        todayReservations.fold<int>(0, (sum, r) => sum + r.partySize);

    return {
      'totalReservations': todayReservations.length,
      'remainingTables': remainingTables,
      'totalGuests': totalGuests,
    };
  }

  Widget _buildMetricsRow(Map<String, dynamic> metrics) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Reservations',
            metrics['totalReservations'].toString(),
            Icons.book_online,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Available',
            metrics['remainingTables'].toString(),
            Icons.table_bar,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Total Guests',
            metrics['totalGuests'].toString(),
            Icons.people,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<ReservationModel> reservations) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfRange =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final Map<int, int> countsPerDay = {for (int i = 1; i <= 7; i++) i: 0};

    for (var r in reservations) {
      if (r.status == ReservationStatus.confirmed) {
        final rDate =
            DateTime(r.dateTime.year, r.dateTime.month, r.dateTime.day);
        final diffDays = rDate.difference(startOfRange).inDays;
        if (diffDays >= 0 && diffDays < 7) {
          countsPerDay[r.dateTime.weekday] =
              (countsPerDay[r.dateTime.weekday] ?? 0) + 1;
        }
      }
    }

    final List<_ChartData> chartData = [];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 1; i <= 7; i++) {
      chartData.add(_ChartData(
        days[i - 1],
        countsPerDay[i]!.toDouble(),
        i == now.weekday ? Colors.orange : Colors.orange.withOpacity(0.4),
      ));
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: MajorGridLines(
          width: 1,
          color: Colors.grey.shade100,
        ),
        labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 10),
      ),
      tooltipBehavior: TooltipBehavior(enable: true, header: ''),
      series: <CartesianSeries<_ChartData, String>>[
        ColumnSeries<_ChartData, String>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.color,
          name: 'Bookings',
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          width: 0.6,
        )
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
