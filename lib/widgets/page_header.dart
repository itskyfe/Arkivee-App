import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 24),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tombol back kalau bisa balik
              if (Navigator.canPop(context))
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )
              else
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    'Arkivee',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
