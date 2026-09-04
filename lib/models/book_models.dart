enum ShelfType {
  currentlyReading,
  read,
  wantToRead,
}

extension ShelfTypeExtension on ShelfType {
  String get label {
    switch (this) {
      case ShelfType.currentlyReading:
        return 'در حال خواندن';
      case ShelfType.read:
        return 'خوانده‌شده';
      case ShelfType.wantToRead:
        return 'می‌خواهم بخوانم';
    }
  }
}

class Chapter {
  final String id;
  final String title;
  final String content;

  Chapter({
    required this.id,
    required this.title,
    required this.content,
  });
}

class Book {
  final String id;
  final String title;
  final String author;
  final String? translator;
  final String coverUrl;
  final String description;
  final String category;
  final double rating;
  final int ratingCount;
  final int totalPages;
  final List<Chapter> chapters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.translator,
    required this.coverUrl,
    required this.description,
    required this.category,
    required this.rating,
    required this.ratingCount,
    required this.totalPages,
    required this.chapters,
  });
}

class Review {
  final String id;
  final String bookId;
  final String userName;
  final String userAvatar;
  final double rating;
  final String content;
  final DateTime date;

  Review({
    required this.id,
    required this.bookId,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.content,
    required this.date,
  });
}

class DiscussionComment {
  final String id;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime date;

  DiscussionComment({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.date,
  });
}

class DiscussionThread {
  final String id;
  final String bookId;
  final String bookTitle;
  final String title;
  final String authorName;
  final String authorAvatar;
  final DateTime date;
  final List<DiscussionComment> comments;

  DiscussionThread({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
    required this.date,
    required this.comments,
  });
}

class ReadingProgress {
  final String bookId;
  final int currentChapterIndex;
  final double progressPercentage;
  final DateTime lastReadTime;

  ReadingProgress({
    required this.bookId,
    this.currentChapterIndex = 0,
    this.progressPercentage = 0.0,
    required this.lastReadTime,
  });

  ReadingProgress copyWith({
    int? currentChapterIndex,
    double? progressPercentage,
    DateTime? lastReadTime,
  }) {
    return ReadingProgress(
      bookId: bookId,
      currentChapterIndex: currentChapterIndex ?? this.currentChapterIndex,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      lastReadTime: lastReadTime ?? DateTime.now(),
    );
  }
}

class Bookmark {
  final String id;
  final String bookId;
  final int chapterIndex;
  final String chapterTitle;
  final String snippet;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.chapterTitle,
    required this.snippet,
    required this.createdAt,
  });
}
