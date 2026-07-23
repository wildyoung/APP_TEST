import 'package:flutter/material.dart';

void main() {
  runApp(const AppTestApp());
}

class AppTestApp extends StatelessWidget {
  const AppTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP TEST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C4DFF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DistributionTestPage(),
    );
  }
}

class DistributionTestPage extends StatefulWidget {
  const DistributionTestPage({super.key});

  @override
  State<DistributionTestPage> createState() => _DistributionTestPageState();
}

class _DistributionTestPageState extends State<DistributionTestPage> {
  int _checkCount = 0;

  void _verifyApp() {
    setState(() {
      _checkCount += 1;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Version 1.4.1 is installed and ready.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF1E8),
              Color(0xFFF3E9FF),
              Color(0xFFE7F7FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -55,
              right: -45,
              child: _Bubble(size: 180, color: Color(0x44FF7A68)),
            ),
            const Positioned(
              bottom: -70,
              left: -55,
              child: _Bubble(size: 220, color: Color(0x337C4DFF)),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(22),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 44,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const _TopBar(),
                              const SizedBox(height: 22),
                              const _HeroCard(),
                              const SizedBox(height: 18),
                              const _DetailsCard(),
                              const SizedBox(height: 18),
                              FilledButton.icon(
                                key: const Key('verify-button'),
                                onPressed: _verifyApp,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF19142D),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(58),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: const Icon(Icons.verified_rounded),
                                label: Text(
                                  _checkCount == 0
                                      ? 'Confirm version 1.4.1'
                                      : 'Confirmed ($_checkCount)',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'APP TEST',
            style: TextStyle(
              color: Color(0xFF19142D),
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x227C4DFF)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 9, color: Color(0xFF32C48D)),
              SizedBox(width: 7),
              Text(
                'LIVE UPDATE',
                style: TextStyle(
                  color: Color(0xFF5D3BB5),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C4DFF), Color(0xFFFF6F61)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x337C4DFF),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.rocket_launch_rounded,
              size: 31,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'A fresh update\nhas landed!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              height: 1.08,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.1,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'A brighter design delivered through Firebase App Distribution.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 16,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: const Color(0xFF19142D),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'VERSION 1.4.1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
      ),
      child: const Column(
        children: [
          _DetailRow(
            icon: Icons.layers_rounded,
            color: Color(0xFF7C4DFF),
            label: 'Current version',
            value: '1.4.1',
          ),
          _DetailDivider(),
          _DetailRow(
            icon: Icons.autorenew_rounded,
            color: Color(0xFFFF6F61),
            label: 'Update path',
            value: 'In-app',
          ),
          _DetailDivider(),
          _DetailRow(
            icon: Icons.cloud_done_rounded,
            color: Color(0xFF25A97B),
            label: 'Delivery',
            value: 'Firebase',
          ),
        ],
      ),
    );
  }
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: Color(0x14000000));
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF6C667A)),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF19142D),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
