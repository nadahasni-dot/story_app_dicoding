import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../data/network/response_call.dart';
import '../../providers/story_provider.dart';
import '../../widgets/list_story_loading.dart';
import '../../widgets/story_card.dart';

class HomeScreen extends StatefulWidget {
  static const path = '/stories';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _initLoadData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      context.read<StoryProvider>().getAllStories();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<StoryProvider>().getAllStories();
  }

  @override
  void initState() {
    _initLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.textStoryList),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, value, child) {
          if (value.responseCall.status == Status.loading) {
            return const ListStoryLoading();
          }

          if (value.responseCall.status == Status.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.responseCall.message.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      child: const Text("Refresh"),
                    )
                  ],
                ),
              ),
            );
          }

          if ((value.responseCall.data ?? []).isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.textEmptyStory,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      child: const Text("Refresh"),
                    )
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.blue,
            onRefresh: _onRefresh,
            child: ListView.separated(
              itemCount: value.responseCall.data!.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final story = value.responseCall.data![index];

                return StoryCard(story: story);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
        },
      ),
    );
  }
}
