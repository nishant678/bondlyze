import 'package:flutter/material.dart';
import 'package:bondlyze/utils/responsive.dart';

class VideoCallScreen extends StatefulWidget {
  final String contactName;
  
  const VideoCallScreen({
    super.key,
    this.contactName = 'Charlotte',
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  String _callDuration = '00:00';
  bool _isSpeakerOn = false;
  bool _isVideoOn = true;
  bool _isMuted = false;
  
  // Position for Picture-in-Picture box
  Offset _pipPosition = Offset.zero;
  bool _isInitialPositionSet = false;

  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }
  
  void _updatePipPosition(BuildContext context) {
    if (!_isInitialPositionSet) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      // Set initial position (bottom-right)
      _pipPosition = Offset(
        screenWidth - context.rw(136), // width (120) + right margin (16)
        screenHeight - context.rh(360) - MediaQuery.of(context).padding.bottom, // height (160) + bottom offset (200) + safe area
      );
      _isInitialPositionSet = true;
    }
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
    _updatePipPosition(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final pipWidth = context.rw(120);
    final pipHeight = context.rh(160);
    
    // Allow box to move anywhere on screen, only constrained by screen boundaries
    // Exclude only the very bottom control button area (not the call info area)
    final bottomControlButtonArea = context.rh(80) + safeAreaBottom; // Space for bottom control buttons only
    final maxLeft = screenWidth - pipWidth;
    final maxTop = screenHeight - pipHeight - bottomControlButtonArea;
    final minTop = 0.0; // Allow from top of screen including safe area
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main video feed (full screen)
          _MainVideoFeed(contactName: widget.contactName),
          
          // Picture-in-Picture video feed (draggable)
          Positioned(
            left: _pipPosition.dx.clamp(0.0, maxLeft),
            top: _pipPosition.dy.clamp(minTop, maxTop),
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _pipPosition = Offset(
                    (_pipPosition.dx + details.delta.dx).clamp(0.0, maxLeft),
                    (_pipPosition.dy + details.delta.dy).clamp(minTop, maxTop),
                  );
                });
              },
              child: _PictureInPictureFeed(),
            ),
          ),
          
          // Call information (bottom-left)
          Positioned(
            bottom: context.rh(200),
            left: context.rw(16),
            child: _CallInfo(
              contactName: widget.contactName,
              duration: _callDuration,
            ),
          ),
          
          // Top-left back button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: context.rh(16),
                left: context.rw(16),
              ),
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
          
          // Bottom call controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _CallControls(
              isSpeakerOn: _isSpeakerOn,
              isVideoOn: _isVideoOn,
              isMuted: _isMuted,
              onSpeakerToggle: () {
                setState(() {
                  _isSpeakerOn = !_isSpeakerOn;
                });
              },
              onVideoToggle: () {
                setState(() {
                  _isVideoOn = !_isVideoOn;
                });
              },
              onMuteToggle: () {
                setState(() {
                  _isMuted = !_isMuted;
                });
              },
              onHangUp: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MainVideoFeed extends StatelessWidget {
  final String contactName;
  
  const _MainVideoFeed({required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[900],
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Simulated video background with blur effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[850]!,
                  Colors.grey[900]!,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile avatar representing the video
                  Container(
                    width: context.rw(200),
                    height: context.rw(200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red[700]!,
                          Colors.red[900]!,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        color: Colors.red[800],
                        child: Center(
                          child: Text(
                            contactName[0],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PictureInPictureFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.rw(120),
      height: context.rh(160),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(context.rw(12)),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Simulated video feed
          ClipRRect(
            borderRadius: BorderRadius.circular(context.rw(10)),
            child: Container(
              color: Colors.grey[700],
              child: Center(
                child: Icon(
                  Icons.person,
                  size: context.rf(50),
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          
          // Camera switch icon in bottom-right corner of PiP
          Positioned(
            bottom: context.rh(8),
            right: context.rw(8),
            child: Container(
              width: context.rw(28),
              height: context.rw(28),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cameraswitch,
                size: context.rf(18),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CallInfo extends StatelessWidget {
  final String contactName;
  final String duration;
  
  const _CallInfo({
    required this.contactName,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactName,
          style: TextStyle(
            fontSize: context.rf(24),
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: context.rh(4)),
        Text(
          '$duration minutes',
          style: TextStyle(
            fontSize: context.rf(16),
            color: Colors.white,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CallControls extends StatelessWidget {
  final bool isSpeakerOn;
  final bool isVideoOn;
  final bool isMuted;
  final VoidCallback onSpeakerToggle;
  final VoidCallback onVideoToggle;
  final VoidCallback onMuteToggle;
  final VoidCallback onHangUp;

  const _CallControls({
    required this.isSpeakerOn,
    required this.isVideoOn,
    required this.isMuted,
    required this.onSpeakerToggle,
    required this.onVideoToggle,
    required this.onMuteToggle,
    required this.onHangUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + context.rh(20),
        top: context.rh(20),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Speaker button
          _VideoCallControlButton(
            icon: Icons.volume_up,
            backgroundColor: Colors.grey[600]!,
            onPressed: onSpeakerToggle,
          ),
          
          SizedBox(width: context.rw(16)),
          
          // Video toggle button
          _VideoCallControlButton(
            icon: Icons.videocam,
            backgroundColor: Colors.grey[600]!,
            onPressed: onVideoToggle,
          ),
          
          SizedBox(width: context.rw(16)),
          
          // Microphone mute button
          _VideoCallControlButton(
            icon: Icons.mic,
            backgroundColor: Colors.grey[600]!,
            onPressed: onMuteToggle,
          ),
          
          SizedBox(width: context.rw(16)),
          
          // Hang up button
          _VideoCallControlButton(
            icon: Icons.call_end,
            backgroundColor: Colors.red,
            onPressed: onHangUp,
          ),
        ],
      ),
    );
  }
}

class _VideoCallControlButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const _VideoCallControlButton({
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.rw(56),
      height: context.rw(56),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: context.rf(24),
        ),
        onPressed: onPressed,
      ),
    );
  }
}