import 'package:flutter/material.dart';
import 'package:bondlyze/utils/responsive.dart';

class AudioCallScreen extends StatefulWidget {
  final String contactName;
  
  const AudioCallScreen({
    super.key,
    this.contactName = 'Charlotte',
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  String _callDuration = '00:00';
  bool _isSpeakerOn = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }

  void _startCallTimer() {
    int minutes = 0;
    int seconds = 0;
    
    // Simulating call timer - update every second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        seconds++;
        if (seconds >= 60) {
          minutes++;
          seconds = 0;
        }
        setState(() {
          _callDuration = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        });
        _startCallTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFB6C1), // Soft pink
              const Color(0xFF9370DB), // Medium purple
              const Color(0xFF4169E1), // Royal blue
              const Color(0xFF8B00FF), // Deep purple
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with back button
              Padding(
                padding: EdgeInsets.only(
                  top: context.rh(16),
                  left: context.rw(16),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              
              // Decorative 3D shape / logo in mid-top
              Padding(
                padding: EdgeInsets.only(top: context.rh(20)),
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: context.rw(80),
                    height: context.rh(80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.phone,
                      size: context.rf(40),
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Center section with profile picture
              Column(
                children: [
                  // Profile Picture
                  Container(
                    width: context.rw(200),
                    height: context.rw(200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        color: Colors.orange.shade300,
                        child: Center(
                          child: Text(
                            widget.contactName[0],
                            style: TextStyle(
                              fontSize: context.rf(80),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: context.rh(24)),
                  
                  // Contact Name
                  Text(
                    widget.contactName,
                    style: TextStyle(
                      fontSize: context.rf(32),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: context.rh(12)),
                  
                  // Call Duration
                  Text(
                    '$_callDuration minutes',
                    style: TextStyle(
                      fontSize: context.rf(18),
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Bottom call controls
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.rh(40),
                  left: context.rw(40),
                  right: context.rw(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Speaker Button
                    _CallControlButton(
                      icon: Icons.volume_up,
                      backgroundColor: Colors.purple.shade300.withOpacity(0.8),
                      isActive: _isSpeakerOn,
                      onPressed: () {
                        setState(() {
                          _isSpeakerOn = !_isSpeakerOn;
                        });
                      },
                    ),
                    
                    // Microphone Button
                    _CallControlButton(
                      icon: Icons.mic,
                      backgroundColor: Colors.purple.shade300.withOpacity(0.8),
                      isActive: !_isMuted,
                      onPressed: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                    ),
                    
                    // Hang Up Button
                    _CallControlButton(
                      icon: Icons.call_end,
                      backgroundColor: Colors.red,
                      isActive: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final bool isActive;
  final VoidCallback onPressed;

  const _CallControlButton({
    required this.icon,
    required this.backgroundColor,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.rw(64),
      height: context.rw(64),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: context.rf(28),
        ),
        onPressed: onPressed,
      ),
    );
  }
}