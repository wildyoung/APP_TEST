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
          seedColor: const Color(0xFF31E6B4),
          brightness: Brightness.dark,
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
          content: Text('1.3.0 기준 버전이 정상적으로 설치됐습니다.'),
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
              Color(0xFF061A2B),
              Color(0xFF0C3D49),
              Color(0xFF08766D),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -55,
              child: _GlowCircle(size: 210, color: Color(0x3331E6B4)),
            ),
            const Positioned(
              bottom: -95,
              left: -75,
              child: _GlowCircle(size: 250, color: Color(0x267AC8FF)),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 48,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.18),
                                    ),
                                  ),
                                  child: const Text(
                                    'UPDATE TEST  •  v1.3.0',
                                    style: TextStyle(
                                      color: Color(0xFF8FF7D9),
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Icon(
                                Icons.auto_awesome_rounded,
                                size: 64,
                                color: Color(0xFF8FF7D9),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                '새로운 화면으로\n업데이트됐어요',
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      height: 1.12,
                                    ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Firebase App Distribution을 통해 전달된\n두 번째 디자인 버전입니다.',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(alpha: 0.72),
                                      height: 1.5,
                                    ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                padding: const EdgeInsets.all(22),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.16),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    _StatusRow(
                                      icon: Icons.verified_rounded,
                                      label: '현재 버전',
                                      value: '1.3.0',
                                    ),
                                    _StatusDivider(),
                                    _StatusRow(
                                      icon: Icons.refresh_rounded,
                                      label: '업데이트 확인',
                                      value: '앱 실행 시 자동',
                                    ),
                                    _StatusDivider(),
                                    _StatusRow(
                                      icon: Icons.cloud_download_rounded,
                                      label: '설치 방식',
                                      value: 'Firebase APK',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              FilledButton.icon(
                                key: const Key('verify-button'),
                                onPressed: _verifyApp,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF8FF7D9),
                                  foregroundColor: const Color(0xFF073D3A),
                                  minimumSize: const Size.fromHeight(56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                icon: const Icon(Icons.check_rounded),
                                label: Text(
                                  _checkCount == 0
                                      ? '업데이트 완료 확인'
                                      : '확인 완료 ($_checkCount)',
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

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

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

class _StatusDivider extends StatelessWidget {
  const _StatusDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 28, color: Colors.white.withValues(alpha: 0.12));
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFF8FF7D9)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.68)),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
