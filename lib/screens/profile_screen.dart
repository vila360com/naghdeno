import 'package:flutter/material.dart';
import '../controllers/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final currentlyReadingCount =
        appState.userShelves.values.where((v) => v.name == 'currentlyReading').length;
    final readCount =
        appState.userShelves.values.where((v) => v.name == 'read').length;
    final wantToReadCount =
        appState.userShelves.values.where((v) => v.name == 'wantToRead').length;
    final bookmarks = appState.bookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل کاربری'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            const SizedBox(height: 12),
            Text(
              'کاربر نقد نو',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            const Text(
              'علاقه‌مند به ادبیات کلاسیک و داستان‌های معاصر',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // Reading Stats Cards
            Row(
              children: [
                _buildStatCard(context, 'در حال خواندن',
                    currentlyReadingCount.toString(), Colors.blue),
                _buildStatCard(
                    context, 'خوانده‌شده', readCount.toString(), Colors.green),
                _buildStatCard(context, 'می‌خواهم بخوانم',
                    wantToReadCount.toString(), Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            // Bookmarks section
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نشانک‌های من (${bookmarks.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            if (bookmarks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('هیچ نشانکی ذخیره نشده است.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final bm = bookmarks[index];
                  final book = appState.repository.getBookById(bm.bookId);

                  return Card(
                    child: ListTile(
                      title: Text(book?.title ?? 'کتاب'),
                      subtitle: Text('${bm.chapterTitle}\n"${bm.snippet}"'),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          appState.removeBookmark(bm.id);
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
