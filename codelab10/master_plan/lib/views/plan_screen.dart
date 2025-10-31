import '../models/data_layer.dart';
import 'package:flutter/material.dart';
import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // Plan plan = const Plan();
  late ScrollController scrollController;
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final currentPlan = plan;
        final plans = List<Plan>.from(planNotifier.value);
        final planIndex = plans.indexWhere((p) => p.name == currentPlan.name);

        if (planIndex != -1) {
          final updatedTasks = List<Task>.from(plans[planIndex].tasks)
            ..add(const Task());
          plans[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);
          planNotifier.value = plans; // Tugaskan list yang sudah dimodifikasi
        }
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final plans = List<Plan>.from(planNotifier.value);
          final planIndex = plans.indexWhere((p) => p.name == plan.name);

          if (planIndex != -1) {
            final currentPlan = plans[planIndex];
            final updatedTasks = List<Task>.from(currentPlan.tasks);
            updatedTasks[index] = Task(
              description: task.description,
              complete: selected ?? false,
            );
            plans[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
            planNotifier.value = plans; // Tugaskan list yang sudah dimodifikasi
          }
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final plans = List<Plan>.from(planNotifier.value);
          final planIndex = plans.indexWhere((p) => p.name == plan.name);

          if (planIndex != -1) {
            final currentPlan = plans[planIndex];
            final updatedTasks = List<Task>.from(currentPlan.tasks);
            updatedTasks[index] = Task(
              description: text,
              complete: task.complete,
            );
            plans[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
            planNotifier.value = plans; // Tugaskan list yang sudah dimodifikasi
          }
        },
      ),
    );
  }
}
