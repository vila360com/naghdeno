import 'package:flutter_test/flutter_test.dart';
import 'package:naghdeno/repositories/book_repository.dart';
import 'package:naghdeno/models/book_models.dart';

void main() {
  group('BookRepository Tests', () {
    late BookRepository repository;

    setUp(() {
      repository = BookRepository();
    });

    test('getAllBooks returns non-empty list of books', () {
      final books = repository.getAllBooks();
      expect(books, isNotEmpty);
      expect(books.length, greaterThanOrEqualTo(3));
    });

    test('getBookById returns correct book or null if not found', () {
      final book = repository.getBookById('1');
      expect(book, isNotNull);
      expect(book!.title, 'بوف کور');

      final nonExistentBook = repository.getBookById('invalid_id');
      expect(nonExistentBook, isNull);
    });

    test('addReview adds review to book', () {
      final initialReviews = repository.getReviewsForBook('1');
      final initialCount = initialReviews.length;

      final newReview = Review(
        id: 'test_r1',
        bookId: '1',
        userName: 'تستر',
        userAvatar: '',
        rating: 5.0,
        content: 'نقد تحلیلی تست',
        date: DateTime.now(),
      );

      repository.addReview(newReview);
      final updatedReviews = repository.getReviewsForBook('1');

      expect(updatedReviews.length, equals(initialCount + 1));
      expect(updatedReviews.first.content, equals('نقد تحلیلی تست'));
    });
  });
}
