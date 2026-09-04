import 'package:flutter_test/flutter_test.dart';
import 'package:naghdeno/controllers/app_state.dart';
import 'package:naghdeno/models/book_models.dart';

void main() {
  group('AppState Tests', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('Initial shelf mapping and shelf updating works', () {
      expect(appState.getShelfType('1'), ShelfType.currentlyReading);

      appState.setShelfType('1', ShelfType.read);
      expect(appState.getShelfType('1'), ShelfType.read);

      final readBooks = appState.getBooksByShelf(ShelfType.read);
      expect(readBooks.any((b) => b.id == '1'), isTrue);
    });

    test('Update progress updates ReadingProgress state', () {
      appState.updateProgress('1', 1, 0.85);

      final progress = appState.getProgress('1');
      expect(progress.currentChapterIndex, equals(1));
      expect(progress.progressPercentage, equals(0.85));
    });

    test('Add and remove bookmarks work correctly', () {
      final initialCount = appState.bookmarks.length;
      final bookmark = Bookmark(
        id: 'bm_test',
        bookId: '1',
        chapterIndex: 0,
        chapterTitle: 'فصل تست',
        snippet: 'خلاصه تست',
        createdAt: DateTime.now(),
      );

      appState.addBookmark(bookmark);
      expect(appState.bookmarks.length, equals(initialCount + 1));

      appState.removeBookmark('bm_test');
      expect(appState.bookmarks.length, equals(initialCount));
    });

    test('Reader settings update correctly', () {
      appState.setReaderFontSize(22.0);
      expect(appState.readerFontSize, equals(22.0));

      appState.setReaderTheme('dark');
      expect(appState.readerTheme, equals('dark'));
    });
  });
}
