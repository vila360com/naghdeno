import 'package:flutter/material.dart';
import '../models/book_models.dart';
import '../repositories/book_repository.dart';

class AppState extends ChangeNotifier {
  final BookRepository repository = BookRepository();

  // User Library Shelves: Book ID -> ShelfType
  final Map<String, ShelfType> _userShelves = {
    '1': ShelfType.currentlyReading,
    '2': ShelfType.wantToRead,
    '3': ShelfType.read,
  };

  // Reading progress: Book ID -> ReadingProgress
  final Map<String, ReadingProgress> _readingProgress = {
    '1': ReadingProgress(
      bookId: '1',
      currentChapterIndex: 0,
      progressPercentage: 0.35,
      lastReadTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    '3': ReadingProgress(
      bookId: '3',
      currentChapterIndex: 1,
      progressPercentage: 1.0,
      lastReadTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
  };

  // Bookmarks
  final List<Bookmark> _bookmarks = [
    Bookmark(
      id: 'bm1',
      bookId: '1',
      chapterIndex: 0,
      chapterTitle: 'فصل اول: زن اثیری',
      snippet: 'در زندگی زخم‌هایی هست که مثل خوره روح را آهسته در انزوا می‌تراشد...',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  // Reader Customization Options
  double _readerFontSize = 18.0;
  double _readerLineHeight = 1.8;
  String _readerTheme = 'sepia'; // 'light', 'dark', 'sepia'

  // Getters
  Map<String, ShelfType> get userShelves => _userShelves;
  Map<String, ReadingProgress> get readingProgress => _readingProgress;
  List<Bookmark> get bookmarks => _bookmarks;

  double get readerFontSize => _readerFontSize;
  double get readerLineHeight => _readerLineHeight;
  String get readerTheme => _readerTheme;

  // Shelf management
  ShelfType? getShelfType(String bookId) => _userShelves[bookId];

  void setShelfType(String bookId, ShelfType? shelf) {
    if (shelf == null) {
      _userShelves.remove(bookId);
    } else {
      _userShelves[bookId] = shelf;
    }
    notifyListeners();
  }

  List<Book> getBooksByShelf(ShelfType shelf) {
    final bookIds = _userShelves.entries
        .where((entry) => entry.value == shelf)
        .map((entry) => entry.key)
        .toSet();

    return repository
        .getAllBooks()
        .where((book) => bookIds.contains(book.id))
        .toList();
  }

  // Progress Management
  ReadingProgress getProgress(String bookId) {
    return _readingProgress[bookId] ??
        ReadingProgress(
          bookId: bookId,
          currentChapterIndex: 0,
          progressPercentage: 0.0,
          lastReadTime: DateTime.now(),
        );
  }

  void updateProgress(String bookId, int chapterIndex, double progressPct) {
    _readingProgress[bookId] = ReadingProgress(
      bookId: bookId,
      currentChapterIndex: chapterIndex,
      progressPercentage: progressPct,
      lastReadTime: DateTime.now(),
    );
    notifyListeners();
  }

  // Bookmark Management
  List<Bookmark> getBookmarksForBook(String bookId) {
    return _bookmarks.where((bm) => bm.bookId == bookId).toList();
  }

  void addBookmark(Bookmark bookmark) {
    _bookmarks.insert(0, bookmark);
    notifyListeners();
  }

  void removeBookmark(String bookmarkId) {
    _bookmarks.removeWhere((bm) => bm.id == bookmarkId);
    notifyListeners();
  }

  // Reader Settings Controls
  void setReaderFontSize(double size) {
    _readerFontSize = size.clamp(12.0, 32.0);
    notifyListeners();
  }

  void setReaderLineHeight(double height) {
    _readerLineHeight = height.clamp(1.2, 2.5);
    notifyListeners();
  }

  void setReaderTheme(String themeName) {
    _readerTheme = themeName;
    notifyListeners();
  }

  // Reviews & Discussions
  List<Review> getReviews(String bookId) => repository.getReviewsForBook(bookId);

  void submitReview(Review review) {
    repository.addReview(review);
    notifyListeners();
  }

  List<DiscussionThread> getDiscussions({String? bookId}) =>
      repository.getDiscussions(bookId: bookId);

  void createDiscussion(DiscussionThread thread) {
    repository.addDiscussionThread(thread);
    notifyListeners();
  }

  void addCommentToDiscussion(String threadId, DiscussionComment comment) {
    repository.addDiscussionComment(threadId, comment);
    notifyListeners();
  }
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'No AppStateProvider found in context');
    return provider!.notifier!;
  }
}
