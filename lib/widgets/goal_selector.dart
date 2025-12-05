import 'package:flutter/material.dart';

class GoalSelector extends StatefulWidget {
  final String selectedGoal;
  final List<String> goals;
  final Function(String)? onGoalChanged;

  const GoalSelector({
    super.key,
    required this.selectedGoal,
    this.goals = const ['NEET/JEE', 'UPSC', 'SSC', 'Banking', 'GATE', 'Boards', 'Skills'],
    this.onGoalChanged,
  });

  @override
  State<GoalSelector> createState() => _GoalSelectorState();
}

class _GoalSelectorState extends State<GoalSelector> {
  late String _selectedGoal;

  @override
  void initState() {
    super.initState();
    _selectedGoal = widget.selectedGoal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Goal',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Goal Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedGoal,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                items: widget.goals.map((String goal) {
                  return DropdownMenuItem<String>(
                    value: goal,
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(goal),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedGoal = newValue;
                    });
                    widget.onGoalChanged?.call(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}