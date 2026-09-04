import 'package:flutter/material.dart';
import '../controllers/app_state.dart';
import '../models/book_models.dart';
import '../widgets/book_card.dart';
import 'book_detail_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('کتابخانه من'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'در حال خواندن'),
              Tab(text: 'می‌خواهم بخوانم'),
              Tab(text: 'خوانده‌شده'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildShelfList(context, appState, ShelfType.currentlyReading),
            _buildShelfList(context, appState, ShelfType.wantToRead),
            _buildShelfList(context, appState, ShelfType.read),
          ],
        ),
      ),
    );
  }

  Widget _buildShelfList(
      BuildContext context, AppState appState, ShelfType shelf) {
    final books = appState.getBooksByShelf(shelf);

    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections_bookmark_outlined,
                size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              'هیچ کتابی در قفسه «${shelf.label}» قرار ندارد.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        final progress = appState.getProgress(book.id);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookCard(
              book: book,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailScreen(bookId: book.id),
                  ),
                );
              },
            ),
            if (shelf == ShelfType.currentlyReading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'پیشرفت مطالعه: ${(progress.progressPercentage * 100).toInt()}%',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'فصل ${progress.currentChapterIndex + 1} از ${book.chapters.length}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress.progressPercentage,
                      backgroundColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
